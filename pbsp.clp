;==============================================================
;
;
;	[Ujicoba] Pusat Bantuan E-Commerce menggunakan Sistem Pakar
;
;
;==============================================================

(deffunction ask-question (?question $?allowed-values)
   (printout t ?question)
   (bind ?answer (read))
   (if (lexemep ?answer) 
       then (bind ?answer (lowcase ?answer)))
   (while (not (member ?answer ?allowed-values)) do
      (printout t ?question)
      (bind ?answer (read))
      (if (lexemep ?answer) 
          then (bind ?answer (lowcase ?answer))))
   ?answer)

(deffunction yes-or-no-p (?question)
   (bind ?response (ask-question ?question yes no y n))
   (if (or (eq ?response yes) (eq ?response y))
       then yes 
       else no))

;
;	Kuisioner untuk mendapatkan fakta
;


(defrule pilih-domain-masalah ""
   (not (domain-masalah ?))
   =>
   (assert (domain-masalah 
		(ask-question "Terkait apa masalah anda (akun/pembayaran/transaksi)?"
			akun pembayaran transaksi))))


;
;	Domain masalah "Akun"
;

	   
(defrule cek-F1 "Cek apakah email terverifikasi"
	(domain-masalah akun)
	(not (F1 ?))
	=>
	(assert (F1
		(yes-or-no-p "Apakah anda sudah melakukan verifikasi (yes/no)?"))))
		
(defrule cek-F2 "Cek apakah password benar"
	(domain-masalah akun)
	(F1 yes)
	=>
	(assert (F2 
		(yes-or-no-p "Apakah muncul form OTP (yes/no)?"))))

(defrule cek-F3 "Cek apakah user menerima OTP"
	(domain-masalah akun)
	(F2 yes)
	=>
	(assert (F3
		(yes-or-no-p "Apakah anda menerima OTP (yes/no)?"))))

(defrule cek-F4 "Cek apakah user dapat login"
	(domain-masalah akun)
	(F3 yes)
	=>
	(assert (F4
		(yes-or-no-p "Apakah berhasil login setelah memasukan OTP (yes/no)?"))))


;
;	Domain masalah "pembayaran"
;

(defrule cek-F5 "Cek bank yang ditransfer sesuai dengan yang dipilih diawal saat checkout."
	(domain-masalah pembayaran)
	(not (F5 ?))
	=>
	(assert (F5
		(yes-or-no-p "Apakah bank yang anda pilih sama dengan bank tujuan transfer (yes/no)?"))))

(defrule cek-F6 "Cek identitas rek pengirim sama dengan yang ditulis saat checkout."
	(domain-masalah pembayaran)
	(F5 yes)
	=>
	(assert (F6
		(yes-or-no-p "Apakah informasi pengirim sesuai dengan yang anda input diawal? (yes/no)?"))))		
		
(defrule cek-F7 "Cek nominal sesuai dengan yang e-commerce instruksikan."
	(domain-masalah pembayaran)
	(F6 yes)
	=>
	(assert (F7
		(yes-or-no-p "Apakah nominal yang anda transfer sesuai dengan yang diinstruksikan (yes/no)?"))))

;
;	Domain masalah "Transaksi"
;
		
(defrule cek-F8 "Cek status transaksi saat ini."
	(domain-masalah transaksi)
	(not (F8 ?))
   =>
   (assert (F8
		(ask-question "Apakah status transaksi di ecommerce? (terbayar/diproses/terkirim/sampai)?"
			terbayar diproses terkirim sampai))))

(defrule cek-F9 "Cek perubahan status sudah lebih dari 24 jam."
	(domain-masalah transaksi)
	(or (F8 terbayar)
	(F8 diproses))
   =>
   (assert (F9
		(yes-or-no-p "Apakah status nya sudah lebih dari 24 jam (yes/no)?"))))

(defrule cek-F10 "Cek apakah lokasi penjual dan pembeli 1 pulau"
	(domain-masalah transaksi)
	(F8 terkirim)
   =>
   (assert (F10
		(yes-or-no-p "Apakah lokasi anda dengan penjual adalah satu pulau (yes/no)?"))))

