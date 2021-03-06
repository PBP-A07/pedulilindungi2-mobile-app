# pedulilindungi2.0

[![Pre-Release](https://github.com/PBP-A07/pedulilindungi2-mobile-app/actions/workflows/pre-release.yml/badge.svg)](https://github.com/PBP-A07/pedulilindungi2-mobile-app/actions/workflows/pre-release.yml)
[![Release](https://github.com/PBP-A07/pedulilindungi2-mobile-app/actions/workflows/release.yml/badge.svg)](https://github.com/PBP-A07/pedulilindungi2-mobile-app/actions/workflows/release.yml)

## Kelompok A07

1. 2006595892 Erick Ezrandy
2. 2006523413 Alifiyah Nur Rochmah Ariandri
3. 2006534764 Rayyan Azka Ihsanuddin
4. 2006530141 Rakha Rayhan Nusyura
5. 2006526812 Stefanus Ndaru Wedhatama
6. 2006527222 Andini Putri Pramudya Wardani
7. 2006525330 Ridjky Tegar Perkasa

## APK Link

[pedulilindungi2.0-mobile-app](https://github.com/PBP-A07/pedulilindungi2-mobile-app/releases)

## Latar Belakang

Untuk mengendalikan Pandemi Covid-19, pemerintah sedang menggencarkan program vaksinasi. Saat ini, pendaftaran vaksinasi bisa dilakukan secara online, namun terpisah antara satu penyelenggara dengan penyelenggara lainnya. Hal ini menyebabkan masyarakat bingung karena informasi tidak terpusat. Melihat fenomena tersebut, kami berinisiatif untuk mencoba membuat website yang dapat mengumpulkan semua penyelenggara vaksin ke dalam satu website sehingga masyarakat dapat lebih mudah untuk melihat daftar-daftar vaksin dan waktu vaksin yang tersedia. Dengan adanya website ini, kami harap dapat membantu masyarakat, penyedia vaksin, dan pemerintah untuk bersama-sama meningkatkan laju vaksinasi sehingga pandemi lebih cepat berakhir.

## Modul Implementasi

1. Home page dan Form Pertanyaan<br>
   2006523413 Alifiyah Nur Rochmah Ariandri<br>
   Halaman homepage dan forum untuk mengirimkan pertanyaan agar bisa dijawab oleh user-user lain, tidak hanya admin saja.

2. Sign up, Log in, dan Log out<br>
   2006525330 Ridjky Tegar Perkasa<br>
   Halaman sign up penyedia dan penerima yang menerima masukan email, username, password, dan radio button yang berisi pilihan peran (penerima atau penyedia). Selain itu, terdapat implementasi log out juga yang dapat diakses melalui navbar. Selain itu, terdapat pula laman yang menampilkan bagaimana tahapan-tahapan untuk melakukan pendaftaran.

3. Input Biodata Penerima dan Penyedia<br>
   2006595892 Erick Ezrandy<br>
   Halaman biodata penerima yang berisi data seperti nama lengkap, NIK, umur, jenis kelamin, nomor HP, dan alamat. Halaman biodata penyedia yang berisi data seperti nama instansi, kota, nomor telepon, dan alamat.

4. Profil Penerima<br>
   2006526812 Stefanus Ndaru Wedhatama<br>
   Halaman profil yang menampilkan data-data penerima yang sudah terisi saat mengedit biodata. Kita dapat mengedit beberapa data yang sudah ada tersebut. Selain itu, juga ada halaman untuk melihat dan membatalkan tiket vaksin yang sudah dipilih.

5. Profil Penyedia<br>
   2006530141 Rakha Rayhan Nusyura<br>
   Halaman profil yang menampilkan data-data penyedia yang sudah terisi saat mengedit biodata. Kita dapat mengedit beberapa data yang sudah ada tersebut. Selain itu, juga ada halaman untuk melihat pendaftar berdasarkan jadwal.

6. Pendaftaran Vaksin<br>
   2006527222 Andini Putri Pramudya Wardani<br>
   Halaman untuk melakukan pendaftaran vaksin (khusus bagi penerima). Berikut merupakan fitur pada halaman ini:<br>

- Dropdown untuk memilih penyedia vaksin. Setelah itu tampilkan data-data rinci dari penyedia yang telah terpilih.
- Dropdown untuk memilih sesi vaksin.
  Note: <br>
- Jika kuota pada suatu sesi habis, sesinya hilang dari dropdown.
- Jika kuota semua sesi habis, penyedia vaksin hilang dari dropdown.

7. Penambahan Vaksin<br>
   2006534764 Rayyan Azka Ihsanuddin<br>
   Halaman untuk menambahkan vaksin (khusus bagi penyedia). Berikut merupakan fitur dari halaman ini:<br>

- Terdapat kuota untuk penyelenggara (per sesi).
- Jenis vaksin (dalam bentuk dropdown).
- Sesi (waktu & tanggal).

## Persona

1. Penerima: masyarakat umum yang ingin melakukan vaksinasi.
2. Penyedia: organisasi penyedia vaksin dan tempat melakukan vaksinasi.
3. Admin: memvalidasi data pengguna.

## Credit

Workflow dari project ini mengacu pada gist [ini](https://gist.github.com/determinedguy/68b9a39b49099222f7c4b12eb617c643).
