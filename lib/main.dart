
import 'package:flutter/material.dart';

void main() {
  runApp(const FinanceApp());
}

// ============================================================
// 1. KONFIGURASI APLIKASI
// ============================================================

const Color navy = Color(0xFF172F4D);
const Color bg = Color(0xFFF3F6FA);
const Color muted = Color(0xFF718096);
const Color green = Color(0xFF16805B);
const Color red = Color(0xFFD43D4D);
const Color brown = Color(0xFF895C3B);
const Color line = Color(0xFFE1E7EF);

// ============================================================
// 2. MODEL DATA
// ============================================================

class FinanceRecord {
  String id;
  String type;
  String name;
  String detail;
  String date;
  double amount;
  double weight;
  double price;

  FinanceRecord({
    required this.id,
    required this.type,
    required this.name,
    required this.detail,
    required this.date,
    this.amount = 0,
    this.weight = 0,
    this.price = 0,
  });

  double get total {
    if (type == 'Pembelian Kopi' ||
        type == 'Penjualan Kopi') {
      return weight * price;
    }

    return amount;
  }
}

// ============================================================
// 3. PENYIMPANAN DATA SEMENTARA
// ============================================================

final List<FinanceRecord> customers = [];
final List<FinanceRecord> packages = [];
final List<FinanceRecord> payments = [];
final List<FinanceRecord> suppliers = [];
final List<FinanceRecord> purchases = [];
final List<FinanceRecord> sales = [];
final List<FinanceRecord> expenses = [];

int nextId = 1;

String createId() {
  return (nextId++).toString();
}

// ============================================================
// 4. PERHITUNGAN KEUANGAN
// ============================================================

double get totalSetoranInternet {
  return payments.fold(0, (sum, item) => sum + item.amount);
}

double get totalPenjualanKopi {
  return sales.fold(0, (sum, item) => sum + item.total);
}

double get totalPembelianKopi {
  return purchases.fold(0, (sum, item) => sum + item.total);
}

double get totalPengeluaranOperasional {
  return expenses.fold(0, (sum, item) => sum + item.amount);
}

double get totalPenerimaan {
  return totalSetoranInternet + totalPenjualanKopi;
}

double get totalPengeluaran {
  return totalPembelianKopi + totalPengeluaranOperasional;
}

double get saldoBersih {
  return totalPenerimaan - totalPengeluaran;
}

double get totalStokKopi {
  final dibeli = purchases.fold<double>(
    0,
    (sum, item) => sum + item.weight,
  );

  final dijual = sales.fold<double>(
    0,
    (sum, item) => sum + item.weight,
  );

  return dibeli - dijual;
}

// ============================================================
// 5. FUNGSI BANTUAN
// ============================================================

String rupiah(num value) {
  final formatted = value.toStringAsFixed(0).replaceAllMapped(
    RegExp(r'\B(?=(\d{3})+(?!\d))'),
    (match) => '.',
  );

  return 'Rp$formatted';
}

String tanggalSekarang() {
  final now = DateTime.now();

  return '${now.day.toString().padLeft(2, '0')}-'
      '${now.month.toString().padLeft(2, '0')}-'
      '${now.year}';
}

void showMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
    ),
  );
}

// ============================================================
// 6. APLIKASI UTAMA
// ============================================================

class FinanceApp extends StatelessWidget {
  const FinanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sistem Keuangan Perusahaan',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: bg,
        colorScheme: ColorScheme.fromSeed(
          seedColor: navy,
        ),
        fontFamily: 'Roboto',
      ),
      home: const MainShell(),
    );
  }
}

// ============================================================
// 7. NAVIGASI UTAMA
// ============================================================

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int selectedIndex = 0;

  void refreshData() {
    if (mounted) {
      setState(() {});
    }
  }

  void navigateTo(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      DashboardPage(
        onNavigate: navigateTo,
        onChanged: refreshData,
      ),
      InternetPage(onChanged: refreshData),
      CoffeePage(onChanged: refreshData),
      ReportPage(onChanged: refreshData),
      const ProfilePage(),
    ];

    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: selectedIndex,
          children: pages,
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: navigateTo,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Beranda',
          ),
          NavigationDestination(
            icon: Icon(Icons.wifi_outlined),
            selectedIcon: Icon(Icons.wifi),
            label: 'Internet',
          ),
          NavigationDestination(
            icon: Icon(Icons.coffee_outlined),
            selectedIcon: Icon(Icons.coffee),
            label: 'Kopi',
          ),
          NavigationDestination(
            icon: Icon(Icons.bar_chart_outlined),
            selectedIcon: Icon(Icons.bar_chart),
            label: 'Laporan',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}