(defrule cek-F11 "Cek pengiriman sudah lebih dari 5 hari."
	(domain-masalah transaksi)
	(F8 terkirim)
	(F10 yes)
   =>
   (assert (F11
		(yes-or-no-p "Apakah pengiriman sudah lebih dari 5 hari (yes/no)?"))))

(defrule cek-F12 "Cek pengiriman luar pulau lebih dari 1 minggu"
	(domain-masalah transaksi)
	(F8 terkirim)
	(F10 no)
   =>
   (assert (F12
		(yes-or-no-p "Apakah pengiriman sudah lebih dari 1 minggu (yes/no)?"))))

(defrule cek-F13 "Cek user sudah menerima barang."
	(domain-masalah transaksi)
	(F8 sampai)
   =>
   (assert (F13
		(yes-or-no-p "Apakah anda sudah menerima barang? (yes/no)?"))))

(defrule cek-F14 "Cek barang sudah diterima dengan  kondisi sesuai."
	(domain-masalah transaksi)
	(F8 sampai)
	(F13 yes)
   =>
   (assert (F14
		(yes-or-no-p "Apakah barang yang anda terima sudah sesuai deskripsi dan dengan kondisi baik? (yes/no)?"))))
		

;
;
;	Kesimpulan & Resolusi
;
;

(defrule S-0 "Kesimpulan dan Solusi jika tidak ada masalah."
	(domain-masalah akun)
	(or (F4 no)(F7 no)(F14 yes))
	(not (kesimpulan-solusi ?))
	=>
	(assert (kesimpulan-solusi "Seharusnya tidak ada masalah, namun jika masih merasa tidak sesuai silahkan hubungi CS.")))
	
(defrule S-1 "Kesimpulan & Solusi jika akun belum melakukan verifikasi email sehingga tidak dapat login."
	(domain-masalah akun)
	(F1 no)
	(not (kesimpulan-solusi ?))
	=>
	(assert (kesimpulan-solusi "Untuk dapat login, email anda harus verifikasi email terlebih dahulu. Cara melakukan verifikasi dapat klik disini.")))

(defrule S-2 "Kesimpulan & Solusi jika password yang dimasukan tidak sesuai dengan email yang dimasukan."
	(domain-masalah akun)
	(F2 no)
	(not (kesimpulan-solusi ?))
	=>
	(assert (kesimpulan-solusi "Password anda tidak sesuai dengan email yang anda masukan. Silahkan lakukan reset password dengan klik disini.")))	

(defrule S-3 "Kesimpulan & Solusi jika user tidak menerima OTP."
	(domain-masalah akun)
	(F2 yes)
	(F3 no)
	(not (kesimpulan-solusi ?))
	=>
	(assert (kesimpulan-solusi "No HP yang anda daftarkan mungkin tidak sesuai dengan yang anda gunakan saat ini.")))	

(defrule S-4 "Kesimpulan & Solusi jika user tidak sesuai dengan OTP yang dikirim ke hp."
	(domain-masalah akun)
	(F2 yes)
	(F3 yes)
	(F4 no)
	(not (kesimpulan-solusi ?))
	=>
	(assert (kesimpulan-solusi "OTP yang anda masukan tidak sesuai dengan yang kami kirim, Pastikan itu OTP terbaru yang kami kirim.")))
	
(defrule S-6 "Kesimpulan & Solusi jika user mengirim ke bank tujuan berbeda dengan bank yang dipilih."
	(domain-masalah pembayaran)
	(F5 no)
	(not (kesimpulan-solusi ?))
	=>
	(assert (kesimpulan-solusi "Seharusnya bank tujuan sama dengan yang anda pilih pada saat checkout. Hubungi CS untuk bantuan lebih lanjut.")))
	
