import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Original Figma icons keep their natural SVG root dimensions.
class AccountIcon extends StatelessWidget {
  const AccountIcon(this.name, {super.key});
  final String name;
  @override
  Widget build(BuildContext c) {
    final a = {
      'back': ('assets/icons/catalog_back.svg', 32.0, 25.0),
      'calendar': ('assets/icons/account_design_calendar.svg', 23.8, 26.2444),
      'down': ('assets/icons/catalog_down.svg', 15.9199, 9.13601),
      'email': ('assets/icons/account_design_email.svg', 23.5, 16.5),
      'gender': ('assets/icons/account_design_gender.png', 256.0, 256.0),
      'location': (
        'assets/icons/account_design_location.svg',
        23.8024,
        27.3076,
      ),
      'lock': ('assets/icons/catalog_lock.svg', 46.0, 46.0),
      'menu': ('assets/icons/catalog_menu.svg', 34.4, 26.0),
      'phone': ('assets/icons/account_design_phone.svg', 22.0, 22.0),
      'profile': ('assets/icons/account_design_profile.svg', 24.0, 24.0002),
    }[name]!;
    return SizedBox(
      width: a.$2,
      height: a.$3,
      child: a.$1.endsWith('.png') ? Image.asset(a.$1) : SvgPicture.asset(a.$1),
    );
  }
}
