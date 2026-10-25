import 'package:flutter/material.dart';
import 'package:mobile_dikasa/data/services/catalog_files.dart';
import 'package:mobile_dikasa/components/text_field/main.dart';
import 'package:mobile_dikasa/core/network/api_exception.dart';
import 'package:mobile_dikasa/core/utils/formatted_currency.dart';
import 'package:mobile_dikasa/data/models/catalog_product.dart';
import 'package:mobile_dikasa/data/models/user.dart';
import 'package:mobile_dikasa/data/services/catalog_service.dart';
import 'categories.dart';
import 'stock_panel.dart';
import 'variant_editor.dart';
import 'widgets.dart';

class ProductEditor extends StatefulWidget {
  const ProductEditor({
    super.key,
    required this.service,
    this.product,
    this.user,
    this.onChanged,
    this.files = const CatalogFiles(),
  });
  final CatalogService service;
  final CatalogFiles files;
  final CatalogProduct? product;
  final User? user;
  final VoidCallback? onChanged;
  @override
  State<ProductEditor> createState() => _ProductEditorState();
}

class _ProductEditorState extends State<ProductEditor> {
  final _form = GlobalKey<FormState>();
  final _name = TextEditingController(), _note = TextEditingController();
  final _price = TextEditingController(), _online = TextEditingController();
  final _cost = TextEditingController(), _onlineCost = TextEditingController();
  CatalogProduct? _original;
  List<Map<String, dynamic>> _types = [];
  List<CatalogCategory> _categories = [];
  List<CatalogVariant> _variants = [];
  String _type = 'food', _stock = 'available';
  String? _categoryId, _error;
  bool _loading = true, _saving = false, _dirty = false, _changed = false;
  bool _variantsDirty = false, _uncertain = false, _leaving = false;
  bool _active = true;
  CatalogImage? _image;
  bool _removeImage = false, _picking = false, _exporting = false;
  int _request = 0;

  @override
  void initState() {
    super.initState();
    _original = widget.product;
    _fill(widget.product);
    _load();
  }

  void _fill(CatalogProduct? p) {
    _image = null;
    _removeImage = false;
    _name.text = p?.name ?? '';
    _note.text = p?.description ?? '';
    _price.text = p?.price.toString() ?? '';
    _online.text = p?.onlinePrice?.toString() ?? '';
    _cost.text = p?.costPrice?.toString() ?? '';
    _onlineCost.text = p?.onlineCostPrice?.toString() ?? '';
    _type = p?.productType ?? _type;
    _stock = p?.stockStatus ?? 'available';
    _categoryId = p?.category.id;
    _variants = [...?p?.variations];
    _variantsDirty = false;
    _active = p?.isActive ?? true;
  }

