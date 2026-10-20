import 'package:flutter/material.dart';

void main() => runApp(const FinanceApp());

const Color navy = Color(0xFF172F4D);
const Color pageBg = Color(0xFFF4F6F9);
const Color muted = Color(0xFF718096);
const Color green = Color(0xFF17805B);
const Color red = Color(0xFFD43D4D);
const Color brown = Color(0xFF895C3B);
const Color line = Color(0xFFE1E7EF);

class FinanceApp extends StatelessWidget {
  const FinanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sistem Keuangan Perusahaan',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: pageBg,
        colorScheme: ColorScheme.fromSeed(seedColor: navy),
        fontFamily: 'Roboto',
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: navy,
        ),
      ),
      home: const LoginScreen(),
    );
  }
}

InputDecoration inputDecoration(String hint, IconData icon) {
  return InputDecoration(
    hintText: hint,
    hintStyle: const TextStyle(fontSize: 11),
    prefixIcon: Icon(icon, size: 16),
    contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: line),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: line),
    ),
  );
}

BoxDecoration cardDecoration() => BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: line),
    );

void showMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
  );
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController =
      TextEditingController(text: 'operator@usahakita.id');
  final TextEditingController passwordController =
      TextEditingController(text: 'demokeuangan');
  bool showPassword = false;
  bool rememberAccount = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 10, 16, 8),
              child: Row(
                children: [
                  Text('09.41', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700)),
                  Spacer(),
                  Icon(Icons.battery_5_bar, size: 13, color: navy),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      color: navy,
                      padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('LOGIN PAGE', style: TextStyle(color: Colors.white70, fontSize: 9)),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(9)),
                                child: const Icon(Icons.account_balance_wallet_outlined, color: navy),
                              ),
                              const SizedBox(width: 10),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('INTERNET / ISP', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                                  SizedBox(height: 4),
                                  Text('PENGEPUL KOPI', style: TextStyle(color: Colors.white70, fontSize: 9)),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const Text('Sistem Keuangan\nPerusahaan', style: TextStyle(color: Colors.white, fontSize: 22, height: 1.2, fontWeight: FontWeight.w800)),
                          const SizedBox(height: 10),
                          const Text('Catatan dua usaha, satu tempat. Kendalikan kas, tagihan dan stok dengan lebih terarah.', style: TextStyle(color: Color(0xFFD1DCE9), fontSize: 10, height: 1.5)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 18, 16, 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text('Selamat datang', style: TextStyle(color: navy, fontSize: 17, fontWeight: FontWeight.w800)),
                          const SizedBox(height: 8),
                          const Text('Masuk sebagai operator untuk meninjau data contoh usaha.', style: TextStyle(color: muted, fontSize: 10, height: 1.5)),
                          const SizedBox(height: 16),
                          const Text('Email operator *', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700)),
                          const SizedBox(height: 6),
                          TextField(controller: emailController, style: const TextStyle(fontSize: 11), decoration: inputDecoration('operator@usahakita.id', Icons.mail_outline)),
                          const SizedBox(height: 10),
                          const Text('Kata sandi *', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700)),
                          const SizedBox(height: 6),
                          TextField(
                            controller: passwordController,
                            obscureText: !showPassword,
                            style: const TextStyle(fontSize: 11),
                            decoration: InputDecoration(
                              hintText: 'Kata sandi',
                              hintStyle: const TextStyle(fontSize: 11),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: line)),
                              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: line)),
                              suffixIcon: IconButton(
                                icon: Icon(showPassword ? Icons.visibility : Icons.visibility_off, size: 16),
                                onPressed: () => setState(() => showPassword = !showPassword),
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text('Akun contoh tersedia untuk peninjauan desain.', style: TextStyle(fontSize: 9, color: muted)),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              SizedBox(
                                width: 22,
                                height: 22,
                                child: Checkbox(
                                  value: rememberAccount,
                                  onChanged: (value) => setState(() => rememberAccount = value ?? false),
                                  visualDensity: VisualDensity.compact,
                                  activeColor: navy,
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Text('Gunakan akun contoh', style: TextStyle(fontSize: 9)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            height: 38,
                            child: FilledButton(
                              style: FilledButton.styleFrom(backgroundColor: navy, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                              onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MainShell())),
                              child: const Text('➜  Masuk ke data demo', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(color: const Color(0xFFEAF0F7), borderRadius: BorderRadius.circular(8)),
                            child: const Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.info_outline, size: 13, color: navy),
                                SizedBox(width: 6),
                                Expanded(child: Text('Data demo · Belum terhubung database. Tidak ada autentikasi server atau pembayaran aktif.', style: TextStyle(fontSize: 9, color: navy, height: 1.4))),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Center(child: Text('Akses contoh untuk pemilik dan operator usaha', style: TextStyle(fontSize: 8, color: muted))),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(height: 4, width: 100, margin: const EdgeInsets.only(bottom: 6, top: 4), decoration: BoxDecoration(color: navy, borderRadius: BorderRadius.circular(4)),
            ),
          ],
        ),
      ),
    );
  }
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int selectedIndex = 0;
  late final List<Widget> pages = [
    DashboardScreen(onNavigate: changeTab),
    const InternetScreen(),
    const CoffeeScreen(),
    const ReportScreen(),
    const ProfileScreen(),
  ];

  void changeTab(int index) => setState(() => selectedIndex = index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: selectedIndex, children: pages),
      bottomNavigationBar: NavigationBar(
        height: 62,
        selectedIndex: selectedIndex,
        onDestinationSelected: changeTab,
        backgroundColor: Colors.white,
        indicatorColor: const Color(0xFFE6EDF6),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Beranda'),
          NavigationDestination(icon: Icon(Icons.wifi), label: 'Internet'),
          NavigationDestination(icon: Icon(Icons.coffee_outlined), selectedIcon: Icon(Icons.coffee), label: 'Kopi'),
          NavigationDestination(icon: Icon(Icons.analytics_outlined), label: 'Laporan'),
          NavigationDestination(icon: Icon(Icons.person_outline), label: 'Profil'),
        ],
      ),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  final ValueChanged<int> onNavigate;
  const DashboardScreen({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 18),
          children: [
            const StatusRow(),
            const SizedBox(height: 12),
            const Text('UI 02 / RINGKASAN', style: TextStyle(fontSize: 9, color: muted)),
            Row(
              children: [
                const Expanded(child: Text('Dashboard keuangan', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: navy))),
                IconButton(onPressed: () => showMessage(context, 'Belum ada notifikasi baru'), icon: const Icon(Icons.notifications_none, size: 21, color: navy)),
              ],
            ),
            const Text('Halo, Rina · 1–12 Okt 2026', style: TextStyle(fontSize: 11, color: muted)),
            const SizedBox(height: 4),
            const Text('Data demo · Belum terhubung database', style: TextStyle(fontSize: 9, color: muted)),
            const SizedBox(height: 14),
            const StaticTabs(labels: ['Semua usaha', 'Internet', 'Kopi']),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(color: navy, borderRadius: BorderRadius.circular(12)),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Saldo kas · semua usaha', style: TextStyle(color: Colors.white70, fontSize: 10)),
                  SizedBox(height: 6),
                  Text('Rp11.150.000', style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w800)),
                  SizedBox(height: 6),
                  Text('Awal Rp10.000.000 + arus bersih Rp1.150.000', style: TextStyle(color: Colors.white70, fontSize: 9)),
                ],
              ),
            ),
            const SizedBox(height: 14),
            const Text('Posisi periode ini', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: navy)),
            const SizedBox(height: 8),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 1.55,
              children: const [
                MetricCard(title: 'Pemasukan kas', value: 'Rp9.850.000', subtitle: 'Internet + kopi', color: green),
                MetricCard(title: 'Pengeluaran kas', value: 'Rp8.700.000', subtitle: 'Pembelian + biaya', color: red),
                MetricCard(title: 'Piutang internet', value: 'Rp350.000', subtitle: '2 pelanggan · 12 Okt', color: red),
                MetricCard(title: 'Modal pembelian kopi', value: 'Rp8.000.000', subtitle: '200 kg · periode ini', color: brown),
                MetricCard(title: 'Stok green bean', value: '120 kg', subtitle: 'Persediaan Rp4.800.000', color: brown),
                MetricCard(title: 'Omzet dua usaha', value: 'Rp10.100.000', subtitle: 'Pendapatan, bukan kas', color: navy),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: const Color(0xFFE7F5EE), borderRadius: BorderRadius.circular(10)),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [Expanded(child: Text('Keuntungan gabungan', style: TextStyle(color: muted, fontSize: 10))), Text('Rp2.200.000', style: TextStyle(color: green, fontWeight: FontWeight.w800, fontSize: 14))]),
                  SizedBox(height: 6),
                  Text('Internet Rp700.000 + kopi Rp1.500.000 · setelah HPP dan biaya', style: TextStyle(color: green, fontSize: 9)),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(children: [const Expanded(child: Text('Arus kas gabungan', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: navy))), TextButton(onPressed: () => onNavigate(3), child: const Text('Laporan →', style: TextStyle(fontSize: 10)))]),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: cardDecoration(),
              child: Column(
                children: [
                  const Align(alignment: Alignment.centerLeft, child: Text('1–12 Okt 2026 · satuan juta rupiah', style: TextStyle(fontSize: 9, color: muted))),
                  const SizedBox(height: 10),
                  const Row(children: [StatusPill('Kas masuk', green), SizedBox(width: 8), StatusPill('Kas keluar', red)]),
                  const SizedBox(height: 10),
                  SizedBox(height: 120, child: Row(crossAxisAlignment: CrossAxisAlignment.end, mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [barChart('0,25', .22, green), barChart('8,00', .78, red), barChart('9,60', .94, green), barChart('0,70', .25, red)])),
                  const SizedBox(height: 6),
                  const Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [Text('1–6 Okt', style: TextStyle(fontSize: 8, color: muted)), Text('7–12 Okt', style: TextStyle(fontSize: 8, color: muted))]),
                ],
              ),
            ),
            const SizedBox(height: 14),
            const Text('Ruang usaha', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: navy)),
            const SizedBox(height: 8),
            Container(
              decoration: cardDecoration(),
              child: Column(
                children: [
                  BusinessLink(icon: Icons.wifi, title: 'Internet / ISP', subtitle: '3 pelanggan · piutang Rp350.000', color: navy, onTap: () => onNavigate(1)),
                  const Divider(height: 1, color: line),
                  BusinessLink(icon: Icons.coffee_outlined, title: 'Pengepul kopi', subtitle: 'Stok 120 kg · laba Rp1.500.000', color: brown, onTap: () => onNavigate(2)),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Row(children: [const Expanded(child: Text('Aktivitas terbaru', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: navy))), TextButton(onPressed: () => showMessage(context, 'Aktivitas demo ditampilkan di sini'), child: const Text('Lihat semua', style: TextStyle(fontSize: 10)))]),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: cardDecoration(),
              child: const Column(
                children: [
                  ActivityRow('12 Okt · Setoran voucher', '+ Rp500.000', green),
                  ActivityRow('10 Okt · Kopi ke pabrik', '+ Rp4.000.000', green),
                  SizedBox(height: 8),
                  Align(alignment: Alignment.centerLeft, child: Text('Penerimaan kas, bukan tambahan omzet.', style: TextStyle(fontSize: 9, color: muted))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InternetScreen extends StatelessWidget {
  const InternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(15, 8, 15, 16),
          children: [
            const StatusRow(),
            const SizedBox(height: 12),
            const Text('UI 03 / INTERNET', style: TextStyle(fontSize: 9, color: muted)),
            Row(children: [const Expanded(child: Text('Pelanggan internet', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: navy))), IconButton(onPressed: () => showMessage(context, 'Belum ada notifikasi baru'), icon: const Icon(Icons.notifications_none, size: 20))]),
            const Text('3 pelanggan aktif · Oktober 2026', style: TextStyle(fontSize: 10, color: muted)),
            const Text('Data demo · Belum terhubung database', style: TextStyle(fontSize: 9, color: muted)),
            const SizedBox(height: 14),
            const StaticTabs(labels: ['Pelanggan', 'Hotspot', 'PPPoE']),
            const SizedBox(height: 10),
            TextField(decoration: inputDecoration('Cari nama atau ID pelanggan', Icons.search)),
            const SizedBox(height: 9),
            ActionButton(label: '♙  Kelola / tambah pelanggan', color: navy, onPressed: () => showMessage(context, 'Form pelanggan demo belum terhubung database')),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: const Color(0xFFEAF0F7), borderRadius: BorderRadius.circular(9)),
              child: const Column(
                children: [
                  Row(children: [Expanded(child: Text('Piutang · 12 Okt 2026', style: TextStyle(fontSize: 10, color: muted))), Text('Rp350.000', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: navy))]),
                  SizedBox(height: 6),
                  Align(alignment: Alignment.centerLeft, child: Text('2 pelanggan belum lunas · tagihan PPPoE', style: TextStyle(fontSize: 9, color: muted))),
                ],
              ),
            ),
            const SizedBox(height: 14),
            const Row(children: [Expanded(child: Text('Daftar pelanggan', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: navy))), Text('Semua⌄', style: TextStyle(fontSize: 9, color: muted))]),
            const SizedBox(height: 8),
            CustomerCard(name: 'Budi Santoso', detail: 'NET-001 · Rumah · 10 Mbps', status: 'Lunas', network: 'Jaringan aktif · jatuh tempo 10 Okt 2026', paid: 'Rp150.000 / Rp150.000', balance: 'Rp0', color: green),
            CustomerCard(name: 'Sari Wulandari', detail: 'NET-002 · Keluarga · 20 Mbps', status: 'Cicilan', network: 'Jaringan aktif · jatuh tempo 10 Okt 2026', paid: 'Rp200.000 / Rp100.000', balance: 'Rp100.000', color: const Color(0xFFB47A00)),
            CustomerCard(name: 'Andi Pratama', detail: 'NET-003 · Usaha · 30 Mbps', status: 'Belum bayar', network: 'Jaringan aktif · jatuh tempo 10 Okt 2026', paid: 'Rp250.000 / Rp0', balance: 'Rp250.000', color: red),
            const SizedBox(height: 10),
            ActionButton(label: '＋  Catat pembayaran', color: navy, onPressed: () => showMessage(context, 'Form pembayaran demo belum terhubung database')),
            const SizedBox(height: 9),
            Container(
              decoration: cardDecoration(),
              child: ListTile(
                dense: true,
                title: const Text('Setoran dan pembayaran', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: navy)),
                subtitle: const Text('Tagihan, cicilan dan penerimaan kas → 06', style: TextStyle(fontSize: 9, color: muted)),
                trailing: const Icon(Icons.chevron_right, size: 18),
                onTap: () => showMessage(context, 'Menu setoran dan pembayaran (demo)'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CoffeeScreen extends StatelessWidget {
  const CoffeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(14, 8, 14, 16),
          children: [
            const StatusRow(),
            const SizedBox(height: 12),
            const Text('UI 07 / KOPI', style: TextStyle(fontSize: 9, color: muted)),
            Row(children: [const Expanded(child: Text('Petani & pemasok', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: navy))), IconButton(onPressed: () => showMessage(context, 'Belum ada notifikasi baru'), icon: const Icon(Icons.notifications_none, size: 20))]),
            const Text('Mitra green bean · Lampung', style: TextStyle(fontSize: 10, color: muted)),
            const Text('Data demo · Belum terhubung database', style: TextStyle(fontSize: 9, color: muted)),
            const SizedBox(height: 14),
            const StaticTabs(labels: ['Stok', 'Pemasok', 'Penjualan']),
            const SizedBox(height: 10),
            TextField(decoration: inputDecoration('Cari nama pemasok atau desa', Icons.search)),
            const SizedBox(height: 12),
            const Row(children: [Expanded(child: SmallMetric(title: 'Mitra tercatat', value: '2 mitra', subtitle: '1 petani · 1 pemasok')), SizedBox(width: 8), Expanded(child: SmallMetric(title: 'Pembelian periode ini', value: '200 kg', subtitle: '12 Okt 2026'))]),
            const SizedBox(height: 14),
            Row(children: [const Expanded(child: Text('Daftar mitra', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: navy))), TextButton(onPressed: () => showMessage(context, 'Daftar mitra (demo)'), child: const Text('Kelola', style: TextStyle(fontSize: 10)))]),
            SupplierCard(name: 'Ahmad Fauzi', location: 'Sumber Jaya, Lampung · Green bean Robusta', kg: '120 kg', amount: 'Rp4.800.000', last: '3 Okt 2026 · PB-001', role: 'Petani'),
            const SizedBox(height: 10),
            SupplierCard(name: 'Siti Aminah', location: 'Way Tenong, Lampung · Green bean Robusta', kg: '80 kg', amount: 'Rp3.200.000', last: '5 Okt 2026 · PB-002', role: 'Pemasok'),
            const SizedBox(height: 12),
            ActionButton(label: '＋  Catat pembelian kopi', color: brown, onPressed: () => showMessage(context, 'Form pembelian kopi demo belum terhubung database')),
            const SizedBox(height: 9),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: const Color(0xFFF5EDE5), borderRadius: BorderRadius.circular(9)),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.info_outline, size: 13, color: brown),
                  SizedBox(width: 6),
                  Expanded(child: Text('Pilih pemasok agar nama dan riwayat pembelian konsisten pada stok dan laporan.', style: TextStyle(fontSize: 9, color: brown, height: 1.4))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const StatusRow(),
            const SizedBox(height: 14),
            const Text('UI 08 / LAPORAN', style: TextStyle(fontSize: 9, color: muted)),
            const Text('Laporan keuangan', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: navy)),
            const SizedBox(height: 6),
            const Text('Ringkasan arus kas dua usaha · Oktober 2026', style: TextStyle(fontSize: 11, color: muted)),
            const SizedBox(height: 16),
            const MetricCard(title: 'Pemasukan kas', value: 'Rp9.850.000', subtitle: 'Internet + kopi', color: green),
            const SizedBox(height: 8),
            const MetricCard(title: 'Pengeluaran kas', value: 'Rp8.700.000', subtitle: 'Pembelian dan biaya', color: red),
            const SizedBox(height: 8),
            const MetricCard(title: 'Keuntungan gabungan', value: 'Rp2.200.000', subtitle: 'Setelah HPP dan biaya', color: green),
            const SizedBox(height: 16),
            ActionButton(label: 'Cetak / ekspor laporan (demo)', color: navy, onPressed: () => showMessage(context, 'Fitur laporan masih berupa demo')),
          ],
        ),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const StatusRow(),
            const SizedBox(height: 14),
            const Text('UI 09 / PROFIL', style: TextStyle(fontSize: 9, color: muted)),
            const Text('Profil operator', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: navy)),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: cardDecoration(),
              child: const Row(
                children: [
                  CircleAvatar(backgroundColor: Color(0xFFEAF0F7), child: Icon(Icons.person, color: navy)),
                  SizedBox(width: 12),
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Rina', style: TextStyle(fontWeight: FontWeight.w800, color: navy)), Text('Operator usaha · akun demo', style: TextStyle(fontSize: 10, color: muted))]),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: cardDecoration(),
              child: const ListTile(
                leading: Icon(Icons.info_outline, color: navy),
                title: Text('Tentang aplikasi', style: TextStyle(fontSize: 12)),
                subtitle: Text('Prototype Navigation v0.1', style: TextStyle(fontSize: 10, color: muted)),
              ),
            ),
            const SizedBox(height: 12),
            ActionButton(label: 'Keluar dari data demo', color: navy, onPressed: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const LoginScreen()), (_) => false)),
          ],
        ),
      ),
    );
  }
}