// ============================================================
// 8. KOMPONEN TAMPILAN UMUM
// ============================================================

Widget header(
  String code,
  String title,
  String subtitle,
) {
  return Container(
    color: Colors.white,
    padding: const EdgeInsets.fromLTRB(18, 12, 18, 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Text(
              '09.41',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Icon(Icons.signal_cellular_alt, size: 13),
            SizedBox(width: 5),
            Icon(Icons.battery_full, size: 14),
          ],
        ),
        const SizedBox(height: 17),
        Text(
          code.toUpperCase(),
          style: const TextStyle(
            fontSize: 9,
            color: muted,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: navy,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 11,
            color: muted,
          ),
        ),
      ],
    ),
  );
}

Widget commonCard(
  Widget child, {
  EdgeInsets padding = const EdgeInsets.all(14),
}) {
  return Container(
    width: double.infinity,
    padding: padding,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: line),
    ),
    child: child,
  );
}

Widget section(
  String title, {
  Widget? trailing,
}) {
  return Padding(
    padding: const EdgeInsets.only(top: 17, bottom: 9),
    child: Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: navy,
            ),
          ),
        ),
        if (trailing != null) trailing,
      ],
    ),
  );
}

Widget actionButton(
  String text,
  VoidCallback onTap, {
  Color color = navy,
  IconData icon = Icons.add,
}) {
  return SizedBox(
    width: double.infinity,
    child: FilledButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 17),
      label: Text(text),
      style: FilledButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 13),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(9),
        ),
      ),
    ),
  );
}

Widget emptyState(
  String title,
  String detail, {
  IconData icon = Icons.inbox_outlined,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(
      vertical: 22,
      horizontal: 8,
    ),
    child: Column(
      children: [
        Icon(icon, size: 35, color: muted),
        const SizedBox(height: 9),
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            color: navy,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          detail,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 11,
            color: muted,
          ),
        ),
      ],
    ),
  );
}

Widget stat(
  String title,
  String value, {
  Color color = navy,
}) {
  return Expanded(
    child: commonCard(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 10,
              color: muted,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            value,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
    ),
  );
}

// ============================================================
// 9. FORM INPUT DAN VALIDASI
// ============================================================

class RecordForm extends StatefulWidget {
  final String title;
  final FinanceRecord? record;
  final Function(FinanceRecord) onSave;

  const RecordForm({
    super.key,
    required this.title,
    required this.onSave,
    this.record,
  });

  @override
  State<RecordForm> createState() => _RecordFormState();
}

class _RecordFormState extends State<RecordForm> {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final detailController = TextEditingController();
  final amountController = TextEditingController();
  final weightController = TextEditingController();
  final priceController = TextEditingController();

  String service = 'Hotspot Voucher';

  bool get isEditing => widget.record != null;

  bool get isPackage => widget.title.startsWith('Paket ');

  bool get isCustomer => widget.title == 'Pelanggan';

  bool get isPayment => widget.title == 'Setoran';

  bool get isExpense => widget.title == 'Pengeluaran';

  bool get isSupplier => widget.title == 'Pemasok';

  bool get isPurchase => widget.title == 'Pembelian Kopi';

  bool get isSale => widget.title == 'Penjualan Kopi';

  @override
  void initState() {
    super.initState();

    final record = widget.record;

    if (record != null) {
      nameController.text = record.name;
      amountController.text = record.amount.toString();
      weightController.text = record.weight.toString();
      priceController.text = record.price.toString();

      if (record.type == 'Pelanggan' ||
          record.type == 'Setoran') {
        final detailParts = record.detail.split(' | ');

        service = detailParts.first;

        detailController.text = detailParts.length > 1
            ? detailParts.sublist(1).join(' | ')
            : '';
      } else {
        detailController.text = record.detail;
      }
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    detailController.dispose();
    amountController.dispose();
    weightController.dispose();
    priceController.dispose();

    super.dispose();
  }

  String? validateText(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Bagian ini wajib diisi.';
    }

    if (value.trim().length < 2) {
      return 'Masukkan minimal 2 karakter.';
    }

    return null;
  }

