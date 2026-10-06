
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sistem Keuangan Perusahaan',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sistem Keuangan Perusahaan',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor:
            Theme.of(context).colorScheme.primaryContainer,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // Judul Prototype
              const Text(
                'Prototype V0.0',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                'Aplikasi untuk membantu mengelola keuangan '
                'perusahaan yang memiliki usaha Internet dan Kopi.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 20),

              // Informasi Perusahaan
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),

                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),

                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      'Informasi Perusahaan',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 10),

                    Text(
                      'Nama: Perusahaan Usaha Internet & Kopi',
                    ),

                    Text(
                      'Jenis Usaha: Internet dan Kopi',
                    ),

                    Text(
                      'Target Pengguna: Pemilik / Admin',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                'Menu Utama',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              // Menu Internet
              Card(
                child: ListTile(
                  leading: const Icon(
                    Icons.wifi,
                    color: Colors.blue,
                    size: 35,
                  ),

                  title: const Text(
                    'Usaha Internet',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  subtitle: const Text(
                    'Pelanggan, Hotspot/Voucher, PPPoE dan setoran',
                  ),

                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                  ),

                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Menu Usaha Internet dipilih',
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Menu Kopi
              Card(
                child: ListTile(
                  leading: const Icon(
                    Icons.local_cafe,
                    color: Colors.brown,
                    size: 35,
                  ),

                  title: const Text(
                    'Usaha Kopi',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  subtitle: const Text(
                    'Produk, penjualan dan stok kopi',
                  ),

                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                  ),

                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Menu Usaha Kopi dipilih',
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Menu Keuangan
              Card(
                child: ListTile(
                  leading: const Icon(
                    Icons.account_balance_wallet,
                    color: Colors.green,
                    size: 35,
                  ),

                  title: const Text(
                    'Keuangan',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  subtitle: const Text(
                    'Pemasukan, pengeluaran dan saldo perusahaan',
                  ),

                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                  ),

                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Menu Keuangan dipilih',
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Menu Laporan
              Card(
                child: ListTile(
                  leading: const Icon(
                    Icons.bar_chart,
                    color: Colors.orange,
                    size: 35,
                  ),

                  title: const Text(
                    'Laporan',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  subtitle: const Text(
                    'Laporan pemasukan, pengeluaran dan keuntungan',
                  ),

                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                  ),

                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Menu Laporan dipilih',
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),

              // Tombol Prototype
              SizedBox(
                width: double.infinity,

                child: ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Prototype V0.0 siap dikembangkan.',
                        ),
                      ),
                    );
                  },

                  icon: const Icon(Icons.play_arrow),

                  label: const Text(
                    'Mulai Eksplorasi',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