  @override
  void dispose() {
    _request++;
    for (final c in [_name, _note, _price, _online, _cost, _onlineCost]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _load() async {
    final request = ++_request;
    final type = _type;
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final types = await widget.service.types();
      final categories = await widget.service.categories(type);
      if (!mounted || request != _request) return;
      setState(() {
        _types = types;
        _categories = categories;
        if (!_categories.any((c) => c.id == _categoryId)) _categoryId = null;
        _loading = false;
      });
    } on ApiException catch (e) {
      if (mounted && request == _request) {
        setState(() {
          _error = e.message;
          _loading = false;
        });
      }
    }
  }

  Future<bool> _canLeave() async {
    if (_saving) return false;
    if (!_dirty || _uncertain) return true;
    return catalogConfirm(
      context,
      'Tinggalkan perubahan?',
      'Perubahan yang belum disimpan akan hilang.',
    );
  }

  Future<void> _back() async {
    if (!await _canLeave() || !mounted) return;
    setState(() => _leaving = true);
    await WidgetsBinding.instance.endOfFrame;
    if (mounted) Navigator.pop(context, _changed || _uncertain);
  }

  Future<void> _save({bool another = false}) async {
    if (_saving || _uncertain || _loading || !_form.currentState!.validate()) {
      return;
    }
    final category = _categories.firstWhere((c) => c.id == _categoryId);
    final product = CatalogProduct(
      id: _original?.id ?? '',
      name: _name.text,
      category: category,
      productType: _type,
      price: int.parse(_price.text.trim()),
      onlinePrice: int.tryParse(_online.text.trim()),
      costPrice: int.tryParse(_cost.text.trim()),
      onlineCostPrice: int.tryParse(_onlineCost.text.trim()),
      stockStatus: _stock,
      description: _note.text,
      variations: _variants,
      isHighlighted: _original?.isHighlighted ?? false,
      isActive: _active,
      sortOrder: _original?.sortOrder ?? 0,
      imageUrl: _original?.imageUrl,
      image: _image,
      removeImage: _removeImage,
    );
    setState(() {
      _saving = true;
      _error = null;
    });
    try {
      await widget.service.saveProduct(
        product,
        id: _original?.id,
        replaceVariations: _variantsDirty,
      );
      widget.onChanged?.call();
      if (!mounted) return;
      _changed = true;
      _dirty = false;
      if (another) {
        setState(() {
          _form.currentState?.reset();
          _original = null;
          _fill(null);
          _dirty = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Produk tersimpan. Isi produk berikutnya.'),
          ),
        );
      } else {
        setState(() => _leaving = true);
        await WidgetsBinding.instance.endOfFrame;
        if (mounted) Navigator.pop(context, true);
      }
    } on ApiException catch (e) {
      if (mounted) {
        setState(() {
          _error = e.message;
          _uncertain = e is CatalogWriteUncertain;
        });
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _pickImage() async {
    if (_picking || _saving || _uncertain) return;
    setState(() => _picking = true);
    try {
      final image = await widget.files.pickImage();
      if (mounted && image != null) {
        setState(() {
          _image = image;
          _removeImage = false;
          _dirty = true;
        });
      }
    } on ApiException catch (e) {
      if (mounted) setState(() => _error = e.message);
    } finally {
      if (mounted) setState(() => _picking = false);
    }
  }

  Future<void> _export() async {
    if (_original == null || _exporting) return;
    setState(() => _exporting = true);
    try {
      final bytes = await widget.service.exportProducts(
        productId: _original!.id,
        filters: {'include_inactive': true},
      );
      await widget.files.saveWorkbook(bytes);
    } on ApiException catch (e) {
      if (mounted) setState(() => _error = e.message);
    } finally {
      if (mounted) setState(() => _exporting = false);
    }
  }

  Future<void> _variant({int? index}) async {
    final value = await editVariant(
      context,
      index == null ? null : _variants[index],
      existingNames: _variants.indexed
          .where((entry) => entry.$1 != index)
          .map((entry) => entry.$2.name)
          .toList(),
    );
    if (value != null && mounted) {
      setState(() {
        if (index == null) {
          _variants.add(value);
        } else {
          _variants[index] = value;
        }
        _variantsDirty = true;
        _dirty = true;
      });
    }
  }

  Widget _input(
    TextEditingController controller,
    String hint,
    String icon, {
    bool price = false,
    int? originalValue,
    bool required = false,
    Key? key,
  }) => AppTextField(
    key: key,
    controller: controller,
    hintText: hint,
    enabled: !_saving && !_uncertain,
    backgroundColor: Colors.white,
    borderColor: const Color(0xFFD6D6D6),
    borderRadius: 10,
    keyboardType: price ? TextInputType.number : TextInputType.text,
    prefixIcon: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: catalogIcon(icon),
    ),
    textStyle: catalogText(17),
    hintStyle: catalogText(17, color: const Color(0xFFAAAAAA)),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    validator: (v) {
      final text = v?.trim() ?? '';
      if (text.isEmpty) {
        if (required) {
          return price ? 'Harga jual wajib diisi.' : 'Nama produk wajib diisi.';
        }
        if (price && originalValue != null) {
          return 'Harga tersimpan tidak dapat dikosongkan. Masukkan angka (0 diperbolehkan).';
        }
        return null;
      }
      if (price) return validateCatalogPrice(text);
      if (required && text.length > 150) return 'Maksimal 150 karakter.';
      return null;
    },
  );

  Widget _dropdown({
    required String label,
    required String icon,
    required String? value,
    required List<DropdownMenuItem<String>> items,
    required ValueChanged<String?> onChanged,
    bool required = false,
  }) => DropdownButtonFormField<String>(
    key: ValueKey('$label:$value:${_categories.map((c) => c.id).join(',')}'),
    initialValue: value,
    isExpanded: true,
    style: catalogText(17),
    icon: catalogIcon('down'),
    decoration: InputDecoration(
      hintText: label,
      hintStyle: catalogText(17, color: const Color(0xFFAAAAAA)),
      filled: true,
      fillColor: const Color(0xFFEAEAEA),
      prefixIcon: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: catalogIcon(icon),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFFD6D6D6)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFFD6D6D6)),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    ),
    items: items,
    onChanged: _saving || _uncertain || _loading ? null : onChanged,
    validator: (v) => required && v == null ? 'Pilih kategori produk.' : null,
  );