  String? validateNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Nominal wajib diisi.';
    }

    final number = double.tryParse(
      value.replaceAll(',', '.'),
    );

    if (number == null || number <= 0) {
      return 'Masukkan angka yang valid dan lebih dari 0.';
    }

    return null;
  }

  double parseNumber(TextEditingController controller) {
    return double.tryParse(
          controller.text.replaceAll(',', '.'),
        ) ??
        0;
  }

  InputDecoration inputDecoration(
    String label,
    IconData icon,
  ) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, size: 18),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(9),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 13,
      ),
    );
  }

  Widget textField(
    String label,
    TextEditingController controller,
    IconData icon, {
    bool number = false,
    bool required = true,
    VoidCallback? onInputChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 13),
      child: TextFormField(
        controller: controller,
        keyboardType: number
            ? const TextInputType.numberWithOptions(
                decimal: true,
              )
            : TextInputType.text,
        decoration: inputDecoration(label, icon),
        validator: required
            ? number
                ? validateNumber
                : validateText
            : null,
        onChanged: (_) {
          onInputChanged?.call();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing
              ? 'Edit ${widget.title}'
              : 'Tambah ${widget.title}',
        ),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            commonCard(
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isEditing
                        ? 'Form Edit Data'
                        : 'Form ${widget.title}',
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      color: navy,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Masukkan data sesuai transaksi sebenarnya.',
                    style: TextStyle(
                      fontSize: 11,
                      color: muted,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),

            if (isPackage) ...[
              textField(
                'Nama paket',
                nameController,
                Icons.inventory_2_outlined,
              ),
              textField(
                'Harga paket (Rp)',
                amountController,
                Icons.payments_outlined,
                number: true,
              ),
              if (widget.title == 'Paket PPPoE')
                textField(
                  'Kecepatan / keterangan',
                  detailController,
                  Icons.speed,
                ),
            ],

            if (isCustomer) ...[
              textField(
                'Nama pelanggan',
                nameController,
                Icons.person_outline,
              ),
              DropdownButtonFormField<String>(
                value: service,
                decoration: inputDecoration(
                  'Jenis layanan',
                  Icons.wifi,
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'Hotspot Voucher',
                    child: Text('Hotspot Voucher'),
                  ),
                  DropdownMenuItem(
                    value: 'PPPoE',
                    child: Text('PPPoE'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    service = value ?? service;
                  });
                },
              ),
              const SizedBox(height: 13),
              textField(
                'Nama paket pelanggan',
                detailController,
                Icons.inventory_2_outlined,
              ),
            ],

            if (isPayment) ...[
              textField(
                'Nama pelanggan',
                nameController,
                Icons.person_outline,
              ),
              DropdownButtonFormField<String>(
                value: service,
                decoration: inputDecoration(
                  'Jenis layanan',
                  Icons.wifi,
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'Hotspot Voucher',
                    child: Text('Hotspot Voucher'),
                  ),
                  DropdownMenuItem(
                    value: 'PPPoE',
                    child: Text('PPPoE'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    service = value ?? service;
                  });
                },
              ),
              const SizedBox(height: 13),
              textField(
                'Nama paket',
                detailController,
                Icons.inventory_2_outlined,
              ),
              textField(
                'Nominal diterima (Rp)',
                amountController,
                Icons.payments_outlined,
                number: true,
              ),
            ],

            if (isExpense) ...[
              textField(
                'Kategori pengeluaran',
                nameController,
                Icons.category_outlined,
              ),
              textField(
                'Nominal pengeluaran (Rp)',
                amountController,
                Icons.money_off,
                number: true,
              ),
              textField(
                'Catatan tambahan',
                detailController,
                Icons.notes_outlined,
                required: false,
              ),
            ],

            if (isSupplier) ...[
              textField(
                'Nama petani / pemasok',
                nameController,
                Icons.person_outline,
              ),
              textField(
                'Lokasi pemasok',
                detailController,
                Icons.location_on_outlined,
                required: false,
              ),
            ],

            if (isPurchase || isSale) ...[
              textField(
                isPurchase
                    ? 'Nama petani / pemasok'
                    : 'Nama pabrik pembeli',
                nameController,
                Icons.person_outline,
              ),
              textField(
                'Berat kopi (kg)',
                weightController,
                Icons.scale_outlined,
                number: true,
                onInputChanged: () {
                  setState(() {});
                },
              ),
              textField(
                isPurchase
                    ? 'Harga beli per kg (Rp)'
                    : 'Harga jual per kg (Rp)',
                priceController,
                Icons.payments_outlined,
                number: true,
                onInputChanged: () {
                  setState(() {});
                },
              ),
              textField(
                'Catatan / lokasi',
                detailController,
                Icons.notes_outlined,
                required: false,
              ),
              Container(
                padding: const EdgeInsets.all(15),
                margin: const EdgeInsets.only(bottom: 13),
                decoration: BoxDecoration(
                  color: brown,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Estimasi total transaksi',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      rupiah(
                        parseNumber(weightController) *
                            parseNumber(priceController),
                      ),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 8),

            actionButton(
              isEditing ? 'Simpan perubahan' : 'Simpan data',
              saveData,
              icon: Icons.save_outlined,
            ),
          ],
        ),
      ),
    );
  }

  void saveData() {
    if (!formKey.currentState!.validate()) {
      showMessage(
        context,
        'Periksa kembali input yang masih salah.',
      );
      return;
    }

    final oldRecord = widget.record;

    // Validasi stok ketika melakukan penjualan kopi.
    if (isSale) {
      final beratPenjualan = parseNumber(weightController);

      final stokTersedia = totalStokKopi +
          (oldRecord?.weight ?? 0);

      if (beratPenjualan > stokTersedia) {
        showMessage(
          context,
          'Stok kopi tidak mencukupi. Stok tersedia: '
          '${stokTersedia.toStringAsFixed(2)} kg.',
        );
        return;
      }
    }

    // Validasi ketika mengedit pembelian kopi.
    // Pembelian tidak boleh dikurangi sampai stok menjadi negatif.
    if (isPurchase) {
      final beratBaru = parseNumber(weightController);

      final totalPembelianTanpaDataLama =
          purchases.fold<double>(
        0,
        (sum, item) {
          if (item == oldRecord) {
            return sum;
          }

          return sum + item.weight;
        },
      );

      final totalStokSetelahEdit =
          totalPembelianTanpaDataLama +
              beratBaru -
              sales.fold<double>(
                0,
                (sum, item) => sum + item.weight,
              );

      if (totalStokSetelahEdit < 0) {
        showMessage(
          context,
          'Pembelian tidak dapat dikurangi karena stok '
          'sudah digunakan untuk penjualan.',
        );
        return;
      }
    }

    final record = widget.record ??
        FinanceRecord(
          id: createId(),
          type: widget.title,
          name: '',
          detail: '',
          date: tanggalSekarang(),
        );

    record.type = widget.title;
    record.date = tanggalSekarang();

    if (isPackage) {
      record.name = nameController.text.trim();
      record.detail = detailController.text.trim();
      record.amount = parseNumber(amountController);
    } else if (isCustomer) {
      record.name = nameController.text.trim();
      record.detail =
          '$service | ${detailController.text.trim()}';
    } else if (isPayment) {
      record.name = nameController.text.trim();
      record.detail =
          '$service | ${detailController.text.trim()}';
      record.amount = parseNumber(amountController);
    } else if (isExpense) {
      record.name = nameController.text.trim();
      record.detail = detailController.text.trim();
      record.amount = parseNumber(amountController);
    } else if (isSupplier) {
      record.name = nameController.text.trim();
      record.detail = detailController.text.trim();
    } else if (isPurchase || isSale) {
      record.name = nameController.text.trim();
      record.detail = detailController.text.trim();
      record.weight = parseNumber(weightController);
      record.price = parseNumber(priceController);
    }

    widget.onSave(record);

    showMessage(
      context,
      isEditing
          ? 'Data berhasil diperbarui.'
          : 'Data berhasil ditambahkan.',
    );

    Navigator.pop(context);
  }
}

