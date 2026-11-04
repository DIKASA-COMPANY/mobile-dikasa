import 'package:flutter/material.dart';
import 'package:mobile_dikasa/data/models/pos.dart';
import 'browser_design.dart';

class CustomerBrowserBody extends StatelessWidget {
  const CustomerBrowserBody({super.key, required this.page});
  final PosPage page;
  @override
  Widget build(BuildContext c) => BrowserTable(
    headers: const ['Nama', 'Alamat', 'Poin', 'Gender', 'Telefon', 'Email'],
    fractions: const [
      200 / 1248,
      330 / 1248,
      120 / 1248,
      140 / 1248,
      220 / 1248,
      238 / 1248,
    ],
    leftPadding: const [78, 45, 47, 39, 64, 17],
    rows: page.items
        .map(
          (i) => [
            Text(_value(i['name'])),
            Text(_value(i['address'])),
            Text('${i['points'] ?? 0}'),
            Text(_value(i['gender'] is Map ? i['gender']['name'] : null)),
            Text(_value(i['phone_number'])),
            Text(_value(i['email'])),
          ],
        )
        .toList(),
  );
  String _value(dynamic v) =>
      v == null || v.toString().trim().isEmpty ? '—' : v.toString();
}
