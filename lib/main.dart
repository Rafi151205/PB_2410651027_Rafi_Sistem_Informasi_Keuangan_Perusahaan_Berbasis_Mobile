import 'package:flutter/material.dart';

// ============================================================
// 1. ENTRY POINT DAN KONFIGURASI APLIKASI
// ============================================================
void main() => runApp(const FinanceApp());

const navy = Color(0xFF172F4D);
const bg = Color(0xFFF3F6FA);
const muted = Color(0xFF718096);
const green = Color(0xFF16805B);
const red = Color(0xFFD43D4D);
const brown = Color(0xFF895C3B);
const line = Color(0xFFE1E7EF);

class FinanceApp extends StatelessWidget {
  const FinanceApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Sistem Keuangan Perusahaan', debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: true, scaffoldBackgroundColor: bg,
          colorScheme: ColorScheme.fromSeed(seedColor: navy), fontFamily: 'Roboto'),
        home: const MainShell(),
      );
}

// ============================================================
// 2. DATA APLIKASI (DIMULAI KOSONG, TANPA DATA DEMO)
// ============================================================
final List<Map<String, dynamic>> customers = [];
final List<Map<String, dynamic>> payments = [];
final List<Map<String, dynamic>> packages = [];
final List<Map<String, dynamic>> purchases = [];
final List<Map<String, dynamic>> sales = [];
final List<Map<String, dynamic>> suppliers = [];
final List<Map<String, dynamic>> expenses = [];

// ============================================================
// 3. PERHITUNGAN KEUANGAN BERSAMA
// Dashboard dan Laporan memakai sumber perhitungan yang sama.
// ============================================================
// Satu sumber perhitungan agar Dashboard dan Laporan selalu memakai rumus yang sama.
num get totalSetoranInternet => payments.fold<num>(0, (sum, item) => sum + (item['amount'] as num));
num get totalPenjualanKopi => sales.fold<num>(0, (sum, item) => sum + (item['total'] as num));
num get totalPembelianKopi => purchases.fold<num>(0, (sum, item) => sum + (item['total'] as num));
num get totalPengeluaranOperasional => expenses.fold<num>(0, (sum, item) => sum + (item['amount'] as num));
num get totalPenerimaan => totalSetoranInternet + totalPenjualanKopi;
num get totalPengeluaran => totalPembelianKopi + totalPengeluaranOperasional;
num get saldoBersih => totalPenerimaan - totalPengeluaran;

String rupiah(num n) => 'Rp${n.toStringAsFixed(0).replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => '.')}';
void msg(BuildContext c, String s) => ScaffoldMessenger.of(c).showSnackBar(SnackBar(content: Text(s), behavior: SnackBarBehavior.floating));

// ============================================================
// 4. KERANGKA APLIKASI DAN NAVIGASI (setState)
// ============================================================
class MainShell extends StatefulWidget { const MainShell({super.key}); @override State<MainShell> createState()=>_MainShellState(); }
class _MainShellState extends State<MainShell> {
 int index=0;
 int dataRevision=0;
 void refreshData(){if(mounted)setState(()=>dataRevision++);}
 @override Widget build(BuildContext context) {
  final pages=<Widget>[
   DashboardPage(key:ValueKey('dashboard-$dataRevision'),onNavigate:(i)=>setState(()=>{index=i, dataRevision++})),
   InternetPage(onChanged:refreshData),
   CoffeePage(onChanged:refreshData),
   ReportPage(key:ValueKey('report-$dataRevision')), const ProfilePage(),
  ];
  return Scaffold(body:SafeArea(child:IndexedStack(index:index,children:pages)),
   bottomNavigationBar:NavigationBar(selectedIndex:index,onDestinationSelected:(i)=>setState(()=>index=i),
    destinations:const [NavigationDestination(icon:Icon(Icons.home_outlined),selectedIcon:Icon(Icons.home),label:'Beranda'),NavigationDestination(icon:Icon(Icons.wifi_outlined),selectedIcon:Icon(Icons.wifi),label:'Internet'),NavigationDestination(icon:Icon(Icons.coffee_outlined),selectedIcon:Icon(Icons.coffee),label:'Kopi'),NavigationDestination(icon:Icon(Icons.bar_chart_outlined),selectedIcon:Icon(Icons.bar_chart),label:'Laporan'),NavigationDestination(icon:Icon(Icons.person_outline),selectedIcon:Icon(Icons.person),label:'Profil') ]));
 }
}