// ============================================================
// 10. FUNGSI CRUD
// ============================================================

void openRecordForm(
  BuildContext context,
  String title,
  List<FinanceRecord> source,
  VoidCallback onChanged, {
  FinanceRecord? record,
}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => RecordForm(
        title: title,
        record: record,
        onSave: (data) {
          if (record == null) {
            source.add(data);
          }

          onChanged();
        },
      ),
    ),
  );
}

void deleteRecord(
  BuildContext context,
  FinanceRecord record,
  List<FinanceRecord> source,
  VoidCallback onChanged,
) {
  showDialog(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        title: const Text('Hapus data?'),
        content: Text(
          'Apakah kamu yakin ingin menghapus "${record.name}"?',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
            },
            child: const Text('Batal'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: red,
            ),
            onPressed: () {
              // Mencegah penghapusan pembelian jika
              // stoknya sudah digunakan untuk penjualan.
              if (record.type == 'Pembelian Kopi') {
                final sisaPembelian =
                    purchases.fold<double>(
                  0,
                  (sum, item) {
                    if (item == record) {
                      return sum;
                    }

                    return sum + item.weight;
                  },
                );

                final totalTerjual =
                    sales.fold<double>(
                  0,
                  (sum, item) => sum + item.weight,
                );

                if (sisaPembelian - totalTerjual < 0) {
                  Navigator.pop(dialogContext);

                  showMessage(
                    context,
                    'Pembelian tidak dapat dihapus karena '
                    'stoknya sudah digunakan untuk penjualan.',
                  );
                  return;
                }
              }

              source.remove(record);

              Navigator.pop(dialogContext);

              onChanged();

              showMessage(
                context,
                'Data berhasil dihapus.',
              );
            },
            child: const Text('Hapus'),
          ),
        ],
      );
    },
  );
}

