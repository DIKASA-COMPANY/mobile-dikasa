import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'view_model.dart';

class CredentialForm extends StatefulWidget {
  const CredentialForm({super.key, required this.model, required this.pin});
  final AccountSettingsViewModel model;
  final bool pin;
  @override
  State<CredentialForm> createState() => _CredentialFormState();
}

class _CredentialFormState extends State<CredentialForm> {
  final form = GlobalKey<FormState>();
  final old = TextEditingController(),
      next = TextEditingController(),
      confirmation = TextEditingController();
  bool reveal = false;
  @override
  void dispose() {
    old.clear();
    next.clear();
    confirmation.clear();
    old.dispose();
    next.dispose();
    confirmation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final m = widget.model;
    final pin = widget.pin;
    final allowed = pin || m.profile!.canChangePassword;
    final hasOld = !pin || m.profile!.hasPIN;
    Widget field(
      String label,
      TextEditingController c, {
      bool isOld = false,
      bool confirm = false,
    }) => TextFormField(
      controller: c,
      enabled: !m.busy,
      obscureText: !reveal,
      autocorrect: false,
      enableSuggestions: false,
      keyboardType: pin ? TextInputType.number : TextInputType.visiblePassword,
      inputFormatters: pin
          ? [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(6),
            ]
          : null,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xffd6d6d6)),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      validator: (v) {
        if ((v ?? '').isEmpty) return 'Wajib diisi';
        if (confirm && v != next.text) return 'Konfirmasi tidak sama';
        if (pin && !RegExp(r'^[0-9]{6}$').hasMatch(v!)) {
          return 'PIN harus enam digit';
        }
        if (!pin &&
            !isOld &&
            (utf8.encode(v!).length < 8 || utf8.encode(v).length > 72)) {
          return 'Password harus 8–72 byte';
        }
        return null;
      },
    );
    final fields = [
      if (hasOld) field(pin ? 'PIN Lama' : 'Password Lama', old, isOld: true),
      field(pin ? 'PIN Baru' : 'Password Baru', next),
      field(
        pin ? 'Konfirmasi PIN Baru' : 'Konfirmasi Password Baru',
        confirmation,
        confirm: true,
      ),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: 73,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          decoration: const BoxDecoration(
            color: Color(0xff529dc8),
            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
          ),
          child: Text(
            pin ? 'PIN Akun' : 'Password Akun',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 21,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(28),
          color: const Color(0xfff8f8f8),
          child: !allowed
              ? const Text(
                  'Perubahan password dikelola oleh penyedia autentikasi dan belum tersedia di aplikasi ini.',
                )
              : Form(
                  key: form,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      LayoutBuilder(
                        builder: (c, s) => s.maxWidth >= 900
                            ? Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for (var i = 0; i < fields.length; i++)
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          right: i == fields.length - 1
                                              ? 0
                                              : 24,
                                        ),
                                        child: fields[i],
                                      ),
                                    ),
                                ],
                              )
                            : Column(
                                children: [
                                  for (final f in fields)
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 16,
                                      ),
                                      child: f,
                                    ),
                                ],
                              ),
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: reveal,
                            onChanged: m.busy
                                ? null
                                : (v) => setState(() => reveal = v!),
                          ),
                          const Flexible(child: Text('Tampilkan kredensial')),
                        ],
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: FilledButton(
                          style: FilledButton.styleFrom(
                            backgroundColor: const Color(0xffff8227),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 38,
                              vertical: 22,
                            ),
                          ),
                          onPressed: m.busy
                              ? null
                              : () async {
                                  if (!form.currentState!.validate()) return;
                                  await m.credential(
                                    pin,
                                    old.text,
                                    next.text,
                                    confirmation.text,
                                  );
                                  if (!mounted) return;
                                  old.clear();
                                  next.clear();
                                  confirmation.clear();
                                  if (mounted) setState(() => reveal = false);
                                },
                          child: Text(
                            pin
                                ? (hasOld ? 'Ubah PIN' : 'Buat PIN')
                                : 'Ubah Password',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ],
    );
  }
}