// ============================================================
// 5. WIDGET TAMPILAN UMUM YANG DIGUNAKAN ULANG
// ============================================================
Widget header(String code,String title,String subtitle)=>Container(color:Colors.white,padding:const EdgeInsets.fromLTRB(18,12,18,16),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[const Row(children:[Text('09.41',style:TextStyle(fontSize:10,fontWeight:FontWeight.bold)),Spacer(),Icon(Icons.signal_cellular_alt,size:13),SizedBox(width:5),Icon(Icons.battery_full,size:14)]),const SizedBox(height:17),Text(code.toUpperCase(),style:const TextStyle(fontSize:9,color:muted)),const SizedBox(height:4),Text(title,style:const TextStyle(fontSize:22,fontWeight:FontWeight.w800,color:navy)),const SizedBox(height:4),Text(subtitle,style:const TextStyle(fontSize:11,color:muted))]));
Widget card(Widget child,{EdgeInsets padding=const EdgeInsets.all(14)})=>Container(width:double.infinity,padding:padding,decoration:BoxDecoration(color:Colors.white,borderRadius:BorderRadius.circular(12),border:Border.all(color:line)),child:child);
Widget section(String title,{Widget? trailing})=>Padding(padding:const EdgeInsets.only(top:17,bottom:9),child:Row(children:[Expanded(child:Text(title,style:const TextStyle(fontSize:14,fontWeight:FontWeight.w800,color:navy))),if(trailing!=null)trailing]));
Widget actionButton(String text,VoidCallback onTap,{Color color=navy,IconData icon=Icons.add})=>SizedBox(width:double.infinity,child:FilledButton.icon(onPressed:onTap,icon:Icon(icon,size:17),label:Text(text),style:FilledButton.styleFrom(backgroundColor:color,foregroundColor:Colors.white,padding:const EdgeInsets.symmetric(vertical:13),shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(9)))));
Widget emptyState(String title,String detail,{IconData icon=Icons.inbox_outlined})=>Padding(padding:const EdgeInsets.symmetric(vertical:22,horizontal:8),child:Column(children:[Icon(icon,size:35,color:muted),const SizedBox(height:9),Text(title,style:const TextStyle(fontWeight:FontWeight.w700,color:navy)),const SizedBox(height:5),Text(detail,textAlign:TextAlign.center,style:const TextStyle(fontSize:11,color:muted))]));
Widget stat(String title,String value,{Color color=navy})=>Expanded(child:card(Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(title,style:const TextStyle(fontSize:10,color:muted)),const SizedBox(height:7),Text(value,style:TextStyle(fontSize:17,fontWeight:FontWeight.w800,color:color))]),padding:const EdgeInsets.all(12)));