(defrule S-7 "Kesimpulan & Solusi jika user mengirim dengan identitas pengirim berbeda dengan saat checkout."
	(domain-masalah pembayaran)
	(F5 yes)
	(F6 no)
	(not (kesimpulan-solusi ?))
	=>
	(assert (kesimpulan-solusi "Sistem tidak dapat memverifikasi pembayaran secara otomatis jika anda menginput identitas pengirim berbeda dengan yang anda gunakan transfer. Hubungi CS untuk bantuan lebih lanjut.")))
	
(defrule S-8 "Kesimpulan & Solusi jika nominal transfer berbeda dari yang diinstruksikan."
	(domain-masalah pembayaran)
	(F5 yes)
	(F6 yes)
	(F7 no)
	(not (kesimpulan-solusi ?))
	=>
	(assert (kesimpulan-solusi "Sistem tidak dapat memverifikasi pembayaran secara otomatis jika nominal yang anda transfer tidak sesuai dengan yang kami instruksikan. Hubungi CS untuk bantuan lebih lanjut.")))
	
(defrule S-9 "Kesimpulan & Solusi jika status terbayar belum sampai 24 jam."
	(domain-masalah transaksi)
	(F8 terbayar)
	(F9 no)
	(not (kesimpulan-solusi ?))
	=>
	(assert (kesimpulan-solusi "Penjual memiliki waktu 24 jam setelah menerima pesanan anda, Jika dalam 24 jam tidak diproses maka akan dibatalkan otomatis oleh sistem.")))
	
(defrule S-10 "Kesimpulan & Solusi jika status terbayar namun sampai 24 jam tidak batal otomatis."
	(domain-masalah transaksi)
	(F8 terbayar)
	(F9 yes)
	(not (kesimpulan-solusi ?))
	=>
	(assert (kesimpulan-solusi "Seharusnya transaksi anda sudah dibatalkan secara otomatis oleh sistem dan dana dikembalikan ke saldo akun anda. Jika masih bermasalah silahkan hub CS.")))
	
(defrule S-11 "Kesimpulan & Solusi jika status terkirim dan masih dalam waktu normal."
	(domain-masalah transaksi)
	(or (F10 yes)(F10 no))
	(or (F11 no)(F12 no))
	(not (kesimpulan-solusi ?))
	=>
	(assert (kesimpulan-solusi "Dimohon untuk bersabar karena pengiriman memakan waktu maksimal 5 hari untuk sepulau dan 1 minggu untuk luar pulau.")))
	
(defrule S-12 "Kesimpulan & Solusi jika status terkirim namun sudah melebihi waktu normal."
	(domain-masalah transaksi)
	(or (F10 yes)(F10 no))
	(or (F11 yes)(F12 yes))
	(not (kesimpulan-solusi ?))
	=>
	(assert (kesimpulan-solusi "Seharusnya pesanan anda sudah tiba, Silahkan hub CS pengiriman yang anda pilih lalu informasikan no resi nya.")))
	
(defrule S-13 "Kesimpulan & Solusi jika status sampai namun belum menerima."
	(domain-masalah transaksi)
	(F8 sampai)
	(F13 no)
	(not (kesimpulan-solusi ?))
	=>
	(assert (kesimpulan-solusi "Dana tidak anda tidak akan diteruskan ke penjual, Penjual akan membantu anda claim garasnsi pengiriman.")))
	
(defrule S-14 "Kesimpulan & Solusi jika status sampai namun tidak sesuai deskripsi."
	(domain-masalah transaksi)
	(F8 sampai)
	(F13 yes)
	(F14 no)
	(not (kesimpulan-solusi ?))
	=>
	(assert (kesimpulan-solusi "Moderasi penjual dan pembeli dibuka, dana anda akan kami amankan. Kami akan menjadi penengah masalah ini.")))

(defrule system-banner ""
  (declare (salience 10))
  =>
  (printout t crlf crlf)
  (printout t "Pusat Bantuan dengan Expert System")
  (printout t crlf crlf))
  
(defrule print-kesimpulan-solusi ""
  (declare (salience 10))
  (kesimpulan-solusi ?item)
  =>
  (printout t crlf crlf)
  (printout t "kesimpulan dan solusi:")
  (printout t crlf crlf)
  (format t " %s%n%n%n" ?item))
