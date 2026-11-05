# CHANGELOG

Tanggal: [06 Oktober 2026]

# v0.0 - Prototype

Perubahan:
- Membuat halaman home/profil sederhana.
- Menambahkan nama aplikasi.
- Menambahkan deskripsi aplikasi.
- Menambahkan identitas pengembang.
- Menambahkan tombol interaktif sederhana.
- Menjalankan aplikasi melalui Flutter Web/Chrome.

Bukti:
- Screenshot running tersedia saya lampirkan di LMS Pada File PDF.
- Commit Git tersedia.

Tanggal: [13 Oktober 2026]

Perubahan:
- Menyusun ide aplikasi dan rancangan awal antarmuka.
- Mendokumentasikan user flow, navigasi, wireframe, UI, design system, dan keputusan desain.
- Mengubah konsep dari penjualan kedai kopi menjadi usaha pengepul green bean, termasuk pemasok, pembelian, stok, dan penjualan ke pabrik.
- Implementasi database, validasi formulir, perhitungan transaksi, stok, laporan, dan pengujian aksesibilitas.

Bukti:
- Ada dalam satu folder bisa di ekstrak dahulu dan di cek.


Tanggal: [20 Oktober 2026]

# Navigation v0.1

Ditambahkan
- Screen Login / Akses Operator untuk masuk ke aplikasi demo.
- Screen Dashboard Keuangan untuk menampilkan ringkasan contoh dua bidang usaha.
- Screen Internet / ISP dengan contoh data pelanggan dan status pembayaran.
- Screen Pengepul Kopi Green Bean dengan contoh data petani/pemasok dan pembelian.
- Screen Laporan dan Profil.
- Navigasi bawah untuk berpindah antara Beranda, Internet, Kopi, Laporan, dan Profil.
- Event handling pada tombol dan aksi pengguna.
- Input sederhana menggunakan TextField.
- Respons aksi pengguna menggunakan SnackBar.
- README dan CHANGELOG untuk dokumentasi milestone Navigation v0.1.
Catatan
- Data masih berupa data demo.
- Login belum terhubung ke autentikasi server.
- Database, API, dan penyimpanan transaksi belum diterapkan.
- Pengujian navigasi dan interaksi perlu dilakukan pada perangkat atau Chrome, lalu dilengkapi screenshot/video sebagai evidence praktikum.

Tanggal: [28 Oktober 2026]

# v0.2 — Form & Validation (BAB 6)
- Menambahkan form pencatatan setoran pelanggan internet.
- Menambahkan pilihan jenis layanan Hotspot Voucher dan PPPoE beserta pilihan paket.
- Menambahkan validasi field wajib, panjang nama minimal, angka valid, dan nilai harus lebih besar dari nol.
- Menambahkan form pembelian kopi green bean dari petani/pemasok.
- Menambahkan kalkulasi total pembelian otomatis berdasarkan berat dan harga per kg.
- Menambahkan pemilihan tanggal transaksi.
- Menambahkan feedback menggunakan SnackBar untuk validasi dan simulasi penyimpanan.
- Menggunakan `Form`, `GlobalKey<FormState>`, `TextFormField`, `validator`, `TextEditingController`, `StatefulWidget`, `setState`, dan `dispose()`.
- Menghubungkan tombol Catat Pembayaran dan Catat Pembelian Kopi ke halaman form.
- Menjaga struktur navigasi utama dari BAB 5.
- Data masih berupa prototype dan belum terhubung database.

Tanggal: [03 November 2026]


# Data Module v0.3

## Tambahan

- Model data FinanceRecord.

- Penyimpanan sementara menggunakan List.

- Daftar pelanggan, paket, setoran, pemasok, pembelian, penjualan, dan pengeluaran.

- Fitur Create, Read, Update, dan Delete.

- Dialog konfirmasi sebelum menghapus data.

- Empty state ketika daftar belum memiliki data.

- Pesan informasi menggunakan SnackBar.

- Perhitungan penerimaan, pengeluaran, saldo bersih, dan stok kopi.

## Pengggantian

- Data awal dibuat kosong tanpa data demo.

- Dashboard dan laporan menggunakan sumber perhitungan transaksi yang sama.

- Pengelompokan data disesuaikan dengan usaha internet dan pengepul kopi green bean.

## Catatan

Penyimpanan masih menggunakan List di memori dan belum menggunakan database permanen.

Penghapusan paket Hotspot/PPPoE dan pengelolaan pengeluaran dari halaman Laporan perlu diperiksa kembali.

Validasi agar penjualan kopi tidak melebihi stok perlu ditambahkan.

Pengujian CRUD menyeluruh harus dilakukan sebelum rilis.