// ============================================================
// 6. SCREEN BERANDA / DASHBOARD
// ============================================================
class DashboardPage extends StatelessWidget { final ValueChanged<int> onNavigate; const DashboardPage({super.key,required this.onNavigate});
 @override Widget build(BuildContext context){final income=totalPenerimaan;final spend=totalPengeluaran;return Column(children:[header('Ringkasan usaha','Dashboard Keuangan','Pantau transaksi internet dan pengepul kopi green bean.'),Expanded(child:ListView(padding:const EdgeInsets.all(16),children:[Container(padding:const EdgeInsets.all(18),decoration:BoxDecoration(color:navy,borderRadius:BorderRadius.circular(14)),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[const Text('Saldo bersih berdasarkan data yang diinput',style:TextStyle(color:Colors.white70,fontSize:11)),const SizedBox(height:8),Text(rupiah(income-spend),style:const TextStyle(color:Colors.white,fontSize:25,fontWeight:FontWeight.w800)),const SizedBox(height:5),const Text('Tidak ada data contoh. Angka berubah setelah transaksi ditambahkan.',style:TextStyle(color:Colors.white70,fontSize:10))])),const SizedBox(height:12),Row(children:[stat('Penerimaan',rupiah(income),color:green),const SizedBox(width:10),stat('Pengeluaran',rupiah(spend),color:red)]),section('Aksi cepat'),actionButton('Catat pengeluaran usaha',()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>EntryForm(title:'Pengeluaran',onSave:(_)=>onNavigate(0)))),color:red,icon:Icons.money_off),section('Pilih bagian usaha'),card(Column(children:[_menuRow(Icons.wifi,'Internet','Pelanggan, paket Hotspot, PPPoE, setoran',()=>onNavigate(1)),const Divider(height:1),_menuRow(Icons.coffee,'Pengepul kopi green bean','Stok, pemasok, pembelian, penjualan pabrik',()=>onNavigate(2)),const Divider(height:1),_menuRow(Icons.bar_chart,'Laporan keuangan','Rekap berdasarkan transaksi yang diinput',()=>onNavigate(3))])),section('Aktivitas terbaru'),if(payments.isEmpty&&purchases.isEmpty&&sales.isEmpty&&expenses.isEmpty)card(emptyState('Belum ada transaksi','Transaksi yang kamu input nanti akan muncul di sini.')) else ...[...payments.reversed.take(3).map((e)=>_activity(e['name'], 'Setoran internet',rupiah(e['amount']),green)),...purchases.reversed.take(3).map((e)=>_activity(e['name'],'Pembelian green bean',rupiah(e['total']),red)),...sales.reversed.take(3).map((e)=>_activity(e['buyer'],'Penjualan ke pabrik',rupiah(e['total']),green)),...expenses.reversed.take(3).map((e)=>_activity(e['category'],'Pengeluaran usaha',rupiah(e['amount']),red))]]))]);}
}
Widget _menuRow(IconData icon,String title,String detail,VoidCallback tap)=>ListTile(contentPadding:EdgeInsets.zero,leading:CircleAvatar(backgroundColor:bg,child:Icon(icon,color:navy)),title:Text(title,style:const TextStyle(fontSize:12,fontWeight:FontWeight.w700)),subtitle:Text(detail,style:const TextStyle(fontSize:10,color:muted)),trailing:const Icon(Icons.chevron_right),onTap:tap);
Widget _activity(String name,String type,String amount,Color color)=>card(ListTile(contentPadding:EdgeInsets.zero,title:Text(name,style:const TextStyle(fontWeight:FontWeight.w700,fontSize:12)),subtitle:Text(type,style:const TextStyle(fontSize:10,color:muted)),trailing:Text(amount,style:TextStyle(fontWeight:FontWeight.w800,color:color,fontSize:12))));

