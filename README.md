# (Ujicoba) Pusat Bantuan dengan Sistem Pakar menggunakan CLIPS
Pusat Bantuan dengan Sistem Pakar.
Repository ini dimaksudkan untuk melengkapi tugas final exam mata kuliah _expert system_ / _sistem pakar_ 

## Table of Contents :
* [Facts and Rules](#)
* [D-Tree](#)
* [Software Rquirements](https://github.com/mssadewa/pbsp#software-requirements)
* [Langkah - Langkah Instalasi](https://github.com/mssadewa/pbsp#langkah---langkah)


## Facts and Rules
F1	= Email terverifikasi.
F2	= Password Benar.
F3	= Menerima OTP.
F4	= OTP benar (_sehingga muncul pesan berhasil login_).
F5	= Bank tujuan transfer sesuai dengan yang dipilih saat melakukan checkout.
F6	= Identitas pengirim (transfer) sama dengan yang diinput saat checkout.
F7	= Nominal yang ditransfer sesuai dengan yang diinstruksikan e-commerce.
F8	= Status Transaksi.
F9	= sudah 24 jam status tidak berubah.
F10 = Lokasi Penjual dan Pembeli 1 pulau?
F11 = Pengiriman 1 pulau maksimal 5 hari.
F12 = Pengiriman beda pula maksimal 1 minggu.
F13 = Barang sudah diterima.
F14 = Kondisi nya sesuai dengan yang tertulis pada judul, deksripsi, maupun gambar.

## Tree

<p align=center>
	<img src="https://i.ibb.co/HPvLcNC/ecommerce.png" />
</p>


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
