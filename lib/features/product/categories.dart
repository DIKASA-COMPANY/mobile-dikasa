import 'package:flutter/material.dart';
import 'package:mobile_dikasa/components/text_field/main.dart';
import 'package:mobile_dikasa/core/network/api_exception.dart';
import 'package:mobile_dikasa/data/models/catalog_product.dart';
import 'package:mobile_dikasa/data/services/catalog_service.dart';
import 'widgets.dart';

/// Reports successful category writes while the dialog remains open.
Future<void> manageCategories(
  BuildContext context,
  CatalogService service, {
  String initialType = 'food',
  required VoidCallback onChanged,
}) => showDialog<void>(
  context: context,
  barrierDismissible: false,
  builder: (_) => _Categories(
    service: service,
    initialType: initialType,
    onChanged: onChanged,
  ),
);

class _Categories extends StatefulWidget {
  const _Categories({
    required this.service,
    required this.initialType,
    required this.onChanged,
  });
  final CatalogService service;
  final String initialType;
  final VoidCallback onChanged;
  @override
  State<_Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<_Categories> {
  final name = TextEditingController();
  final form = GlobalKey<FormState>();
  late String type;
  List<Map<String, dynamic>> types = [];
  List<CatalogCategory> categories = [];
  CatalogCategory? editing;
  bool loading = true, saving = false, uncertain = false;
  String? error;
  int generation = 0;
  @override
  void initState() {
    super.initState();
    type = widget.initialType;
    load();
  }

  @override
  void dispose() {
    generation++;
    name.dispose();
    super.dispose();
  }

  Future<void> load() async {
    final request = ++generation;
    setState(() {
      loading = true;
      error = null;
    });
    try {
      final nextTypes = await widget.service.types();
      final values = await widget.service.categories(type);
      if (!mounted || request != generation) return;
      setState(() {
        types = nextTypes;
        categories = values;
        loading = false;
      });
    } on ApiException catch (e) {
      if (mounted && request == generation) {
        setState(() {
          error = e.message;
          loading = false;
        });
      }
    }
  }

  Future<void> save() async {
    if (saving || uncertain || !form.currentState!.validate()) return;
    setState(() {
      saving = true;
      error = null;
    });
    try {
      await widget.service.saveCategory(
        type,
        CatalogCategory(
          id: editing?.id ?? '',
          name: name.text,
          sortOrder: editing?.sortOrder ?? 0,
          isActive: editing?.isActive ?? true,
        ),
      );
      widget.onChanged();
      if (!mounted) return;
      setState(() {
        editing = null;
        name.clear();
      });
      await load();
    } on ApiException catch (e) {
      if (mounted) {
        setState(() {
          error = e.message;
          uncertain = e is CatalogWriteUncertain;
        });
      }
    } finally {
      if (mounted) setState(() => saving = false);
    }
  }

  @override
  Widget build(BuildContext context) => PopScope(
    canPop: !saving,
    child: AlertDialog(
      title: const Text('Kelola Kategori'),
      content: SizedBox(
        width: 560,
        child: SingleChildScrollView(
          child: Form(
            key: form,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (error != null)
                  catalogError(
                    error!,
                    retry: uncertain || saving ? null : load,
                  ),
                DropdownButtonFormField<String>(
                  initialValue: type,
                  decoration: const InputDecoration(labelText: 'Jenis Produk'),
                  items: types
                      .map(
                        (t) => DropdownMenuItem(
                          value: t['code'] as String,
                          child: Text(t['name'] as String),
                        ),
                      )
                      .toList(),
                  onChanged: saving || uncertain
                      ? null
                      : (v) {
                          if (v == null) return;
                          setState(() {
                            type = v;
                            editing = null;
                            name.clear();
                            categories = [];
                          });
                          load();
                        },
                ),
                const SizedBox(height: 16),
                if (loading) const LinearProgressIndicator(),
                if (!loading && categories.isEmpty)
                  const Text('Belum ada kategori. Tambahkan kategori pertama.'),
                ...categories.map(
                  (c) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(c.name),
                    trailing: IconButton(
                      tooltip: 'Ubah ${c.name}',
                      icon: catalogIcon('edit'),
                      onPressed: saving || uncertain
                          ? null
                          : () => setState(() {
                              editing = c;
                              name.text = c.name;
                            }),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                AppTextField(
                  controller: name,
                  label: editing == null
                      ? 'Nama kategori baru'
                      : 'Ubah nama kategori',
                  enabled: !saving && !uncertain,
                  validator: (v) => v == null || v.trim().isEmpty
                      ? 'Nama kategori wajib diisi.'
                      : v.trim().length > 100
                      ? 'Maksimal 100 karakter.'
                      : null,
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: saving ? null : () => Navigator.pop(context),
          child: const Text('Selesai'),
        ),
        if (editing != null)
          TextButton(
            onPressed: saving
                ? null
                : () => setState(() {
                    editing = null;
                    name.clear();
                  }),
            child: const Text('Batal ubah'),
          ),
        FilledButton(
          onPressed: loading || saving || uncertain ? null : save,
          child: Text(
            saving
                ? 'Menyimpan…'
                : editing == null
                ? 'Tambah Kategori'
                : 'Simpan Kategori',
          ),
        ),
      ],
    ),
  );
}