Widget recordActions(
  BuildContext context,
  FinanceRecord record,
  List<FinanceRecord> source,
  VoidCallback onChanged,
) {
  return PopupMenuButton<String>(
    onSelected: (value) {
      if (value == 'edit') {
        openRecordForm(
          context,
          record.type,
          source,
          onChanged,
          record: record,
        );
      }

      if (value == 'delete') {
        deleteRecord(
          context,
          record,
          source,
          onChanged,
        );
      }
    },
    itemBuilder: (_) => const [
      PopupMenuItem(
        value: 'edit',
        child: Row(
          children: [
            Icon(Icons.edit_outlined),
            SizedBox(width: 8),
            Text('Edit'),
          ],
        ),
      ),
      PopupMenuItem(
        value: 'delete',
        child: Row(
          children: [
            Icon(Icons.delete_outline, color: red),
            SizedBox(width: 8),
            Text('Hapus'),
          ],
        ),
      ),
    ],
  );
}

// ============================================================
// 11. WIDGET DAFTAR DATA
// ============================================================

Widget recordList(
  BuildContext context,
  List<FinanceRecord> source,
  VoidCallback onChanged, {
  String? emptyTitle,
  String? emptyDetail,
  List<FinanceRecord>? storage,
}) {
  final actionSource = storage ?? source;

  if (source.isEmpty) {
    return commonCard(
      emptyState(
        emptyTitle ?? 'Belum ada data',
        emptyDetail ?? 'Data yang ditambahkan akan tampil di sini.',
      ),
    );
  }

  return Column(
    children: source.reversed.map((record) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 9),
        child: commonCard(
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              record.name,
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                color: navy,
                fontSize: 12,
              ),
            ),
            subtitle: Text(
              '${record.detail}\n${record.date}',
              style: const TextStyle(
                fontSize: 10,
                color: muted,
              ),
            ),
            isThreeLine: true,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (record.amount > 0 || record.weight > 0)
                  Text(
                    rupiah(record.total),
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      color: green,
                      fontSize: 11,
                    ),
                  ),
                recordActions(
                  context,
                  record,
                  actionSource,
                  onChanged,
                ),
              ],
            ),
          ),
        ),
      );
    }).toList(),
  );
}

// ============================================================
// 12. HALAMAN DASHBOARD
// ============================================================

class DashboardPage extends StatelessWidget {
  final ValueChanged<int> onNavigate;
  final VoidCallback onChanged;