class StatusRow extends StatelessWidget {
  const StatusRow({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Text('09.41', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: navy)),
        Spacer(),
        Icon(Icons.signal_cellular_alt, size: 12, color: navy),
        SizedBox(width: 5),
        Icon(Icons.wifi, size: 12, color: navy),
        SizedBox(width: 5),
        Icon(Icons.battery_5_bar, size: 14, color: navy),
      ],
    );
  }
}

class StaticTabs extends StatelessWidget {
  final List<String> labels;
  const StaticTabs({super.key, required this.labels});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(color: const Color(0xFFEAF0F7), borderRadius: BorderRadius.circular(9)),
      child: Row(
        children: labels.map((label) {
          final bool active = label == labels.first || label == 'Pemasok';
          return Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(color: active ? Colors.white : Colors.transparent, borderRadius: BorderRadius.circular(7)),
              child: Text(label, textAlign: TextAlign.center, style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: active ? navy : muted)),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final Color color;

  const MetricCard({super.key, required this.title, required this.value, required this.subtitle, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(11),
      decoration: cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: const TextStyle(fontSize: 9, color: muted)),
          const SizedBox(height: 5),
          Text(value, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: color)),
          const SizedBox(height: 5),
          Text(subtitle, style: const TextStyle(fontSize: 8, color: muted)),
        ],
      ),
    );
  }
}

