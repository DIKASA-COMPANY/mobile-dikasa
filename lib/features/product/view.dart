import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_dikasa/components/app_loading_indicator.dart';
import 'package:mobile_dikasa/components/app_remote_image.dart';
import 'package:mobile_dikasa/components/table/main.dart';
import 'package:mobile_dikasa/core/utils/formatted_currency.dart';
import 'package:mobile_dikasa/data/models/catalog_product.dart';
import 'package:mobile_dikasa/data/models/user.dart';
import 'categories.dart';
import 'editor.dart';
import 'view_model.dart';
import 'widgets.dart';

class CatalogView extends StatefulWidget {
  const CatalogView({super.key, required this.viewModel, this.user});
  final CatalogViewModel viewModel;
  final User? user;
  @override
  State<CatalogView> createState() => _CatalogViewState();
}

class _CatalogViewState extends State<CatalogView> {
  late final CatalogViewModel vm;
  final _search = TextEditingController();
  List<CatalogProduct> get _products => vm.products;
  List<Map<String, dynamic>> get _types => vm.types;
  Map<String, List<CatalogCategory>> get _categories => vm.categories;
  String get _query => vm.query;
  String get _type => vm.type;
  String get _stock => vm.stock;
  String get _category => vm.category;
  String? get _error => vm.error;
  bool get _loading => vm.loading;
  bool get _includeInactive => vm.includeInactive;
  bool get _exporting => vm.exporting;
  int get _page => vm.page;
  DateTime? get _updated => vm.updated;

  @override
  void initState() {
    super.initState();
    vm = widget.viewModel;
    vm.addListener(_changed);
    vm.load();
  }