  const DashboardPage({
    super.key,
    required this.onNavigate,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        header(
          'Ringkasan usaha',
          'Dashboard Keuangan',
          'Pantau transaksi internet dan pengepul kopi green bean.',
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: navy,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Saldo bersih berdasarkan data yang diinput',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      rupiah(saldoBersih),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Angka berubah setelah transaksi ditambahkan.',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  stat(
                    'Penerimaan',
                    rupiah(totalPenerimaan),
                    color: green,
                  ),
                  const SizedBox(width: 10),
                  stat(
                    'Pengeluaran',
                    rupiah(totalPengeluaran),
                    color: red,
                  ),
                ],
              ),
              section('Aksi cepat'),
              actionButton(
                'Catat pengeluaran usaha',
                () {
                  openRecordForm(
                    context,
                    'Pengeluaran',
                    expenses,
                    onChanged,
                  );
                },
                color: red,
                icon: Icons.money_off,
              ),
              section('Pilih bagian usaha'),
              commonCard(
                Column(
                  children: [
                    menuRow(
                      Icons.wifi,
                      'Internet',
                      'Pelanggan, paket Hotspot, PPPoE, setoran',
                      () => onNavigate(1),
                    ),
                    const Divider(height: 1),
                    menuRow(
                      Icons.coffee,
                      'Pengepul kopi green bean',
                      'Stok, pemasok, pembelian, penjualan pabrik',
                      () => onNavigate(2),
                    ),
                    const Divider(height: 1),
                    menuRow(
                      Icons.bar_chart,
                      'Laporan keuangan',
                      'Rekap berdasarkan transaksi yang diinput',
                      () => onNavigate(3),
                    ),
                  ],
                ),
              ),
              section('Aktivitas terbaru'),
              if (payments.isEmpty &&
                  purchases.isEmpty &&
                  sales.isEmpty &&
                  expenses.isEmpty)
                commonCard(
                  emptyState(
                    'Belum ada transaksi',
                    'Transaksi yang kamu input nanti akan muncul di sini.',
                  ),
                )
              else ...[
                ...payments.reversed.take(3).map(
                  (item) => activityCard(
                    item.name,
                    'Setoran internet',
                    rupiah(item.amount),
                    green,
                  ),
                ),
                ...purchases.reversed.take(3).map(
                  (item) => activityCard(
                    item.name,
                    'Pembelian green bean',
                    rupiah(item.total),
                    red,
                  ),
                ),
                ...sales.reversed.take(3).map(
                  (item) => activityCard(
                    item.name,
                    'Penjualan ke pabrik',
                    rupiah(item.total),
                    green,
                  ),
                ),
                ...expenses.reversed.take(3).map(
                  (item) => activityCard(
                    item.name,
                    'Pengeluaran usaha',
                    rupiah(item.amount),
                    red,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

Widget menuRow(
  IconData icon,
  String title,
  String detail,
  VoidCallback onTap,
) {
  return ListTile(
    contentPadding: EdgeInsets.zero,
    leading: CircleAvatar(
      backgroundColor: bg,
      child: Icon(icon, color: navy),
    ),
    title: Text(
      title,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w700,
      ),
    ),
    subtitle: Text(
      detail,
      style: const TextStyle(
        fontSize: 10,
        color: muted,
      ),
    ),
    trailing: const Icon(Icons.chevron_right),
    onTap: onTap,
  );
}

Widget activityCard(
  String name,
  String type,
  String amount,
  Color color,
) {
  return commonCard(
    ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        name,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
      ),
      subtitle: Text(
        type,
        style: const TextStyle(
          fontSize: 10,
          color: muted,
        ),
      ),
      trailing: Text(
        amount,
        style: TextStyle(
          fontWeight: FontWeight.w800,
          color: color,
          fontSize: 12,
        ),
      ),
    ),
  );
}

// ============================================================
// 13. HALAMAN INTERNET
// ============================================================

class InternetPage extends StatefulWidget {
  final VoidCallback onChanged;

  const InternetPage({
    super.key,
    required this.onChanged,
  });

  @override
  State<InternetPage> createState() => _InternetPageState();
}

class _InternetPageState extends State<InternetPage>
    with SingleTickerProviderStateMixin {
  late TabController tabs;

  @override
  void initState() {
    super.initState();

    tabs = TabController(
      length: 4,
      vsync: this,
    );
  }

  @override
  void dispose() {
    tabs.dispose();
    super.dispose();
  }

  void addData(String title, List<FinanceRecord> source) {
    openRecordForm(
      context,
      title,
      source,
      () {
        setState(() {});
        widget.onChanged();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        header(
          'Usaha / Internet',
          'Internet',
          'Kelola pelanggan, paket layanan, dan pembayaran.',
        ),
        Material(
          color: Colors.white,
          child: TabBar(
            controller: tabs,
            isScrollable: true,
            labelColor: navy,
            unselectedLabelColor: muted,
            tabs: const [
              Tab(text: 'Pelanggan'),
              Tab(text: 'Hotspot'),
              Tab(text: 'PPPoE'),
              Tab(text: 'Setoran'),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: tabs,
            children: [
              customerTab(),
              packageTab('Hotspot'),
              packageTab('PPPoE'),
              paymentTab(),
            ],
          ),
        ),
      ],
    );
  }

  Widget customerTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          children: [
            stat('Pelanggan', '${customers.length}'),
            const SizedBox(width: 10),
            stat('Pembayaran', '${payments.length}'),
          ],
        ),
        section(
          'Daftar pelanggan',
          trailing: TextButton(
            onPressed: () {
              addData('Pelanggan', customers);
            },
            child: const Text('+ Tambah'),
          ),
        ),
        recordList(
          context,
          customers,
          () {
            setState(() {});
            widget.onChanged();
          },
          emptyTitle: 'Belum ada pelanggan',
          emptyDetail: 'Tambahkan data pelanggan internet kamu.',
        ),
        section('Aksi cepat'),
        actionButton(
          'Catat pembayaran / setoran',
          () => addData('Setoran', payments),
        ),
      ],
    );
  }

  Widget packageTab(String type) {
    final source = packages
        .where((item) => item.type == 'Paket $type')
        .toList();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          children: [
            stat('Paket $type', '${source.length}'),
            const SizedBox(width: 10),
            stat('Status', 'Dikelola sendiri'),
          ],
        ),
        section(
          'Daftar paket',
          trailing: TextButton(
            onPressed: () {
              addData('Paket $type', packages);
            },
            child: const Text('+ Tambah paket'),
          ),
        ),
        recordList(
          context,
          source,
          () {
            setState(() {});
            widget.onChanged();
          },
          emptyTitle: 'Belum ada paket',
          emptyDetail: 'Tambahkan nama paket dan harga yang digunakan.',
          storage: packages,
        ),
      ],
    );
  }

  Widget paymentTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          children: [
            stat(
              'Penerimaan',
              rupiah(totalSetoranInternet),
              color: green,
            ),
            const SizedBox(width: 10),
            stat('Transaksi', '${payments.length}'),
          ],
        ),
        const SizedBox(height: 14),
        actionButton(
          'Catat pembayaran / cicilan',
          () => addData('Setoran', payments),
        ),
        section('Riwayat pembayaran'),
        recordList(
          context,
          payments,
          () {
            setState(() {});
            widget.onChanged();
          },
          emptyTitle: 'Belum ada pembayaran',
          emptyDetail: 'Pembayaran yang dicatat akan tampil di sini.',
        ),
      ],
    );
  }
}