// ============================================================
// 7. SCREEN INTERNET: PELANGGAN, PAKET, DAN SETORAN
// ============================================================
class InternetPage extends StatefulWidget { final VoidCallback onChanged; const InternetPage({super.key,required this.onChanged}); @override State<InternetPage> createState()=>_InternetPageState(); }
class _InternetPageState extends State<InternetPage> with SingleTickerProviderStateMixin {late TabController tabs; @override void initState(){super.initState();tabs=TabController(length:4,vsync:this);} @override void dispose(){tabs.dispose();super.dispose();}
 @override Widget build(BuildContext context)=>Column(children:[header('Usaha / Internet','Internet','Kelola pelanggan, paket layanan, dan pembayaran.'),Material(color:Colors.white,child:TabBar(controller:tabs,isScrollable:true,labelColor:navy,unselectedLabelColor:muted,tabs:const[Tab(text:'Pelanggan'),Tab(text:'Hotspot'),Tab(text:'PPPoE'),Tab(text:'Setoran') ])),Expanded(child:TabBarView(controller:tabs,children:[_customerTab(context),_packageTab(context,'Hotspot Voucher'),_packageTab(context,'PPPoE'),_paymentTab(context)]))]);
 Widget _customerTab(BuildContext c)=>ListView(padding:const EdgeInsets.all(16),children:[Row(children:[stat('Pelanggan','${customers.length}'),const SizedBox(width:10),stat('Pembayaran', '${payments.length}')]),section('Daftar pelanggan',trailing:TextButton(onPressed:()=>_openForm(c,'Pelanggan'),child:const Text('+ Tambah'))),if(customers.isEmpty)card(emptyState('Belum ada pelanggan','Tambahkan data pelanggan internet kamu.',icon:Icons.people_outline)) else ...customers.map((e)=>card(ListTile(contentPadding:EdgeInsets.zero,title:Text(e['name'],style:const TextStyle(fontWeight:FontWeight.bold)),subtitle:Text('${e['service']} · ${e['package']}\n${e['phone']}',style:const TextStyle(fontSize:11,color:muted))))),section('Aksi cepat'),actionButton('Catat pembayaran / setoran',()=>_openForm(c,'Setoran'))]);
 Widget _packageTab(BuildContext c,String type)=>ListView(padding:const EdgeInsets.all(16),children:[Row(children:[stat('Paket $type','${packages.where((p)=>p['type']==type).length}'),const SizedBox(width:10),stat('Status','Dikelola sendiri')]),section('Daftar paket',trailing:TextButton(onPressed:()=>_openForm(c,'Paket $type'),child:const Text('+ Tambah paket'))),if(packages.where((p)=>p['type']==type).isEmpty)card(emptyState('Belum ada paket','Tambahkan nama paket dan harga yang kamu gunakan.',icon:Icons.inventory_2_outlined)) else ...packages.where((p)=>p['type']==type).map((p)=>card(ListTile(contentPadding:EdgeInsets.zero,title:Text(p['name'],style:const TextStyle(fontWeight:FontWeight.w700)),subtitle:Text(type,style:const TextStyle(fontSize:10,color:muted)),trailing:Text(rupiah(p['price']),style:const TextStyle(fontWeight:FontWeight.w800,color:green)))))]);
 Widget _paymentTab(BuildContext c)=>ListView(padding:const EdgeInsets.all(16),children:[Row(children:[stat('Penerimaan',rupiah(totalSetoranInternet),color:green),const SizedBox(width:10),stat('Transaksi','${payments.length}')]),const SizedBox(height:14),actionButton('Catat pembayaran / cicilan',()=>_openForm(c,'Setoran')),section('Tagihan dan riwayat pembayaran'),if(payments.isEmpty)card(emptyState('Belum ada pembayaran','Pembayaran yang kamu catat akan tampil di sini.',icon:Icons.receipt_long_outlined)) else ...payments.reversed.map((e)=>card(Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Row(children:[Expanded(child:Text(e['name'],style:const TextStyle(fontWeight:FontWeight.w800,color:navy))),Text(e['date'],style:const TextStyle(fontSize:10,color:muted))]),const SizedBox(height:7),Text('${e['service']} · ${e['package']}',style:const TextStyle(fontSize:11,color:muted)),const SizedBox(height:7),Row(children:[const Expanded(child:Text('Nominal diterima',style:TextStyle(fontSize:11))),Text(rupiah(e['amount']),style:const TextStyle(fontWeight:FontWeight.w800,color:green))])])))]);
 void _openForm(BuildContext c,String type)=>Navigator.push(c,MaterialPageRoute(builder:(_)=>EntryForm(title:type,onSave:(data){setState((){});widget.onChanged();})));
}

