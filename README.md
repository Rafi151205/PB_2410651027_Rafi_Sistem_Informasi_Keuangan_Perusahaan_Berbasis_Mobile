# Sistem Informai keuangan Perusahaan Berbasis Mobile

## Deskripsi
Nama proyek: Sistem Keuangan Perusahaan. 
Tujuan: merancang aplikasi mobile untuk mencatat keuangan usaha internet/ISP dan pengepul kopi green bean. 
Teknologi rencana: Flutter dan Dart. 
Modul utama: Dashboard, Internet/ISP, Pengepul Kopi, Keuangan, Laporan, dan Pengaturan. 
Status: prototype visual v0.0; status database dan fungsi transaksi aktual perlu disesuaikan dengan implementasi proyek yang sebenarnya.

## Identitas
Nama: Muhammad Rafi Amiruddin
NIM: 2410651027

## Versi
v0.0 - Prototype

## Fitur Prototype v0.0
- Menampilkan nama aplikasi
- Menampilkan deskripsi aplikasi
- Menampilkan identitas pengembang
- Menampilkan target pengguna
- Menampilkan tombol interaktif sederhana dengan SnackBar

## Fitur Navigation v0.1

Aplikasi dirancang untuk menampilkan contoh ringkasan dua bidang usaha:
- Internet / ISP
- Pengepul Kopi Green Bean
Data yang tampil masih berupa data demo.
Screen yang tersedia
1. Login / Akses Operator — berisi input email dan kata sandi serta tombol untuk masuk ke aplikasi demo.
2. Dashboard Keuangan — menampilkan ringkasan saldo, pemasukan, pengeluaran, piutang internet, modal pembelian kopi, stok green bean, arus kas, dan aktivitas terbaru.
3. Internet / ISP — menampilkan contoh pelanggan internet, status pembayaran, piutang, serta tombol interaksi untuk pencatatan pembayaran.
4. Pengepul Kopi Green Bean — menampilkan contoh petani/pemasok, jumlah pembelian dalam kilogram, modal pembelian, dan tombol interaksi terkait pembelian.
5. Laporan — menampilkan ringkasan laporan keuangan contoh.
6. Profil — menampilkan profil operator demo dan tombol keluar.

## Fitur Form & Validatuon v0.2

# Sistem Keuangan Perusahaan — BAB 6 Form & Validation v0.2

## Fitur BAB 6
- Form catat setoran pelanggan internet.
- Validasi nama pelanggan wajib diisi dan minimal 3 karakter.
- Pilihan layanan Hotspot Voucher atau PPPoE serta pilihan paket yang menyesuaikan layanan.
- Validasi nominal setoran harus angka dan lebih besar dari 0.
- Form catat pembelian green bean dari petani/pemasok.
- Validasi nama, berat (kg), dan harga per kg; angka harus valid dan lebih besar dari 0.
- Total pembelian dihitung otomatis dari berat × harga per kg menggunakan `setState`.
- Pemilihan tanggal, SnackBar sebagai feedback, dan `dispose()` untuk controller.
- Navigasi BAB 5 tetap tersedia melalui menu utama.

## Menjalankan
1. Buat/buka proyek Flutter.
2. Ganti isi `lib/main.dart` dengan file `lib/main.dart` pada paket ini.
3. Jalankan `flutter pub get`.
4. Jalankan `flutter run`.

## Catatan
Aplikasi ini masih prototype/demo. Data yang diisi belum disimpan ke database atau penyimpanan permanen. SnackBar menyatakan pencatatan demo, bukan transaksi yang sudah tersimpan secara permanen.

## Skenario pengujian
1. Buka menu Internet → Catat pembayaran.
2. Tekan Simpan Setoran dalam keadaan kosong; pesan validasi harus muncul.
3. Masukkan nama kurang dari 3 karakter; validasi nama harus muncul.
4. Masukkan nominal kosong, huruf, atau 0; validasi nominal harus muncul.
5. Isi semua data valid dan pilih layanan/paket; form lolos validasi dan menampilkan SnackBar.
6. Buka menu Kopi → Catat pembelian kopi.
7. Uji nama kosong, berat kosong/teks/0, dan harga kosong/teks/0.
8. Ubah berat dan harga; estimasi total harus berubah otomatis.
9. Isi semua data valid; form lolos validasi dan menampilkan SnackBar.
10. Kembali ke menu utama dan pastikan navigasi Dashboard, Internet, Kopi, Laporan, dan Profil tetap berfungsi.

# Data Module v0.3 — Local/Mock Data dan CRUD Sederhana

## Teknologi

1. Flutter dan Dart

2. Penyimpanan sementara menggunakan List<FinanceRecord>

3. Form dan validasi menggunakan GlobalKey<FormState> dan TextFormField

4. Tampilan daftar menggunakan ListView dan ListTile

## Fitur Aplikasi

- Dashboard: menampilkan penerimaan, pengeluaran, saldo bersih, dan aktivitas terbaru.

- Internet: mengelola pelanggan, paket Hotspot, paket PPPoE, dan setoran.

- Pengepul Kopi: mengelola pemasok, pembelian green bean, stok, dan penjualan ke pabrik.

- Laporan: menampilkan rekap transaksi dan perhitungan keuangan.

- Profil: menampilkan informasi aplikasi dan penyimpanan data.

## Implementasi CRUD

- Create: menambahkan data melalui form.

- Read: menampilkan data dalam daftar.

- Update: mengubah data yang sudah tersimpan.

- Delete: menghapus data melalui konfirmasi.

## Penyimpanan Data

Data dikelola menggunakan List<FinanceRecord> dan dimulai dalam keadaan kosong. Data yang ditampilkan berasal dari input pengguna, bukan data demo.

Penyimpanan masih bersifat sementara di memori aplikasi. Data dapat hilang ketika aplikasi ditutup atau dimulai ulang. Pada tahap ini belum digunakan database permanen.

## Cara Menjalankan
flutter pub get
flutter run -d chrome

## Bukti Running
Screenshot aplikasi berjalan dilampirkan pada LMS pada file PDF.

## Catatan Kendala
Tuliskan kendala yang dialami jika ada.(Sejauh ini Masih Tidak Ada)

## Catatan Penggunaan AI
Saya menggunakan AI untuk Membuat Kode program Prototype v0.0 yang di tempatkan di library pada file main.dart, namun saya tidak hanya meminta AI untuk membuatkan kode tapi juga menjelaskan kode kode itu untuk saya pelajari dan pahami.