// ============================================================
// 14. HALAMAN PENGEPUL KOPI
// ============================================================

class CoffeePage extends StatefulWidget {
  final VoidCallback onChanged;

  const CoffeePage({
    super.key,
    required this.onChanged,
  });

  @override
  State<CoffeePage> createState() => _CoffeePageState();
}

class _CoffeePageState extends State<CoffeePage>
    with SingleTickerProviderStateMixin {
  late TabController tabs;

  @override
  void initState() {
    super.initState();

    tabs = TabController(
      length: 3,
      vsync: this,
    );
  }

  @override
  void dispose() {
    tabs.dispose();
    super.dispose();
  }

  void addData(String title, List<FinanceRecord> source) {
    openRecordForm(
      context,
      title,
      source,
      () {
        setState(() {});
        widget.onChanged();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        header(
          'Usaha / Kopi',
          'Pembelian & stok',
          'Pengepul kopi green bean: beli dari petani, lalu jual ke pabrik.',
        ),
        Material(
          color: Colors.white,
          child: TabBar(
            controller: tabs,
            labelColor: navy,
            unselectedLabelColor: muted,
            tabs: const [
              Tab(text: 'Stok'),
              Tab(text: 'Pemasok'),
              Tab(text: 'Penjualan'),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: tabs,
            children: [
              stockTab(),
              supplierTab(),
              salesTab(),
            ],
          ),
        ),
      ],
    );
  }

  Widget stockTab() {
    final bought = purchases.fold<double>(
      0,
      (sum, item) => sum + item.weight,
    );

    final sold = sales.fold<double>(
      0,
      (sum, item) => sum + item.weight,
    );

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: brown,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Stok tersedia berdasarkan transaksi',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 11,
                ),
              ),
              const SizedBox(height: 7),
              Text(
                '${totalStokKopi} kg',
                style: const TextStyle(
                  fontSize: 27,
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                'Pembelian $bought kg  ·  Penjualan $sold kg',
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
        section('Pergerakan stok'),
        commonCard(
          Column(
            children: [
              stockLine('Saldo awal', '0 kg', muted),
              stockLine('Pembelian periode ini', '+ $bought kg', green),
              stockLine('Penjualan periode ini', '− $sold kg', red),
              const Divider(),
              stockLine('Stok akhir', '$totalStokKopi kg', brown),
            ],
          ),
        ),
        section('Aksi'),
        actionButton(
          'Catat pembelian kopi',
          () => addData('Pembelian Kopi', purchases),
          color: brown,
        ),
        const SizedBox(height: 8),
        actionButton(
          'Catat penjualan ke pabrik',
          () => addData('Penjualan Kopi', sales),
          color: brown,
        ),
        section('Riwayat pembelian'),
        recordList(
          context,
          purchases,
          () {
            setState(() {});
            widget.onChanged();
          },
          emptyTitle: 'Belum ada pembelian',
          emptyDetail: 'Data pembelian dari petani akan muncul di sini.',
        ),
      ],
    );
  }

  Widget supplierTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        section(
          'Daftar pemasok',
          trailing: TextButton(
            onPressed: () => addData('Pemasok', suppliers),
            child: const Text('+ Tambah pemasok'),
          ),
        ),
        recordList(
          context,
          suppliers,
          () {
            setState(() {});
            widget.onChanged();
          },
          emptyTitle: 'Belum ada pemasok',
          emptyDetail: 'Tambahkan data petani atau penjual green bean.',
        ),
      ],
    );
  }

  Widget salesTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          children: [
            stat(
              'Total penjualan',
              rupiah(totalPenjualanKopi),
              color: green,
            ),
            const SizedBox(width: 10),
            stat('Transaksi', '${sales.length}'),
          ],
        ),
        const SizedBox(height: 14),
        actionButton(
          'Catat penjualan / setoran ke pabrik',
          () => addData('Penjualan Kopi', sales),
          color: brown,
        ),
        section('Riwayat penjualan'),
        recordList(
          context,
          sales,
          () {
            setState(() {});
            widget.onChanged();
          },
          emptyTitle: 'Belum ada penjualan',
          emptyDetail: 'Transaksi penjualan ke pabrik akan tampil di sini.',
        ),
      ],
    );
  }
}

