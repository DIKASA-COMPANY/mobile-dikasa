import 'dart:convert';
import 'dart:typed_data';

/// Minimal uncompressed XLSX for offline demo exports; strings are never formulas.
Uint8List mockProductWorkbook(List<Map<String, dynamic>> products) {
  final rows = <List<Object?>>[
    [
      'ID',
      'Produk',
      'Kategori',
      'Jenis',
      'Variasi',
      'Harga',
      'Online',
      'Modal',
      'Modal Online',
      'Status',
      'Lacak Stok',
      'Jumlah',
      'Batas Menipis',
      'Aktif',
      'Catatan',
    ],
  ];
  for (final p in products) {
    rows.add([
      p['id'],
      p['name'],
      (p['category'] as Map)['name'],
      p['product_type'],
      '',
      p['selling_price'],
      p['online_selling_price'],
      p['cost_price'],
      p['online_cost_price'],
      p['effective_stock_status'] ?? p['stock_status'],
      p['track_stock'] ?? false,
      if (p['track_stock'] == true) p['stock_quantity'] else null,
      if (p['track_stock'] == true) p['low_stock_threshold'] else null,
      p['is_active'],
      p['description'],
    ]);
    for (final v in p['variations'] as List) {
      rows.add([
        p['id'],
        p['name'],
        (p['category'] as Map)['name'],
        p['product_type'],
        v['name'],
        v['selling_price'],
        v['online_selling_price'],
        v['cost_price'],
        v['online_cost_price'],
        v['stock_status'],
        '',
        null,
        null,
        v['is_active'] ?? true,
        '',
      ]);
    }
  }
  return mockLiteralWorkbook(rows, sheetName: 'Produk');
}

/// Literal-cell workbook shared by memory-only catalog and report exports.
Uint8List mockLiteralWorkbook(
  List<List<Object?>> rows, {
  String sheetName = 'Laporan',
}) {
  String escape(Object? value) => (value?.toString() ?? '')
      .replaceAll('&', '&amp;')
      .replaceAll('<', '&lt;')
      .replaceAll('>', '&gt;')
      .replaceAll('"', '&quot;');
  final sheet = StringBuffer(
    '<?xml version="1.0" encoding="UTF-8"?><worksheet xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main"><sheetData>',
  );
  for (var r = 0; r < rows.length; r++) {
    sheet.write('<row r="${r + 1}">');
    for (var c = 0; c < rows[r].length; c++) {
      final v = rows[r][c];
      final ref = '${String.fromCharCode(65 + c)}${r + 1}';
      sheet.write(
        v is num
            ? '<c r="$ref"><v>$v</v></c>'
            : '<c r="$ref" t="inlineStr"><is><t>${escape(v)}</t></is></c>',
      );
    }
    sheet.write('</row>');
  }
  sheet.write('</sheetData></worksheet>');
  final parts = <String, String>{
    '[Content_Types].xml':
        '<Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types"><Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/><Default Extension="xml" ContentType="application/xml"/><Override PartName="/xl/workbook.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet.main+xml"/><Override PartName="/xl/worksheets/sheet1.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.worksheet+xml"/></Types>',
    '_rels/.rels':
        '<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships"><Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument" Target="xl/workbook.xml"/></Relationships>',
    'xl/workbook.xml':
        '<workbook xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships"><sheets><sheet name="${escape(sheetName)}" sheetId="1" r:id="rId1"/></sheets></workbook>',
    'xl/_rels/workbook.xml.rels':
        '<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships"><Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/worksheet" Target="worksheets/sheet1.xml"/></Relationships>',
    'xl/worksheets/sheet1.xml': sheet.toString(),
  };
  return _storedZip(parts);
}

int _crc32(List<int> data) {
  var crc = 0xffffffff;
  for (final b in data) {
    crc ^= b;
    for (var i = 0; i < 8; i++) {
      crc = (crc & 1) != 0 ? (crc >>> 1) ^ 0xedb88320 : crc >>> 1;
    }
  }
  return (crc ^ 0xffffffff) & 0xffffffff;
}

Uint8List _storedZip(Map<String, String> parts) {
  final output = BytesBuilder(), central = BytesBuilder();
  var offset = 0;
  for (final entry in parts.entries) {
    final name = utf8.encode(entry.key), data = utf8.encode(entry.value);
    final crc = _crc32(data);
    final h = ByteData(30)
      ..setUint32(0, 0x04034b50, Endian.little)
      ..setUint16(4, 20, Endian.little)
      ..setUint16(6, 0x800, Endian.little)
      ..setUint16(12, 0x21, Endian.little)
      ..setUint32(14, crc, Endian.little)
      ..setUint32(18, data.length, Endian.little)
      ..setUint32(22, data.length, Endian.little)
      ..setUint16(26, name.length, Endian.little);
    output.add(h.buffer.asUint8List());
    output.add(name);
    output.add(data);
    final c = ByteData(46)
      ..setUint32(0, 0x02014b50, Endian.little)
      ..setUint16(4, 20, Endian.little)
      ..setUint16(6, 20, Endian.little)
      ..setUint16(8, 0x800, Endian.little)
      ..setUint16(14, 0x21, Endian.little)
      ..setUint32(16, crc, Endian.little)
      ..setUint32(20, data.length, Endian.little)
      ..setUint32(24, data.length, Endian.little)
      ..setUint16(28, name.length, Endian.little)
      ..setUint32(42, offset, Endian.little);
    central.add(c.buffer.asUint8List());
    central.add(name);
    offset += 30 + name.length + data.length;
  }
  final directory = central.takeBytes();
  output.add(directory);
  final end = ByteData(22)
    ..setUint32(0, 0x06054b50, Endian.little)
    ..setUint16(8, parts.length, Endian.little)
    ..setUint16(10, parts.length, Endian.little)
    ..setUint32(12, directory.length, Endian.little)
    ..setUint32(16, offset, Endian.little);
  output.add(end.buffer.asUint8List());
  return output.takeBytes();
}
