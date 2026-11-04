import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/utils/formatted_currency.dart';

const cashBlue = Color(0xff529dc8),
    cashDark = Color(0xff2c5e7a),
    cashOrange = Color(0xffff8227);
String movementMoney(int n) => formatRupiah(n, prefix: 'Rp ');
String cashWIB(String? source) {
  final d = DateTime.tryParse(source ?? '');
  if (d == null) return 'Waktu tidak tercatat';
  final w = d.toUtc().add(const Duration(hours: 7));
  String two(int n) => n.toString().padLeft(2, '0');
  return '${two(w.day)}/${two(w.month)}/${w.year} ${two(w.hour)}:${two(w.minute)} WIB';
}

/// Original downloaded icons retain natural SVG geometry inside their exact slots.
class CashIcon extends StatelessWidget {
  const CashIcon(this.name, {super.key});
  final String name;
  @override
  Widget build(BuildContext c) {
    final v = {
      'add': ('assets/icons/catalog_filter.svg', 20.0, 20.0),
      'amount': ('assets/icons/cash_movement_amount.svg', 23.4998, 21.6533),
      'back': ('assets/icons/catalog_back.svg', 32.0, 25.0),
      'camera': ('assets/icons/catalog_camera.svg', 122.002, 114.0),
      'close': ('assets/icons/cash_movement_close.svg', 30.0, 30.0),
      'down': ('assets/icons/cash_movement_down.svg', 21.7061, 10.0653),
      'lock': ('assets/icons/catalog_lock.svg', 46.0, 46.0),
      'menu': ('assets/icons/catalog_menu.svg', 34.4, 26.0),
      'name': ('assets/icons/cash_movement_name.svg', 22.0, 22.4913),
      'note': ('assets/icons/cash_movement_note.svg', 22.5435, 23.4999),
      'type': ('assets/icons/cash_movement_type.svg', 22.0, 18.413),
    }[name]!;
    return SizedBox(width: v.$2, height: v.$3, child: SvgPicture.asset(v.$1));
  }
}