// ============================================================
// 8. SCREEN KOPI: STOK, PEMASOK, PEMBELIAN, PENJUALAN
// ============================================================
class CoffeePage extends StatefulWidget {final VoidCallback onChanged;const CoffeePage({super.key,required this.onChanged});@override State<CoffeePage> createState()=>_CoffeePageState();}
class _CoffeePageState extends State<CoffeePage> with SingleTickerProviderStateMixin {late TabController tabs;@override void initState(){super.initState();tabs=TabController(length:3,vsync:this);}@override void dispose(){tabs.dispose();super.dispose();}
 @override Widget build(BuildContext context){final kgBought=purchases.fold<num>(0,(s,e)=>s+(e['weight'] as num));final kgSold=sales.fold<num>(0,(s,e)=>s+(e['weight'] as num));final stock=kgBought-kgSold;return Column(children:[header('Usaha / Kopi','Pembelian & stok','Pengepul kopi green bean: beli dari petani, lalu jual ke pabrik.'),Material(color:Colors.white,child:TabBar(controller:tabs,labelColor:navy,unselectedLabelColor:muted,tabs:const[Tab(text:'Stok'),Tab(text:'Pemasok'),Tab(text:'Penjualan')])),Expanded(child:TabBarView(controller:tabs,children:[_stock(context,stock,kgBought,kgSold),_suppliers(context),_sales(context)]))]);}
 Widget _stock(BuildContext c,num stock,num bought,num sold)=>ListView(padding:const EdgeInsets.all(16),children:[Container(padding:const EdgeInsets.all(18),decoration:BoxDecoration(color:brown,borderRadius:BorderRadius.circular(12)),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[const Text('Stok tersedia berdasarkan transaksi',style:TextStyle(color:Colors.white70,fontSize:11)),const SizedBox(height:7),Text('$stock kg',style:const TextStyle(fontSize:27,color:Colors.white,fontWeight:FontWeight.w800)),Text('Pembelian $bought kg  ·  Penjualan $sold kg',style:const TextStyle(color:Colors.white70,fontSize:10))])),section('Pergerakan stok'),card(Column(children:[_line('Saldo awal', '0 kg',muted),_line('Pembelian periode ini','+ $bought kg',green),_line('Penjualan periode ini','− $sold kg',red),const Divider(),_line('Stok akhir','$stock kg',brown)])),section('Aksi'),actionButton('Catat pembelian kopi',()=>_open(c,'Pembelian kopi'),color:brown),const SizedBox(height:8),actionButton('Catat penjualan ke pabrik',()=>_open(c,'Penjualan kopi'),color:brown),section('Riwayat pembelian'),if(purchases.isEmpty)card(emptyState('Belum ada pembelian','Data pembelian dari petani akan muncul di sini.'))else ...purchases.reversed.map((e)=>_coffeeCard(e['name'],e['weight'],e['price'],e['total'],'Pembelian'))]);
 Widget _suppliers(BuildContext c)=>ListView(padding:const EdgeInsets.all(16),children:[section('Daftar pemasok',trailing:TextButton(onPressed:()=>_open(c,'Pemasok'),child:const Text('+ Tambah pemasok'))),if(suppliers.isEmpty)card(emptyState('Belum ada pemasok','Tambahkan data petani atau penjual green bean.',icon:Icons.people_outline))else ...suppliers.map((s)=>card(ListTile(contentPadding:EdgeInsets.zero,title:Text(s['name'],style:const TextStyle(fontWeight:FontWeight.bold)),subtitle:Text(s['location'],style:const TextStyle(fontSize:11,color:muted)),trailing:const Icon(Icons.person_outline))))]);
 Widget _sales(BuildContext c)=>ListView(padding:const EdgeInsets.all(16),children:[Row(children:[stat('Total penjualan',rupiah(sales.fold<num>(0,(s,e)=>s+(e['total'] as num))),color:green),const SizedBox(width:10),stat('Transaksi','${sales.length}')]),const SizedBox(height:14),actionButton('Catat penjualan / setoran ke pabrik',()=>_open(c,'Penjualan kopi'),color:brown),section('Riwayat penjualan'),if(sales.isEmpty)card(emptyState('Belum ada penjualan','Transaksi penjualan ke pabrik pengolahan kopi akan tampil di sini.'))else ...sales.reversed.map((e)=>_coffeeCard(e['buyer'],e['weight'],e['price'],e['total'],'Penjualan'))]);
 Widget _coffeeCard(String name,num weight,num price,num total,String type)=>card(Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Row(children:[Expanded(child:Text(name,style:const TextStyle(fontWeight:FontWeight.w800,color:navy))),Text(type,style:const TextStyle(fontSize:10,color:green))]),const SizedBox(height:6),Text('$weight kg × ${rupiah(price)}/kg',style:const TextStyle(fontSize:11,color:muted)),const SizedBox(height:6),Row(children:[const Expanded(child:Text('Total transaksi',style:TextStyle(fontSize:11))),Text(rupiah(total),style:const TextStyle(fontWeight:FontWeight.w800,color:brown))]) ]));
 Widget _line(String a,String b,Color color)=>Padding(padding:const EdgeInsets.symmetric(vertical:7),child:Row(children:[Expanded(child:Text(a,style:const TextStyle(fontSize:11,color:muted))),Text(b,style:TextStyle(fontSize:11,fontWeight:FontWeight.w800,color:color))]));
 void _open(BuildContext c,String title)=>Navigator.push(c,MaterialPageRoute(builder:(_)=>EntryForm(title:title,onSave:(d){setState((){});widget.onChanged();})));
}