Widget stockLine(
  String title,
  String value,
  Color color,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 7),
    child: Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 11,
              color: muted,
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w800,
            color: color,
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// 15. HALAMAN LAPORAN KEUANGAN
// ============================================================

class ReportPage extends StatelessWidget {
  final VoidCallback onChanged;

  const ReportPage({
    super.key,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        header(
          'Rekap transaksi',
          'Laporan',
          'Ringkasan berdasarkan data yang kamu input sendiri.',
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Row(
                children: [
                  stat(
                    'Penerimaan',
                    rupiah(totalPenerimaan),
                    color: green,
                  ),
                  const SizedBox(width: 10),
                  stat(
                    'Pengeluaran',
                    rupiah(totalPengeluaran),
                    color: red,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              commonCard(
                Column(
                  children: [
                    reportRow(
                      'Setoran internet',
                      '${payments.length} transaksi',
                      rupiah(totalSetoranInternet),
                    ),
                    const Divider(),
                    reportRow(
                      'Penjualan ke pabrik',
                      '${sales.length} transaksi',
                      rupiah(totalPenjualanKopi),
                    ),
                    const Divider(),
                    reportRow(
                      'Pembelian green bean',
                      '${purchases.length} transaksi',
                      rupiah(totalPembelianKopi),
                    ),
                    const Divider(),
                    reportRow(
                      'Pengeluaran operasional',
                      '${expenses.length} transaksi',
                      rupiah(totalPengeluaranOperasional),
                    ),
                    const Divider(),
                    reportRow(
                      'Saldo bersih',
                      '',
                      rupiah(saldoBersih),
                    ),
                  ],
                ),
              ),
              section('Riwayat pengeluaran'),
              recordList(
                context,
                expenses,
                onChanged,
                emptyTitle: 'Belum ada pengeluaran',
                emptyDetail: 'Pengeluaran usaha akan tampil di sini.',
              ),
              const SizedBox(height: 12),
              const Text(
                'Dashboard dan laporan menggunakan sumber perhitungan yang sama.',
                style: TextStyle(
                  fontSize: 11,
                  color: muted,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget reportRow(
  String label,
  String count,
  String amount,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 9),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
              if (count.isNotEmpty)
                Text(
                  count,
                  style: const TextStyle(
                    fontSize: 10,
                    color: muted,
                  ),
                ),
            ],
          ),
        ),
        Text(
          amount,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w800,
            color: navy,
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// 16. HALAMAN PROFIL
// ============================================================

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        header(
          'Pengaturan aplikasi',
          'Profil',
          'Informasi aplikasi dan pengelolaan data.',
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              commonCard(
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 27,
                      backgroundColor: bg,
                      child: Icon(
                        Icons.business,
                        color: navy,
                        size: 28,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Sistem Keuangan Perusahaan',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: navy,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Pencatatan usaha internet dan pengepul kopi green bean.',
                      style: TextStyle(
                        fontSize: 11,
                        color: muted,
                      ),
                    ),
                  ],
                ),
              ),
              section('Informasi data'),
              commonCard(
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tidak ada data demo',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: green,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Semua daftar dimulai dalam keadaan kosong. Data baru berasal dari input pengguna.',
                      style: TextStyle(
                        fontSize: 11,
                        color: muted,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Data saat ini tersimpan sementara selama aplikasi berjalan. Belum menggunakan database permanen.',
                      style: TextStyle(
                        fontSize: 11,
                        color: muted,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
