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

(defrule pilih-domain-masalah ""
   (not (domain-masalah ?))
   =>
   (assert (domain-masalah 
		(ask-question "Terkait apa masalah anda (akun/pembayaran/transaksi)?"
			akun pembayaran transaksi))))
	   
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

(defrule cek-otp-benar ""
	(domain-masalah akun)
   (password-benar yes)
   =>
   (assert (otp-benar 
		(yes-or-no-p "Apakah berhasil login setelah memasukan OTP (yes/no)?"))))

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
		
(defrule cek-status-transaksi ""
	(domain-masalah transaksi)
	(not (status-transaksi ?))
   =>
   (assert (status-transaksi
		(ask-question "Apakah status transaksi di ecommerce? (terbayar/diproses/terkirim/sampai)?"
			terbayar diproses terkirim sampai))))

(defrule cek-lokasi ""
	(domain-masalah transaksi)
	(status-transaksi terkirim)
   =>
   (assert (lokasi
		(yes-or-no-p "Apakah lokasi anda dengan penjual adalah satu pulau? (yes/no)?"))))

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