class BusinessLink extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const BusinessLink({super.key, required this.icon, required this.title, required this.subtitle, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      leading: Icon(icon, color: color, size: 20),
      title: Text(title, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: navy)),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 9, color: muted)),
      trailing: Icon(Icons.chevron_right, color: color, size: 18),
      onTap: onTap,
    );
  }
}

class ActivityRow extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  const ActivityRow(this.title, this.value, this.color, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Expanded(child: Text(title, style: const TextStyle(fontSize: 9, color: muted))),
          Text(value, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: color)),
        ],
      ),
    );
  }
}

class StatusPill extends StatelessWidget {
  final String text;
  final Color color;
  const StatusPill(this.text, this.color, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.10), borderRadius: BorderRadius.circular(20)),
      child: Text(text, style: TextStyle(fontSize: 8, color: color, fontWeight: FontWeight.w700)),
    );
  }
}

Widget barChart(String label, double height, Color color) {
  return Expanded(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(label, style: TextStyle(fontSize: 8, color: color)),
        const SizedBox(height: 4),
        Container(width: 22, height: 95 * height, decoration: BoxDecoration(color: color, borderRadius: const BorderRadius.vertical(top: Radius.circular(3)))),
      ],
    ),
  );
}

class ActionButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onPressed;

  const ActionButton({super.key, required this.label, required this.color, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      child: FilledButton(
        style: FilledButton.styleFrom(backgroundColor: color, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
        onPressed: onPressed,
        child: Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700)),
      ),
    );
  }
}