// ============================================================
// 9. FORM INPUT BAB 6
// Menggunakan Form, GlobalKey<FormState>, TextFormField,
// validator, SnackBar, setState(), dan dispose() controller.
// ============================================================
class EntryForm extends StatefulWidget {final String title;final ValueChanged<Map<String,dynamic>> onSave;const EntryForm({super.key,required this.title,required this.onSave});@override State<EntryForm> createState()=>_EntryFormState();}
class _EntryFormState extends State<EntryForm>{final formKey = GlobalKey<FormState>();final name=TextEditingController(),detail=TextEditingController(),phone=TextEditingController(),amount=TextEditingController(),weight=TextEditingController(),price=TextEditingController(),location=TextEditingController();String service='Hotspot Voucher';String packageName='';DateTime date=DateTime.now();bool busy=false;
 bool get coffee=>['Pembelian kopi','Penjualan kopi','Pemasok'].contains(widget.title);bool get isExpense=>widget.title=='Pengeluaran';bool get isPackage=>widget.title.startsWith('Paket ');bool get isCustomer=>widget.title=='Pelanggan';
 @override void dispose(){for(final c in [name,detail,phone,amount,weight,price,location]){c.dispose();}super.dispose();}
 String? requiredText(String? v){if(v==null||v.trim().isEmpty)return 'Bagian ini wajib diisi.';if(v.trim().length<2)return 'Masukkan minimal 2 karakter.';return null;}
 String? positive(String? v){if(v==null||v.trim().isEmpty)return 'Nominal wajib diisi.';final n=num.tryParse(v.replaceAll('.','').replaceAll(',','.'));if(n==null)return 'Masukkan angka yang valid.';if(n<=0)return 'Nilai harus lebih besar dari 0.';return null;}
 num parse(TextEditingController c)=>num.tryParse(c.text.replaceAll('.','').replaceAll(',','.'))??0;
 @override Widget build(BuildContext context){final title=widget.title;return Scaffold(appBar:AppBar(title:Text(title)),body:Form(key:formKey,child:ListView(padding:const EdgeInsets.all(16),children:[card(Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text('Form $title',style:const TextStyle(fontSize:17,fontWeight:FontWeight.w800,color:navy)),const SizedBox(height:5),const Text('Isi data sesuai transaksi sebenarnya. Tidak ada data contoh yang diisikan otomatis.',style:TextStyle(fontSize:11,color:muted))])),const SizedBox(height:14),if(isPackage)...[_field('Nama paket',name,'Contoh: Harian / Rumah',Icons.inventory_2_outlined,validator:requiredText),_field('Harga paket (Rp)',price,'Masukkan harga',Icons.payments_outlined,validator:positive),if(title=='Paket PPPoE')_field('Kecepatan / keterangan',detail,'Contoh: 10 Mbps',Icons.speed,validator:requiredText)]else if(isCustomer)...[_field('Nama pelanggan',name,'Nama pelanggan',Icons.person_outline,validator:requiredText),_field('Nomor HP / ID pelanggan',phone,'Opsional',Icons.phone,optional:true),DropdownButtonFormField<String>(value:service,decoration:decoration('Jenis layanan'),items:const[DropdownMenuItem(value:'Hotspot Voucher',child:Text('Hotspot Voucher')),DropdownMenuItem(value:'PPPoE',child:Text('PPPoE'))],onChanged:(v)=>setState(()=>service=v??service)),_field('Nama paket',detail,'Nama paket pelanggan',Icons.inventory_2_outlined,validator:requiredText)]else if(title=='Setoran')...[_field('Nama pelanggan',name,'Nama pelanggan',Icons.person_outline,validator:requiredText),DropdownButtonFormField<String>(value:service,decoration:decoration('Jenis layanan'),items:const[DropdownMenuItem(value:'Hotspot Voucher',child:Text('Hotspot Voucher')),DropdownMenuItem(value:'PPPoE',child:Text('PPPoE'))],onChanged:(v)=>setState(()=>service=v??service)),_field('Nama paket',detail,'Paket yang dibayar',Icons.inventory_2_outlined,validator:requiredText),_field('Nominal diterima (Rp)',amount,'Masukkan nominal',Icons.payments_outlined,validator:positive)]else if(title=='Pengeluaran')...[_field('Kategori pengeluaran',detail,'Contoh: listrik, transportasi, internet, gaji',Icons.category_outlined,validator:requiredText),_field('Nominal pengeluaran (Rp)',amount,'Masukkan nominal pengeluaran',Icons.money_off,validator:positive),_field('Catatan / penerima (opsional)',location,'Keterangan tambahan',Icons.notes_outlined,optional:true)]else if(title=='Pemasok')...[_field('Nama petani / pemasok',name,'Nama pemasok',Icons.person_outline,validator:requiredText),_field('Lokasi / keterangan',location,'Desa / wilayah (opsional)',Icons.location_on_outlined,optional:true)]else if(title=='Pembelian kopi')...[_field('Nama petani / pemasok',name,'Nama petani atau pemasok',Icons.person_outline,validator:requiredText),_field('Berat kopi (kg)',weight,'Contoh: 120',Icons.scale_outlined,validator:positive),_field('Harga beli per kg (Rp)',price,'Contoh: 40000',Icons.payments_outlined,validator:positive),_field('Lokasi / catatan',location,'Opsional',Icons.location_on_outlined,optional:true),_totalCard(parse(weight)*parse(price))]else...[_field('Nama pabrik pembeli',name,'Nama pabrik pengolahan kopi',Icons.local_shipping_outlined,validator:requiredText),_field('Berat kopi terjual (kg)',weight,'Contoh: 80',Icons.scale_outlined,validator:positive),_field('Harga jual per kg (Rp)',price,'Contoh: 50000',Icons.payments_outlined,validator:positive),_field('Catatan penjualan',location,'Opsional',Icons.notes_outlined,optional:true),_totalCard(parse(weight)*parse(price))],const SizedBox(height:12),card(Row(children:[const Icon(Icons.calendar_month,color:navy,size:19),const SizedBox(width:9),Expanded(child:Text('Tanggal: ${date.day.toString().padLeft(2,'0')}-${date.month.toString().padLeft(2,'0')}-${date.year}',style:const TextStyle(fontSize:12))),TextButton(onPressed:()async{final d=await showDatePicker(context:context,initialDate:date,firstDate:DateTime(2020),lastDate:DateTime(2100));if(d!=null)setState(()=>date=d);},child:const Text('Ubah'))])),const SizedBox(height:18),actionButton(busy?'Menyimpan...':'Simpan data',_save),const SizedBox(height:10),const Text('Data tersimpan selama aplikasi berjalan. Untuk penyimpanan permanen perlu database atau penyimpanan lokal.',textAlign:TextAlign.center,style:TextStyle(fontSize:10,color:muted))])));}
 InputDecoration decoration(String label)=>InputDecoration(labelText:label,border:OutlineInputBorder(borderRadius:BorderRadius.circular(9)),contentPadding:const EdgeInsets.symmetric(horizontal:12,vertical:13));
 Widget _field(String label,TextEditingController controller,String hint,IconData icon,{String? Function(String?)? validator,bool optional=false})=>Padding(padding:const EdgeInsets.only(bottom:13),child:TextFormField(controller:controller,keyboardType:([amount,weight,price].contains(controller)?const TextInputType.numberWithOptions(decimal:true):TextInputType.text),decoration:decoration(label).copyWith(hintText:hint,prefixIcon:Icon(icon,size:18)),validator:optional?null:(validator??requiredText),onChanged:(_){if(mounted)setState((){});}));
 Widget _totalCard(num total)=>Container(margin:const EdgeInsets.only(bottom:13),padding:const EdgeInsets.all(15),decoration:BoxDecoration(color:brown,borderRadius:BorderRadius.circular(10)),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[const Text('Estimasi total transaksi',style:TextStyle(color:Colors.white70,fontSize:11)),const SizedBox(height:5),Text(rupiah(total),style:const TextStyle(color:Colors.white,fontSize:22,fontWeight:FontWeight.w800))]));
 void _save(){if(!formKey.currentState!.validate()){msg(context,'Periksa kembali input yang masih salah.');return;}final Map<String, dynamic> d = {'date':'${date.day.toString().padLeft(2,'0')} ${_month(date.month)} ${date.year}'};if(isPackage){d.addAll({'type':widget.title.substring(6),'name':name.text.trim(),'price':parse(price),'detail':detail.text.trim()});packages.add(d);}else if(isCustomer){d.addAll({'name':name.text.trim(),'phone':phone.text.trim(),'service':service,'package':detail.text.trim()});customers.add(d);}else if(widget.title=='Setoran'){d.addAll({'name':name.text.trim(),'service':service,'package':detail.text.trim(),'amount':parse(amount)});payments.add(d);}else if(isExpense){d.addAll({'category':detail.text.trim(),'amount':parse(amount),'note':location.text.trim()});expenses.add(d);}else if(widget.title=='Pemasok'){d.addAll({'name':name.text.trim(),'location':location.text.trim()});suppliers.add(d);}else if(widget.title=='Pembelian kopi'){d.addAll({'name':name.text.trim(),'weight':parse(weight),'price':parse(price),'total':parse(weight)*parse(price),'location':location.text.trim()});purchases.add(d);}else{d.addAll({'buyer':name.text.trim(),'weight':parse(weight),'price':parse(price),'total':parse(weight)*parse(price),'note':location.text.trim()});sales.add(d);}widget.onSave(d);msg(context,'Data berhasil ditambahkan.');Navigator.pop(context);}
 String _month(int m)=>['Jan','Feb','Mar','Apr','Mei','Jun','Jul','Agu','Sep','Okt','Nov','Des'][m-1];
}