  @override
  Widget build(BuildContext context) => PopScope(
    canPop: _leaving || (!_dirty && !_saving),
    onPopInvokedWithResult: (didPop, _) {
      if (!didPop) _back();
    },
    child: CatalogShell(
      title: _original == null ? 'Tambah Produk' : 'Ubah Produk',
      user: widget.user,
      onBack: _back,
      canLeave: _canLeave,
      actions: [
        SizedBox(
          width: 205,
          child: Tooltip(
            message: _original == null
                ? 'Simpan produk dahulu untuk mengekspor.'
                : 'Unduh data produk tersimpan',
            child: CatalogButton(
              _exporting ? 'Mengunduh…' : 'Export File Excel',
              onPressed: _original == null || _exporting || _saving
                  ? null
                  : _export,
            ),
          ),
        ),
        SizedBox(
          width: 253,
          child: CatalogButton(
            'Simpan & Buat Lagi',
            onPressed: _saving || _uncertain || _loading
                ? null
                : () => _save(another: true),
          ),
        ),
        SizedBox(
          width: 160,
          child: CatalogButton(
            _saving ? 'Menyimpan…' : 'Simpan',
            key: const Key('save-product'),
            color: catalogOrange,
            onPressed: _saving || _uncertain || _loading ? null : _save,
          ),
        ),
      ],
      child: SingleChildScrollView(
        child: LayoutBuilder(
          builder: (context, c) {
            final small = c.maxWidth < 850;
            return Padding(
              padding: EdgeInsets.fromLTRB(
                small ? 20 : 49,
                32,
                small ? 20 : 45,
                32,
              ),
              child: Form(
                key: _form,
                onChanged: () {
                  if (!_dirty) setState(() => _dirty = true);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (_error != null)
                      catalogError(
                        _error!,
                        retry: _uncertain || _saving ? null : _load,
                      ),
                    if (_loading) const LinearProgressIndicator(),
                    if (small) ...[
                      _info(),
                      const SizedBox(height: 28),
                      _photo(),
                    ] else
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(flex: 3, child: _info()),
                          const SizedBox(width: 29),
                          Expanded(child: _photo()),
                        ],
                      ),
                    const SizedBox(height: 32),
                    _pricing(small),
                    const SizedBox(height: 28),
                    StockPanel(
                      service: widget.service,
                      product: _original,
                      enabled: !_saving && !_uncertain,
                      onChanged: () async {
                        try {
                          final refreshed = await widget.service.product(
                            _original!.id,
                          );
                          if (mounted) {
                            setState(() {
                              _original = refreshed;
                              _changed = true;
                            });
                          }
                          widget.onChanged?.call();
                        } on ApiException catch (e) {
                          if (mounted) setState(() => _error = e.message);
                        }
                      },
                    ),
                    const SizedBox(height: 28),
                    if (_original != null)
                      CheckboxListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          'Aktif dalam katalog',
                          style: catalogText(16),
                        ),
                        subtitle: const Text(
                          'Produk nonaktif tidak muncul di kasir. Gunakan filter produk nonaktif untuk mengaktifkannya kembali.',
                        ),
                        value: _active,
                        onChanged: _saving || _uncertain
                            ? null
                            : (v) => setState(() {
                                _active = v!;
                                _dirty = true;
                              }),
                      ),
                    Text(
                      'Harga dalam Rupiah utuh, tanpa titik atau koma. Harga opsional yang sudah tersimpan harus tetap berupa angka saat diubah.',
                      style: catalogText(13, italic: true),
                    ),
                    const SizedBox(height: 32),
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
      ),
    ),
  );

  Widget _info() => CatalogSection(
    title: 'Informasi Produk',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 0),
        _input(
          _name,
          'Nama Produk',
          'name',
          required: true,
          key: const Key('product-name'),
        ),
        const SizedBox(height: 28),
        _dropdown(
          label: 'Kategori Produk',
          icon: 'category',
          value: _categoryId,
          required: true,
          items: _categories
              .map(
                (c) => DropdownMenuItem(
                  value: c.id,
                  child: Text(c.name, overflow: TextOverflow.ellipsis),
                ),
              )
              .toList(),
          onChanged: (v) => setState(() {
            _categoryId = v;
            _dirty = true;
          }),
        ),
        const SizedBox(height: 6),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              'Kategori Tidak Tersedia?',
              style: catalogText(
                16,
                color: const Color(0xFF979797),
                italic: true,
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              onPressed: _saving || _uncertain
                  ? null
                  : () async {
                      await manageCategories(
                        context,
                        widget.service,
                        initialType: _type,
                        onChanged: () {
                          _changed = true;
                          widget.onChanged?.call();
                        },
                      );
                      if (mounted) _load();
                    },
              child: Text(
                'Tambahkan Kategori Baru',
                style: catalogText(16, color: catalogAccent),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        LayoutBuilder(
          builder: (context, c) {
            final type = _dropdown(
              label: 'Jenis Produk',
              icon: 'type',
              value: _types.any((t) => t['code'] == _type) ? _type : null,
              items: _types
                  .map(
                    (t) => DropdownMenuItem(
                      value: t['code'] as String,
                      child: Text(t['name'] as String),
                    ),
                  )
                  .toList(),
              onChanged: (v) {
                if (v == null) return;
                setState(() {
                  _type = v;
                  _categoryId = null;
                  _categories = [];
                  _dirty = true;
                });
                _load();
              },
            );
            final stock = _dropdown(
              label: 'Status Stock',
              icon: 'stock',
              value: _stock,
              items: const [
                DropdownMenuItem(value: 'available', child: Text('Tersedia')),
                DropdownMenuItem(value: 'out_of_stock', child: Text('Habis')),
              ],
              onChanged: (v) => setState(() {
                _stock = v!;
                _dirty = true;
              }),
            );
            return c.maxWidth < 500
                ? Column(children: [type, const SizedBox(height: 20), stock])
                : Row(
                    children: [
                      Expanded(child: type),
                      const SizedBox(width: 26),
                      Expanded(child: stock),
                    ],
                  );
          },
        ),
        const SizedBox(height: 28),
        _input(_note, 'Catatan Tambahan', 'note'),
      ],
    ),
  );

