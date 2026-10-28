import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_dikasa/components/app_loading_indicator.dart';
import 'view_model.dart';
import 'credential_forms.dart';
import 'profile_photo.dart';
import 'design.dart';

class AccountSettingsView extends StatefulWidget {
  const AccountSettingsView({super.key, required this.viewModel, this.onLock});
  final AccountSettingsViewModel viewModel;
  final VoidCallback? onLock;
  @override
  State<AccountSettingsView> createState() => _AccountSettingsViewState();
}

class _AccountSettingsViewState extends State<AccountSettingsView> {
  late final AccountSettingsViewModel m;
  final form = GlobalKey<FormState>();
  final fields = <String, TextEditingController>{
    for (final k in [
      'first_name',
      'last_name',
      'phone_number',
      'email',
      'date_of_birth',
      'personal_address',
    ])
      k: TextEditingController(),
  };
  String gender = '';
  bool editing = false, dirty = false, removePhoto = false;
  Uint8List? photo;
  String? filename;
  @override
  void initState() {
    super.initState();
    m = widget.viewModel;
    m.addListener(changed);
    m.load();
  }

  String? lastNotice;
  void changed() {
    if (!mounted) return;
    setState(() {});
    final notice = m.message;
    if (notice != null && notice != lastNotice) {
      lastNotice = notice;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(notice)));
        }
      });
    }
  }

  @override
  void dispose() {
    m.removeListener(changed);
    m.dispose();
    for (final c in fields.values) {
      c.dispose();
    }
    super.dispose();
  }

  void begin() {
    final p = m.profile!;
    for (final e in fields.entries) {
      e.value.text = p.fields[e.key] ?? '';
    }
    gender = p.genderId;
    setState(() {
      editing = true;
      dirty = false;
      photo = null;
      removePhoto = false;
    });
  }

  Future<bool> discard() async {
    if (m.busy) return false;
    if (!editing || !dirty) return true;
    return await showDialog<bool>(
          context: context,
          builder: (c) => AlertDialog(
            title: const Text('Buang perubahan profil?'),
            content: const Text('Perubahan yang belum disimpan akan dibuang.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(c, false),
                child: const Text('Lanjut Edit'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(c, true),
                child: const Text('Buang Perubahan'),
              ),
            ],
          ),
        ) ??
        false;
  }

  Future<void> back() async {
    if (await discard() && mounted) Navigator.pop(context);
  }

  Future<void> upload() async {
    try {
      final f = await m.pickProfileImage();
      if (!mounted || !m.active || f == null) {
        return;
      }
      setState(() {
        photo = f.bytes;
        filename = f.name;
        removePhoto = false;
        dirty = true;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(m.error(e))));
      }
    }
  }

  Widget card(String title, Widget content) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Container(
        height: 73.h,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        decoration: BoxDecoration(
          color: Color(0xff529dc8),
          borderRadius: BorderRadius.vertical(top: Radius.circular(10.r)),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 21.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      Container(
        padding: EdgeInsets.all(32.r),
        decoration: BoxDecoration(
          color: Color(0xfff8f8f8),
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(10.r)),
        ),
        child: content,
      ),
    ],
  );
  Widget textField(String key, String label, {int lines = 1}) => TextFormField(
    controller: fields[key],
    enabled: !m.busy,
    maxLines: lines,
    onChanged: (_) => dirty = true,
    decoration: InputDecoration(
      labelText: label,
      suffixIcon: key == 'date_of_birth'
          ? IconButton(
              tooltip: 'Pilih tanggal lahir',
              icon: const Icon(Icons.date_range),
              onPressed: m.busy
                  ? null
                  : () async {
                      final now = DateTime.now().toUtc().add(
                        const Duration(hours: 7),
                      );
                      final last = DateTime(now.year, now.month, now.day);
                      final current = DateTime.tryParse(fields[key]!.text);
                      final picked = await showDatePicker(
                        context: context,
                        initialDate:
                            current != null &&
                                !current.isAfter(last) &&
                                current.year >= 1900
                            ? current
                            : DateTime(1990),
                        firstDate: DateTime(1900),
                        lastDate: last,
                      );
                      if (picked != null && mounted && m.active) {
                        fields[key]!.text =
                            '${picked.year.toString().padLeft(4, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
                        dirty = true;
                      }
                    },
            )
          : null,
      prefixIcon: Padding(
        padding: EdgeInsets.all(12.r),
        child: AccountIcon(
          key == 'phone_number'
              ? 'phone'
              : key == 'email'
              ? 'email'
              : key == 'date_of_birth'
              ? 'calendar'
              : key == 'personal_address'
              ? 'location'
              : 'profile',
        ),
      ),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: const BorderSide(color: Color(0xffd6d6d6)),
      ),
      filled: true,
      fillColor: Colors.white,
    ),
    validator: (raw) {
      final v = (raw ?? '').trim();
      if (key == 'first_name' && (v.isEmpty || v.runes.length > 100)) {
        return 'Nama depan wajib diisi, maksimal 100 karakter';
      }
      if (key == 'last_name' && v.runes.length > 100) {
        return 'Maksimal 100 karakter';
      }
      if (key == 'phone_number' && (v.length < 8 || v.length > 30)) {
        return 'Nomor HP harus 8–30 karakter';
      }
      if (key == 'email' &&
          v.isNotEmpty &&
          (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(v) ||
              v.length > 254)) {
        return 'Email tidak valid';
      }
      if (key == 'personal_address' && v.runes.length > 1000) {
        return 'Maksimal 1000 karakter';
      }
      if (key == 'date_of_birth' && v.isNotEmpty) {
        final d = DateTime.tryParse(v);
        final today = DateTime.now().toUtc().add(const Duration(hours: 7));
        final dateToday =
            '${today.year.toString().padLeft(4, '0')}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}';
        if (d == null ||
            d.toIso8601String().substring(0, 10) != v ||
            v.compareTo(dateToday) > 0) {
          return 'Tanggal tidak valid (YYYY-MM-DD)';
        }
      }
      return null;
    },
  );
  Widget readonly(String label, String value) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: TextStyle(color: Color(0xff999999), fontSize: 16.sp),
      ),
      SizedBox(height: 8.h),
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(15.r),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xffd6d6d6)),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Text(value.isEmpty ? 'Belum diisi' : value),
      ),
      SizedBox(height: 16.h),
    ],
  );
  Widget profileForm() {
    final p = m.profile!;
    final inputs = editing
        ? <Widget>[
            textField('first_name', 'Nama Depan'),
            textField('last_name', 'Nama Belakang'),
            textField('phone_number', 'No Handphone'),
            textField('email', 'Email'),
            textField('date_of_birth', 'Tanggal Lahir (YYYY-MM-DD)'),
            DropdownButtonFormField<String>(
              initialValue: m.genders.any((g) => g.id == gender) ? gender : '',
              isExpanded: true,
              decoration: InputDecoration(
                labelText: 'Gender',
                prefixIcon: Padding(
                  padding: EdgeInsets.all(12.r),
                  child: SizedBox(
                    width: 22.w,
                    height: 22.h,
                    child: AccountIcon('gender'),
                  ),
                ),
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
              icon: const AccountIcon('down'),
              items: [
                const DropdownMenuItem(value: '', child: Text('Belum diisi')),
                for (final g in m.genders)
                  DropdownMenuItem(value: g.id, child: Text(g.name)),
              ],
              onChanged: m.busy
                  ? null
                  : (v) {
                      gender = v ?? '';
                      dirty = true;
                    },
            ),
            textField('personal_address', 'Alamat Pribadi', lines: 2),
          ]
        : <Widget>[
            readonly('Nama Lengkap', p.user.name),
            readonly('No Handphone', p.phone),
            readonly('Tanggal Lahir', p.birthDate),
            readonly('Alamat Pribadi', p.address),
            readonly('Email', p.email),
            readonly(
              'Gender',
              m.genders
                      .where((g) => g.id == p.genderId)
                      .map((g) => g.name)
                      .firstOrNull ??
                  '',
            ),
          ];
    return Form(
      key: form,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          LayoutBuilder(
            builder: (c, s) {
              final wide = s.maxWidth >= 650;
              return Wrap(
                spacing: 24,
                runSpacing: 20,
                children: [
                  for (final f in inputs)
                    SizedBox(
                      width: wide ? (s.maxWidth - 24) / 2 : s.maxWidth,
                      child: f,
                    ),
                ],
              );
            },
          ),
          SizedBox(height: 24.h),
          Wrap(
            alignment: WrapAlignment.end,
            spacing: 16,
            runSpacing: 12,
            children: [
              if (editing)
                OutlinedButton(
                  onPressed: m.busy
                      ? null
                      : () async {
                          if (await discard() && mounted) {
                            setState(() {
                              editing = false;
                              dirty = false;
                              photo = null;
                            });
                          }
                        },
                  child: const Text('Batal'),
                ),
              FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xffff8227),
                  padding: EdgeInsets.symmetric(
                    horizontal: 36.w,
                    vertical: 22.h,
                  ),
                ),
                onPressed: m.busy
                    ? null
                    : () async {
                        if (!editing) {
                          begin();
                          return;
                        }
                        if (!form.currentState!.validate()) return;
                        final values = {
                          for (final e in fields.entries)
                            e.key: e.value.text.trim(),
                          'gender_id': gender,
                          if (removePhoto) 'remove_avatar': 'true',
                        };
                        final ok = await m.save(
                          values,
                          bytes: photo,
                          filename: filename,
                        );
                        if (ok && mounted) {
                          setState(() {
                            editing = false;
                            dirty = false;
                            photo = null;
                            removePhoto = false;
                          });
                        }
                      },
                child: Text(editing ? 'Simpan Profil' : 'Ubah Profil'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final p = m.profile;
    return PopScope(
      canPop: !m.busy && (!editing || !dirty),
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) back();
      },
      child: Theme(
        data: Theme.of(context).copyWith(
          filledButtonTheme: FilledButtonThemeData(
            style: FilledButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              textStyle: TextStyle(fontFamily: 'Poppins', fontSize: 18.sp),
            ),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xff077cd3),
              side: BorderSide(color: Color(0xff077cd3), width: 2.w),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 18.h),
              textStyle: TextStyle(fontFamily: 'Poppins', fontSize: 18.sp),
            ),
          ),
          textTheme: Theme.of(context).textTheme.apply(fontFamily: 'Poppins'),
        ),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              children: [
                Container(
                  height: 88.h,
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: back,
                        icon: const AccountIcon('menu'),
                      ),
                      SizedBox(width: 16.w),
                      if (MediaQuery.sizeOf(context).width >= 600)
                        Expanded(
                          flex: 3,
                          child: Text(
                            'Akun',
                            style: TextStyle(
                              color: Color(0xff077cd3),
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      IconButton(
                        tooltip: 'Kunci kasir',
                        onPressed: m.busy || widget.onLock == null
                            ? null
                            : () async {
                                if (await discard() && mounted) {
                                  widget.onLock!();
                                }
                              },
                        icon: const AccountIcon('lock'),
                      ),
                      if (p != null)
                        Expanded(
                          flex: 2,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: ConstrainedBox(
                              constraints: BoxConstraints(maxWidth: 220.w),
                              child: Text(
                                '${p.user.outletName}\n${p.user.name}',
                                textAlign: TextAlign.right,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                Container(
                  height: 88.h,
                  color: const Color(0xff367aa0),
                  padding: EdgeInsets.symmetric(horizontal: 32.w),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: back,
                        icon: const AccountIcon('back'),
                      ),
                      SizedBox(width: 32.w),
                      Expanded(
                        child: Text(
                          'Pengaturan Akun',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (m.busy) const AppLinearLoadingIndicator(),
                Expanded(
                  child: !m.active
                      ? const Center(
                          child: Text(
                            'Sesi akun berubah. Silakan kembali dan login ulang.',
                          ),
                        )
                      : p == null
                      ? Center(
                          child: m.busy
                              ? const AppLoadingIndicator()
                              : Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(m.message ?? 'Profil belum dimuat.'),
                                    TextButton(
                                      onPressed: m.load,
                                      child: const Text('Coba Lagi'),
                                    ),
                                  ],
                                ),
                        )
                      : SingleChildScrollView(
                          padding: MediaQuery.sizeOf(context).width < 600
                              ? EdgeInsets.all(16.r)
                              : EdgeInsets.symmetric(
                                  horizontal: 48.w,
                                  vertical: 32.h,
                                ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              if (m.message != null)
                                Container(
                                  padding: EdgeInsets.all(16.r),
                                  margin: EdgeInsets.only(bottom: 20.h),
                                  color: const Color(0xffe9f3fa),
                                  child: Text(
                                    m.message!,
                                    key: const ValueKey('account-message'),
                                  ),
                                ),
                              LayoutBuilder(
                                builder: (c, s) {
                                  final profile = card(
                                    'Informasi Profil',
                                    profileForm(),
                                  );
                                  final avatar = ProfilePhoto(
                                    bytes: photo,
                                    url: removePhoto ? null : p.avatarUrl,
                                    editing: editing && !m.busy,
                                    onUpload: upload,
                                    onRemove: () => setState(() {
                                      photo = null;
                                      removePhoto = true;
                                      dirty = true;
                                    }),
                                  );
                                  return s.maxWidth >= 950
                                      ? Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(child: profile),
                                            SizedBox(width: 28.w),
                                            SizedBox(
                                              width: 304.w,
                                              child: avatar,
                                            ),
                                          ],
                                        )
                                      : Column(
                                          children: [
                                            profile,
                                            SizedBox(height: 24.h),
                                            SizedBox(
                                              width: 304.w,
                                              child: avatar,
                                            ),
                                          ],
                                        );
                                },
                              ),
                              SizedBox(height: 32.h),
                              card(
                                'Informasi Akun',
                                Column(
                                  children: [
                                    readonly('Username', p.user.username),
                                    readonly('Hak Akses Otoritas', p.user.role),
                                    readonly(
                                      'Hak Akses Outlet',
                                      p.user.outletName,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 32.h),
                              CredentialForm(
                                key: ValueKey('pin-${p.hasPIN}'),
                                model: m,
                                pin: true,
                              ),
                              SizedBox(height: 32.h),
                              CredentialForm(model: m, pin: false),
                              SizedBox(height: 32.h),
                              const Center(
                                child: Text(
                                  'Powered By Dikasa',
                                  style: TextStyle(
                                    color: Color(0xffb5b5b5),
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