// ============================================================
// 10. SCREEN LAPORAN KEUANGAN
// ============================================================
class ReportPage extends StatelessWidget {
 const ReportPage({super.key});
 @override
 Widget build(BuildContext context) {
  return Column(children:[
   header('Rekap transaksi','Laporan','Ringkasan berdasarkan data yang kamu input sendiri.'),
   Expanded(child:ListView(padding:const EdgeInsets.all(16),children:[
    Row(children:[stat('Penerimaan',rupiah(totalPenerimaan),color:green),const SizedBox(width:10),stat('Pengeluaran',rupiah(totalPengeluaran),color:red)]),
    const SizedBox(height:10),
    card(Column(children:[
     _reportRow('Setoran internet','${payments.length} transaksi',rupiah(totalSetoranInternet)),
     const Divider(),
     _reportRow('Penjualan ke pabrik','${sales.length} transaksi',rupiah(totalPenjualanKopi)),
     const Divider(),
     _reportRow('Pembelian green bean','${purchases.length} transaksi',rupiah(totalPembelianKopi)),
     const Divider(),
     _reportRow('Pengeluaran operasional','${expenses.length} transaksi',rupiah(totalPengeluaranOperasional)),
     const Divider(),
     _reportRow('Saldo bersih (penerimaan - pengeluaran)','',rupiah(saldoBersih)),
    ])),
    const SizedBox(height:12),
    const Text('Dashboard dan laporan menggunakan sumber perhitungan yang sama. Data hanya mencakup transaksi yang kamu input selama aplikasi berjalan.',style:TextStyle(fontSize:11,color:muted)),
   ]))
  ]);
 }
}
Widget _reportRow(String label,String count,String amount)=>Padding(padding:const EdgeInsets.symmetric(vertical:9),child:Row(children:[Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(label,style:const TextStyle(fontSize:12,fontWeight:FontWeight.w700)),if(count.isNotEmpty)Text(count,style:const TextStyle(fontSize:10,color:muted))])),Text(amount,style:const TextStyle(fontSize:12,fontWeight:FontWeight.w800,color:navy))]));
// ============================================================
// 11. SCREEN PROFIL
// ============================================================
class ProfilePage extends StatelessWidget {const ProfilePage({super.key});@override Widget build(BuildContext context)=>Column(children:[header('Pengaturan aplikasi','Profil','Informasi aplikasi dan pengelolaan data.'),Expanded(child:ListView(padding:const EdgeInsets.all(16),children:[card(const Column(crossAxisAlignment:CrossAxisAlignment.start,children:[CircleAvatar(radius:27,backgroundColor:bg,child:Icon(Icons.business,color:navy,size:28)),SizedBox(height:12),Text('Sistem Keuangan Perusahaan',style:TextStyle(fontWeight:FontWeight.w800,color:navy,fontSize:16)),SizedBox(height:5),Text('Pencatatan usaha internet dan pengepul kopi green bean.',style:TextStyle(fontSize:11,color:muted))])),section('Informasi data'),card(const Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text('Tidak ada data demo',style:TextStyle(fontWeight:FontWeight.w700,color:green)),SizedBox(height:6),Text('Semua daftar dimulai dalam keadaan kosong. Data baru berasal dari input pengguna.',style:TextStyle(fontSize:11,color:muted)),SizedBox(height:10),Text('Penting: data saat ini tersimpan di memori selama aplikasi aktif dan belum disimpan permanen.',style:TextStyle(fontSize:11,color:muted))]))]))]);
}