class CustomerCard extends StatelessWidget {
  final String name;
  final String detail;
  final String status;
  final String network;
  final String paid;
  final String balance;
  final Color color;

  const CustomerCard({super.key, required this.name, required this.detail, required this.status, required this.network, required this.paid, required this.balance, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(11),
      decoration: cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [Expanded(child: Text(name, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: navy))), StatusPill(status, color)]),
          const SizedBox(height: 3),
          Text(detail, style: const TextStyle(fontSize: 8, color: muted)),
          const SizedBox(height: 8),
          Text(network, style: const TextStyle(fontSize: 8, color: muted)),
          const SizedBox(height: 5),
          Row(children: [const Expanded(child: Text('Tagihan / terbayar', style: TextStyle(fontSize: 8, color: muted))), Text(paid, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: navy))]),
          const SizedBox(height: 5),
          Row(children: [const Expanded(child: Text('Sisa piutang', style: TextStyle(fontSize: 8, color: muted))), Text(balance, style: TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: color))]),
        ],
      ),
    );
  }
}

class SmallMetric extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  const SmallMetric({super.key, required this.title, required this.value, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(11),
      decoration: cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 8, color: muted)),
          const SizedBox(height: 5),
          Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: brown)),
          const SizedBox(height: 4),
          Text(subtitle, style: const TextStyle(fontSize: 8, color: muted)),
        ],
      ),
    );
  }
}