  void _changed() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    vm.removeListener(_changed);
    vm.dispose();
    _search.dispose();
    super.dispose();
  }

  Future<void> _load() => vm.load();

  Future<void> _edit([CatalogProduct? product]) async {
    await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => ProductEditor(
          service: vm.editorService,
          product: product,
          user: widget.user,
        ),
      ),
    );
    if (mounted) await _load();
  }

  Future<void> _export() => vm.export();

  String get _capitalLabel => vm.capitalLabel;

  String _typeName(String code) => vm.typeName(code);
  Future<void> _filter() async {
    var type = _type, stock = _stock, category = _category;
    var inactive = _includeInactive;
    final apply = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, update) => AlertDialog(
          title: const Text('Filter Produk'),
          content: SizedBox(
            width: 440.w,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButtonFormField<String>(
                    initialValue: type,
                    decoration: const InputDecoration(
                      labelText: 'Jenis Produk',
                    ),
                    items: [
                      const DropdownMenuItem(
                        value: '',
                        child: Text('Semua Jenis'),
                      ),
                      ..._types.map(
                        (t) => DropdownMenuItem(
                          value: t['code'] as String,
                          child: Text(t['name'] as String),
                        ),
                      ),
                    ],
                    onChanged: (v) => update(() {
                      type = v!;
                      category = '';
                    }),
                  ),
                  SizedBox(height: 16.h),
                  DropdownButtonFormField<String>(
                    key: ValueKey('category-$type-$category'),
                    initialValue: category,
                    isExpanded: true,
                    decoration: const InputDecoration(labelText: 'Kategori'),
                    items: [
                      const DropdownMenuItem(
                        value: '',
                        child: Text('Semua Kategori'),
                      ),
                      ..._categories.entries
                          .where((e) => type.isEmpty || e.key == type)
                          .expand(
                            (e) => e.value.map(
                              (c) => DropdownMenuItem(
                                value: c.id,
                                child: Text(
                                  '${c.name} (${_typeName(e.key)})',
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                    ],
                    onChanged: (v) => update(() => category = v!),
                  ),
                  SizedBox(height: 16.h),
                  DropdownButtonFormField<String>(
                    initialValue: stock,
                    decoration: const InputDecoration(
                      labelText: 'Status Stock',
                    ),
                    items: const [
                      DropdownMenuItem(value: '', child: Text('Semua Status')),
                      DropdownMenuItem(
                        value: 'available',
                        child: Text('Tersedia'),
                      ),
                      DropdownMenuItem(
                        value: 'out_of_stock',
                        child: Text('Habis'),
                      ),
                    ],
                    onChanged: (v) => update(() => stock = v!),
                  ),
                  SizedBox(height: 16.h),
                  CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Sertakan produk nonaktif'),
                    subtitle: const Text('Memerlukan akses manager.'),
                    value: inactive,
                    onChanged: (v) => update(() => inactive = v!),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () => update(() {
                type = '';
                stock = '';
                category = '';
                inactive = false;
              }),
              child: const Text('Reset'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: const Text('Terapkan'),
            ),
          ],
        ),
      ),
    );
    if (apply != true || !mounted) return;
    final reload = vm.applyFilters(
      type: type,
      stock: stock,
      category: category,
      includeInactive: inactive,
    );
    if (reload) _load();
  }

  @override
  Widget build(BuildContext context) => CatalogShell(
    title: 'Katalog Produk',
    user: widget.user,
    actions: [
      SizedBox(
        width: MediaQuery.sizeOf(context).width > 1200 ? 371 : 250,
        height: 46.h,
        child: TextField(
          key: const Key('catalog-search'),
          controller: _search,
          style: catalogText(18),
          decoration: InputDecoration(
            hintText: 'Cari Produk',
            hintStyle: catalogText(
              18,
              color: const Color(0xFF9B9B9B),
              italic: true,
            ),
            filled: true,
            fillColor: Colors.white,
            prefixIcon: Padding(
              padding: EdgeInsets.all(14.r),
              child: catalogIcon('search'),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
          ),
          onChanged: vm.setSearch,
        ),
      ),
      SizedBox(
        width: 276.w,
        child: CatalogButton(
          _exporting ? 'Mengunduh…' : 'Export / Download',
          onPressed: _loading || _exporting ? null : _export,
        ),
      ),
      SizedBox(
        width: 193.w,
        child: CatalogButton(
          'Filter',
          icon: 'filter',
          onPressed: _loading ? null : _filter,
        ),
      ),
    ],
    child: LayoutBuilder(
      builder: (context, c) {
        final small = c.maxWidth < 850;
        final rows = _products
            .where(
              (p) =>
                  p.name.toLowerCase().contains(_query) &&
                  (_type.isEmpty || p.productType == _type) &&
                  (_stock.isEmpty || p.availability == _stock) &&
                  (_category.isEmpty || p.category.id == _category),
            )
            .toList();
        final visible = rows.skip(_page * 25).take(25).toList();
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: small ? 20 : 46,
              vertical: 32.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (_error != null) catalogError(_error!, retry: _load),
                if (_loading) const AppLinearLoadingIndicator(),
                _summary(c.maxWidth - (small ? 40 : 92)),
                SizedBox(height: 37.h),
                Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  runSpacing: 12,
                  children: [
                    Text(
                      _updated == null
                          ? 'Memuat katalog…'
                          : 'Terakhir diperbarui: ${_updated!.day}/${_updated!.month}/${_updated!.year} ${_updated!.hour.toString().padLeft(2, '0')}:${_updated!.minute.toString().padLeft(2, '0')}',
                      style: catalogText(
                        18,
                        color: catalogOrange,
                        italic: true,
                      ),
                    ),
                    Tooltip(
                      message:
                          'Jumlah stok terlacak × harga modal produk utama. Variasi tidak dihitung sebagai stok tambahan.',
                      child: Text(
                        _capitalLabel,
                        style: catalogText(
                          18,
                          color: catalogOrange,
                          italic: true,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 14.h),
                if (!_loading || _products.isNotEmpty)
                  _table(visible, c.maxWidth - (small ? 40 : 92)),
                SizedBox(height: 16.h),
                Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      '${rows.length} produk${_includeInactive ? ' (termasuk nonaktif)' : ''}',
                      style: catalogText(14),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          tooltip: 'Halaman sebelumnya',
                          onPressed: _page == 0 ? null : vm.previousPage,
                          icon: const Icon(Icons.chevron_left),
                        ),
                        Text(
                          '${_page + 1} / ${(rows.length / 25).ceil().clamp(1, 999999)}',
                          style: catalogText(14),
                        ),
                        IconButton(
                          tooltip: 'Halaman berikutnya',
                          onPressed: (_page + 1) * 25 >= rows.length
                              ? null
                              : vm.nextPage,
                          icon: const Icon(Icons.chevron_right),
                        ),
                        IconButton(
                          tooltip: 'Muat ulang katalog',
                          onPressed: _loading ? null : _load,
                          icon: const Icon(Icons.refresh),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                Text(
                  'Powered By Dikasa',
                  textAlign: TextAlign.center,
                  style: catalogText(
                    15,
                    color: const Color(0xFFD4D4D4),
                    italic: true,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );

  Widget _summary(double width) {
    final columns = width >= 1240
        ? 3
        : width >= 840
        ? 2
        : 1;
    final itemWidth = (width - 43 * (columns - 1)) / columns;
    Widget stats(List<(String, String)> values) => Container(
      width: itemWidth,
      height: 146.h,
      padding: EdgeInsets.symmetric(horizontal: 38.w, vertical: 26.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F4F4),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: const [
          BoxShadow(
            color: Color(0x22000000),
            blurRadius: 10,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: values
            .map(
              (v) => Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      v.$1,
                      style: catalogText(
                        18,
                        color: const Color(0xFF979797),
                        weight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      _updated == null ? '—' : v.$2,
                      style: catalogText(
                        36,
                        color: const Color(0xFF979797),
                        weight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
    return Wrap(
      spacing: 43,
      runSpacing: 24,
      children: [
        stats([
          ('Total Produk', '${_products.length}'),
          (
            'Total Kategori',
            '${_categories.values.fold<int>(0, (sum, c) => sum + c.length)}',
          ),
        ]),
        Tooltip(
          message:
              'Saldo stok bersama yang positif dan mencapai batas menipis.',
          child: stats([
            (
              'Stock Habis',
              '${_products.where((p) => p.availability == 'out_of_stock').length}',
            ),
            (
              'Stock Menipis',
              '${_products.where((p) => p.availability == "low_stock").length}',
            ),
          ]),
        ),
        SizedBox(
          width: itemWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CatalogButton(
                'Tambah Produk',
                icon: 'add',
                color: catalogOrange,
                height: 63.h,
                onPressed: _loading ? null : _edit,
              ),
              SizedBox(height: 20.h),
              CatalogButton(
                'Tambah Kategori',
                icon: 'category_add',
                color: catalogAccent,
                height: 63.h,
                onPressed: _loading
                    ? null
                    : () async {
                        await manageCategories(
                          context,
                          vm.editorService,
                          onChanged: () {},
                        );
                        if (mounted) _load();
                      },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _table(List<CatalogProduct> products, double available) {
    final width = available.clamp(1150.0, double.infinity);
    final nameWidth = width - 992;
    return TableField<CatalogProduct>(
      rows: products,
      emptyText: 'Produk tidak ditemukan.',
      headerBackgroundColor: catalogBlue,
      rowBackgroundColor: const Color(0xFFF4F4F4),
      borderColor: Colors.transparent,
      headingRowHeight: 73,
      rowHeight: 94,
      horizontalMargin: 20,
      columnSpacing: 16,
      headerTextStyle: catalogText(
        19,
        color: Colors.white,
        weight: FontWeight.w600,
      ),
      cellTextStyle: catalogText(18),
      columns: [
        TableFieldColumn(
          title: 'Foto',
          width: 170.w,
          headerTextAlign: TextAlign.center,
          valueBuilder: (_) => '',
          cellBuilder: (p) => Row(
            children: [
              SizedBox(
                width: 40.w,
                child: p.variations.isEmpty
                    ? null
                    : IconButton(
                        tooltip: 'Lihat variasi',
                        icon: const Icon(Icons.arrow_right, color: catalogGrey),
                        onPressed: () => _prices(p),
                      ),
              ),
              SizedBox(width: 20.w),
              ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: p.imageUrl == null
                    ? Image.asset(
                        'assets/images/catalog_placeholder.png',
                        width: 70.w,
                        height: 70.h,
                        fit: BoxFit.cover,
                      )
                    : AppRemoteImage(
                        url: p.imageUrl!,
                        width: 70.w,
                        height: 70.h,
                        fit: BoxFit.cover,
                        fallback: Image.asset(
                          'assets/images/catalog_placeholder.png',
                          width: 70.w,
                          height: 70.h,
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
            ],
          ),
        ),
        TableFieldColumn(
          title: 'Nama Produk',
          width: nameWidth,
          valueBuilder: (p) => p.name,
          cellBuilder: (p) => Text(
            p.isActive ? p.name : '${p.name} (Nonaktif)',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: catalogText(18),
          ),
        ),
        TableFieldColumn(
          title: 'Kategori',
          width: 180.w,
          valueBuilder: (p) => p.category.name,
        ),
        TableFieldColumn(
          title: 'Jenis Produk',
          width: 170.w,
          valueBuilder: (p) => _typeName(p.productType),
        ),
        TableFieldColumn(
          title: 'Status Stock',
          width: 150.w,
          valueBuilder: (_) => '',
          cellBuilder: (p) => Text(
            p.availability == 'low_stock'
                ? 'Menipis'
                : p.availability == 'available'
                ? 'Tersedia'
                : 'Habis',
            style: catalogText(
              18,
              color: p.availability == 'low_stock'
                  ? catalogOrange
                  : p.availability == 'available'
                  ? const Color(0xFF218831)
                  : const Color(0xFF9D1414),
            ),
          ),
        ),
        TableFieldColumn(
          title: 'Harga',
          width: 140.w,
          headerTextAlign: TextAlign.center,
          cellTextAlign: TextAlign.center,
          valueBuilder: (p) => formatRupiah(p.price, prefix: ''),
          cellBuilder: (p) => TextButton(
            onPressed: () => _prices(p),
            child: Text(
              p.onlinePrice != null || p.variations.isNotEmpty
                  ? '${1 + (p.onlinePrice != null ? 1 : 0) + p.variations.length} Harga'
                  : formatRupiah(p.price, prefix: ''),
              style: catalogText(17, color: catalogAccent),
            ),
          ),
        ),
        TableFieldColumn(
          title: '',
          width: 46.w,
          valueBuilder: (_) => '',
          cellBuilder: (p) => IconButton(
            tooltip: 'Ubah ${p.name}',
            onPressed: () => _edit(p),
            icon: catalogIcon('edit'),
          ),
        ),
      ],
    );
  }

  void _prices(CatalogProduct product) => showDialog<void>(
    context: context,
    builder: (c) => AlertDialog(
      title: Text(product.name),
      content: SizedBox(
        width: 440.w,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Harga Jual: ${formatRupiah(product.price)}'),
              if (product.onlinePrice != null)
                Text(
                  'Harga Jual Online: ${formatRupiah(product.onlinePrice!)}',
                ),
              ...product.variations.map(
                (v) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(v.name),
                  subtitle: Text(
                    '${formatRupiah(v.price)} • ${v.stockStatus == 'available' ? 'Tersedia' : 'Habis'}${v.onlinePrice == null ? '' : '\nOnline: ${formatRupiah(v.onlinePrice!)}'}',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(c),
          child: const Text('Tutup'),
        ),
      ],
    ),
  );
}
