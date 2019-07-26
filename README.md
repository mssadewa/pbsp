# (Ujicoba) Pusat Bantuan dengan Sistem Pakar menggunakan CLIPS
Pusat Bantuan dengan Sistem Pakar.
Repository ini dimaksudkan untuk melengkapi tugas final exam mata kuliah _expert system_ / _sistem pakar_ 

## Table of Contents :
* [Tree](https://github.com/mssadewa/pbsp#tree)
* [Facts and Rules](https://github.com/mssadewa/pbsp#facts-and-rules)
* [Software Rquirements](https://github.com/mssadewa/pbsp#software-requirements)
* [Langkah - Langkah Instalasi](https://github.com/mssadewa/pbsp#langkah---langkah)

## Tree

<p align=center>
	<img src="https://raw.githubusercontent.com/mssadewa/pbsp/master/ecommerce.png" />
</p>


## Facts and Rules
|Code | Facts |
|:---:|:------|
|F1	| Email terverifikasi.								                            |
|F2	| Password Benar.                                                               |
|F3	| Menerima OTP.                                                                 |
|F4	| OTP benar (_sehingga muncul pesan berhasil login_).                           |
|F5	| Bank tujuan transfer sesuai dengan yang dipilih saat melakukan checkout.      |
|F6	| Identitas pengirim (transfer) sama dengan yang diinput saat checkout.         |
|F7	| Nominal yang ditransfer sesuai dengan yang diinstruksikan e-commerce.         |
|F8	| Status Transaksi.                                                             |
|F9	| sudah 24 jam status tidak berubah.                                            |
|F10 | Lokasi Penjual dan Pembeli 1 pulau?                                          |
|F11 | Pengiriman 1 pulau maksimal 5 hari.                                          |
|F12 | Pengiriman beda pula maksimal 1 minggu.                                      |
|F13 | Barang sudah diterima.                                                       |
|F14 | Kondisi nya sesuai dengan yang tertulis pada judul, deksripsi, maupun gambar.|

|No|Rule Code|Rule|
|:-:|:-:|:--|
"|1|S-0|IF 
domain-maslah = akun OR domain-masalah = pembayaran OR domain-masalah = transaksi 
AND 
F4 = no OR F7 = no OR F14 = yes
THEN S-0|"
"|2|S-1|IF
domain-masalah = akun
AND
F1 = no
THEN S-1|"
"|3|S-2|IF
domain-masalah = akun
AND
F2 = no
THEN S-2|"
"|4|S-3|IF
domain-masalah = akun
AND
F2 = yes
F3 = no
THEN S-3|"
"|5|S-4|IF
domain-masalah = akun
AND
F2 = yes
F3 = yes
F4 = no
THEN S-4|"
"|6|S-6|IF
domain-masalah = pembayaran
AND
F5 = no
THEN S-6|"
"|7|S-7|IF
domain-masalah = pembayaran
AND
F5 = yes
F6 = no
THEN S-7|"
"|8|S-8|IF
domain-masalah = pembayaran
AND
F5 = yes
F6 = yes
F7 = no
THEN S-8|"
"|9|S-9|IF
domain-masalah = transaksi
AND
F8 = terbayar OR F8 diproses
AND
F9  = no
THEN S-9|"
"|10|S-10|IF
domain-masalah = transaksi
AND
F8 = terbayar OR F8 = diproses
AND
F9 = yes
THEN S-10|"
"|11|S-11|IF
domain-masalah = transaksi
AND
F8 = terkirim
AND
F10 = no OR F10 = yes
AND
F11 = no OR F12 = no
THEN S-11|"
"|12|S-12|IF
domain-masalah = transaksi
AND
F8 = terkirim
AND
F10 = yes OR F10 = no
AND F11 = yes OR F12 = yes
THEN S-12|"
"|13|S-13|IF
domain-masalah = transaksi
AND
F8 = sampai
F13 = no
THEN S-13|"
"|14|S-14|IF
domain-masalah = transaksi
AND
F8 = sampai
F13 = yes
F14 = no
THEN S-14|"

## Software Requirements
Clips ( [Windows 32bit](https://sourceforge.net/projects/clipsrules/files/CLIPS/6.30/clips_windows_32_bit_executables_630.msi/download) | [Windows 64bit](https://sourceforge.net/projects/clipsrules/files/CLIPS/6.30/clips_windows_64_bit_executables_630.msi/download) | [Linux](https://sourceforge.net/projects/clipsrules/files/CLIPS/6.30/clips_core_source_630.zip/download) | [Mac OSX](https://sourceforge.net/projects/clipsrules/files/CLIPS/6.30/clips_mac_osx_executables_630.zip/download) )

## Langkah - Langkah
1. Download atau clone repository ini.
2. Buka CLIPSIDE.

<p align="center">
  <img src="https://i.ibb.co/F5cvytg/clips-1.png" alt="Buka aplikasi CLIPS" />
</p>

3. Load File yang tadi didownload. Dengan cara **File** -> **Load**.

<p align="center">
  <img src="https://i.ibb.co/4SpbxnS/clips-3.png" alt="Meload file contoh clips yang sudah didownload"/ >
  <img src="https://i.ibb.co/BqHTcXL/clips-4.png" alt="Pilih file CLIPS"/>
</p>

4. Pastikan output akhir TRUE seperti gambar dibawah.

<p align="center">
  <img src="https://i.ibb.co/rskfrVs/clips-5.png" alt="Pastikan output line akhir bernilai TRUE"/>
</p>

4. Jalankan perintah `(reset)`.

<p align="center">
  <img src="https://i.ibb.co/9tKBfp9/clips-6.png" alt="Reset dahulu"/>
</p>

5. Jalankan perintah `(run)`.

<p align="center">
  <img src="https://i.ibb.co/WpXmxyH/clips-7.png" alt="Untuk eksekusi lakukan RUN"/>
</p>