class SupplierCard extends StatelessWidget {
  final String name;
  final String location;
  final String kg;
  final String amount;
  final String last;
  final String role;

  const SupplierCard({super.key, required this.name, required this.location, required this.kg, required this.amount, required this.last, required this.role});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(11),
      decoration: cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [Expanded(child: Text(name, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: navy))), StatusPill(role, brown)]),
          const SizedBox(height: 4),
          Text(location, style: const TextStyle(fontSize: 8, color: muted)),
          const SizedBox(height: 10),
          Row(children: [const Expanded(child: Text('Pembelian periode ini', style: TextStyle(fontSize: 8, color: muted))), Text(kg, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: navy))]),
          const SizedBox(height: 5),
          Row(children: [const Expanded(child: Text('Total modal pembelian', style: TextStyle(fontSize: 8, color: muted))), Text(amount, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: brown))]),
          const SizedBox(height: 7),
          Text('Terakhir: $last', style: const TextStyle(fontSize: 8, color: muted)),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            height: 30,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)), side: const BorderSide(color: line)),
              onPressed: () => showMessage(context, 'Riwayat pembelian $name (demo)'),
              child: const Text('Lihat riwayat pemasok', style: TextStyle(fontSize: 9, color: navy, fontWeight: FontWeight.w700)),
            ),
          ),
        ],
      ),
    );
  }
}