  Widget _photo() => CatalogSection(
    title: 'Foto Produk',
    padding: const EdgeInsets.fromLTRB(27, 22, 27, 26),
    child: Column(
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: CustomPaint(
            foregroundPainter: const CatalogPhotoBorder(),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFE6E6E6),
                borderRadius: BorderRadius.circular(10),
              ),
              child: _image != null
                  ? Image.memory(_image!.bytes, fit: BoxFit.cover)
                  : !_removeImage && _original?.imageUrl != null
                  ? Image.network(
                      _original!.imageUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) =>
                          Center(child: catalogIcon('camera')),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        catalogIcon('camera'),
                        const SizedBox(height: 20),
                        Text(
                          'Foto Produk',
                          style: catalogText(
                            22,
                            color: const Color(0xFFBBBBBB),
                            weight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
        const SizedBox(height: 26),
        Tooltip(
          message: 'PNG/JPEG maksimal 3 MiB.',
          child: SizedBox(
            height: 63,
            width: double.infinity,
            child: OutlinedButton(
              onPressed: _saving || _uncertain || _picking ? null : _pickImage,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: catalogAccent, width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Upload Foto',
                style: catalogText(
                  18,
                  color: catalogAccent,
                  weight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
        if (_image != null || (!_removeImage && _original?.imageUrl != null))
          TextButton(
            onPressed: _saving || _uncertain
                ? null
                : () => setState(() {
                    _image = null;
                    _removeImage = true;
                    _dirty = true;
                  }),
            child: const Text('Hapus Foto'),
          ),
      ],
    ),
  );

  Widget _pricing(bool small) {
    final fields = Column(
      children: [
        _pair(
          _input(
            _price,
            'Harga Jual',
            'price',
            price: true,
            required: true,
            key: const Key('product-price'),
          ),
          _input(
            _online,
            'Harga Jual Online (Opsional)',
            'price',
            price: true,
            originalValue: _original?.onlinePrice,
          ),
          small,
        ),
        const SizedBox(height: 28),
        _pair(
          _input(
            _cost,
            'Harga Modal (Opsional)',
            'wallet',
            price: true,
            originalValue: _original?.costPrice,
          ),
          _input(
            _onlineCost,
            'Harga Modal Online (Opsional)',
            'wallet',
            price: true,
            originalValue: _original?.onlineCostPrice,
          ),
          small,
        ),
      ],
    );
    return CatalogSection(
      title: 'Harga Produk',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (small) ...[
            fields,
            const SizedBox(height: 24),
            CatalogButton(
              'Tambah Variasi',
              color: catalogAccent,
              onPressed: _saving || _uncertain ? null : _variant,
              height: 63,
            ),
          ] else
            Row(
              children: [
                Expanded(flex: 4, child: fields),
                const SizedBox(width: 70),
                Expanded(
                  child: CatalogButton(
                    'Tambah Variasi',
                    color: catalogAccent,
                    onPressed: _saving || _uncertain ? null : _variant,
                    height: 63,
                  ),
                ),
              ],
            ),
          if (_variants.isNotEmpty) ...[
            const SizedBox(height: 24),
            Text(
              'Variasi Produk',
              style: catalogText(18, weight: FontWeight.w600),
            ),
            ..._variants.indexed.map(
              (entry) => ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(entry.$2.name),
                subtitle: Text(
                  '${formatRupiah(entry.$2.price)} • ${entry.$2.stockStatus == 'available' ? 'Tersedia' : 'Habis'}',
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      tooltip: 'Ubah variasi',
                      icon: catalogIcon('edit'),
                      onPressed: _saving || _uncertain
                          ? null
                          : () => _variant(index: entry.$1),
                    ),
                    IconButton(
                      tooltip: 'Hapus variasi',
                      icon: const Icon(Icons.close),
                      onPressed: _saving || _uncertain
                          ? null
                          : () => setState(() {
                              _variants.removeAt(entry.$1);
                              _dirty = true;
                              _variantsDirty = true;
                            }),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _pair(Widget a, Widget b, bool small) => small
      ? Column(children: [a, const SizedBox(height: 28), b])
      : Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: a),
            const SizedBox(width: 35),
            Expanded(child: b),
          ],
        );
}
