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

	   
(defrule cek-email-terverifikasi ""
	(domain-masalah akun)
   (not (email-terverifikasi ?))
   =>
   (assert (email-terverifikasi 
		(yes-or-no-p "Apakah anda sudah melakukan verifikasi (yes/no)?"))))
		
(defrule cek-password-benar ""
	(domain-masalah akun)
   (email-terverifikasi yes)
   =>
   (assert (password-benar 
		(yes-or-no-p "Apakah muncul form OTP (yes/no)?"))))

(defrule cek-terima-otp""
	(domain-masalah akun)
	(password-benar yes)
   =>
   (assert (terima-otp
		(yes-or-no-p "Apakah anda menerima OTP (yes/no)?"))))

(defrule cek-otp-benar ""
	(domain-masalah akun)
   (terima-otp yes)
   =>
   (assert (otp-benar 
		(yes-or-no-p "Apakah berhasil login setelah memasukan OTP (yes/no)?"))))


;
;	Domain masalah "pembayaran"
;

(defrule cek-bank-benar ""
	(domain-masalah pembayaran)
   (not (bank-benar ?))
   =>
   (assert (bank-benar 
		(yes-or-no-p "Apakah bank yang anda pilih sama dengan bank tujuan transfer (yes/no)?"))))

(defrule cek-pengirim-benar ""
	(domain-masalah pembayaran)
   (bank-benar yes)
   =>
   (assert (pengirim-benar 
		(yes-or-no-p "Apakah informasi pengirim sesuai dengan yang anda input diawal? (yes/no)?"))))		
		
(defrule cek-nominal-benar ""
	(domain-masalah pembayaran)
   (pengirim-benar yes)
   =>
   (assert (nominal-benar
		(yes-or-no-p "Apakah nominal yang anda transfer sesuai dengan yang diinstruksikan (yes/no)?"))))

;
;	Domain masalah "Transaksi"
;
		
(defrule cek-status-transaksi ""
	(domain-masalah transaksi)
	(not (status-transaksi ?))
   =>
   (assert (status-transaksi
		(ask-question "Apakah status transaksi di ecommerce? (terbayar/diproses/terkirim/sampai)?"
			terbayar diproses terkirim sampai))))

(defrule cek-lebih-24jam ""
	(domain-masalah transaksi)
	(or (status-transaksi terbayar)
	(status-transaksi diproses))
   =>
   (assert (lebih-24jam
		(yes-or-no-p "Apakah status nya sudah lebih dari 24 jam (yes/no)?"))))

(defrule cek-1-pulau ""
	(domain-masalah transaksi)
	(status-transaksi terkirim)
   =>
   (assert (penjual-pembeli-1-pulau
		(yes-or-no-p "Apakah lokasi anda dengan penjual adalah satu pulau (yes/no)?"))))

(defrule cek-lebih-5hari ""
	(domain-masalah transaksi)
	(status-transaksi terkirim)
	(penjual-pembeli-1-pulau no)
   =>
   (assert (lebih-5hari
		(yes-or-no-p "Apakah pengiriman sudah lebih dari 5 hari (yes/no)?"))))

(defrule cek-lebih-1minggu ""
	(domain-masalah transaksi)
	(status-transaksi terkirim)
	(penjual-pembeli-1-pulau yes)
   =>
   (assert (lebih-1minggu
		(yes-or-no-p "Apakah pengiriman sudah lebih dari 1 minggu (yes/no)?"))))

(defrule cek-barang-sampai ""
	(domain-masalah transaksi)
	(status-transaksi sampai)
   =>
   (assert (barang-sampai
		(yes-or-no-p "Apakah anda sudah menerima barang? (yes/no)?"))))

(defrule cek-kondisi-sesuai ""
	(domain-masalah transaksi)
	(status-transaksi terkirim)
	(barang-sampai yes)
   =>
   (assert (kondisi-sesuai
		(yes-or-no-p "Apakah barang yang anda terima sudah sesuai deskripsi dan dengan kondisi baik? (yes/no)?"))))
		


		


(defrule system-banner ""
  (declare (salience 10))
  =>
  (printout t crlf crlf)
  (printout t "Pusat Bantuan dengan Expert System")
  (printout t crlf crlf))
