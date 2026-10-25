import 'package:flutter/material.dart';
import 'package:mobile_dikasa/components/text_field/main.dart';
import 'package:mobile_dikasa/data/models/catalog_product.dart';

String? validateCatalogPrice(String text) {
  final value = int.tryParse(text);
  if (!RegExp(r'^\d+$').hasMatch(text) ||
      value == null ||
      value > 9007199254740991) {
    return 'Gunakan angka Rupiah utuh yang valid (0 atau lebih).';
  }
  return null;
}

Future<CatalogVariant?> editVariant(
  BuildContext context,
  CatalogVariant? variant, {
  required List<String> existingNames,
}) async => showDialog<CatalogVariant>(
  context: context,
  barrierDismissible: false,
  builder: (_) =>
      _VariantEditor(variant: variant, existingNames: existingNames),
);

class _VariantEditor extends StatefulWidget {
  const _VariantEditor({this.variant, required this.existingNames});
  final CatalogVariant? variant;
  final List<String> existingNames;
  @override
  State<_VariantEditor> createState() => _VariantEditorState();
}

class _VariantEditorState extends State<_VariantEditor> {
  final form = GlobalKey<FormState>();
  late final List<TextEditingController> fields;
  late String stock;
  @override
  void initState() {
    super.initState();
    final v = widget.variant;
    fields = [
      v?.name ?? '',
      v?.price.toString() ?? '',
      v?.onlinePrice?.toString() ?? '',
      v?.costPrice?.toString() ?? '',
      v?.onlineCostPrice?.toString() ?? '',
    ].map((s) => TextEditingController(text: s)).toList();
    stock = v?.stockStatus ?? 'available';
  }

  @override
  void dispose() {
    for (final f in fields) {
      f.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: Text(widget.variant == null ? 'Tambah Variasi' : 'Ubah Variasi'),
    content: SizedBox(
      width: 560,
      child: SingleChildScrollView(
        child: Form(
          key: form,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (var i = 0; i < fields.length; i++)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: AppTextField(
                    controller: fields[i],
                    label: [
                      'Nama Variasi',
                      'Harga Jual',
                      'Harga Jual Online (Opsional)',
                      'Harga Modal (Opsional)',
                      'Harga Modal Online (Opsional)',
                    ][i],
                    keyboardType: i == 0
                        ? TextInputType.text
                        : TextInputType.number,
                    validator: (v) {
                      final text = v?.trim() ?? '';
                      if (text.isEmpty) return i < 2 ? 'Wajib diisi.' : null;
                      if (i > 0) return validateCatalogPrice(text);
                      if (text.length > 100) return 'Maksimal 100 karakter.';
                      if (widget.existingNames.any(
                        (name) =>
                            name.trim().toLowerCase() == text.toLowerCase(),
                      )) {
                        return 'Nama variasi sudah dipakai.';
                      }
                      return null;
                    },
                  ),
                ),
              DropdownButtonFormField<String>(
                initialValue: stock,
                decoration: const InputDecoration(labelText: 'Status Stock'),
                items: const [
                  DropdownMenuItem(value: 'available', child: Text('Tersedia')),
                  DropdownMenuItem(value: 'out_of_stock', child: Text('Habis')),
                ],
                onChanged: (v) => stock = v!,
              ),
            ],
          ),
        ),
      ),
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text('Batal'),
      ),
      FilledButton(
        onPressed: () {
          if (!form.currentState!.validate()) return;
          Navigator.pop(
            context,
            CatalogVariant(
              name: fields[0].text.trim(),
              price: int.parse(fields[1].text.trim()),
              onlinePrice: int.tryParse(fields[2].text.trim()),
              costPrice: int.tryParse(fields[3].text.trim()),
              onlineCostPrice: int.tryParse(fields[4].text.trim()),
              stockStatus: stock,
              sortOrder: widget.variant?.sortOrder ?? 0,
            ),
          );
        },
        child: const Text('Simpan Variasi'),
      ),
    ],
  );
}
