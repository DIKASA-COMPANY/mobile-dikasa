import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_dikasa/components/app_loading_indicator.dart';
import 'package:mobile_dikasa/data/models/user.dart';
import 'package:mobile_dikasa/features/new_order/widgets/order_top_bar.dart';
import 'models.dart';
import 'view_model.dart';
import 'report_view.dart';
import 'report_view_model.dart';
import 'widgets/attendance_hero.dart';
import 'widgets/pin_keypad.dart';

class AttendanceView extends StatefulWidget {
  const AttendanceView({
    super.key,
    required this.viewModel,
    required this.createReportViewModel,
    this.user,
    this.onLock,
  });
  final AttendanceViewModel viewModel;
  final AttendanceReportViewModel Function() createReportViewModel;
  final User? user;
  final VoidCallback? onLock;
  @override
  State<AttendanceView> createState() => _AttendanceViewState();
}

class _AttendanceViewState extends State<AttendanceView> {
  Timer? _clock;
  AttendanceViewModel get vm => widget.viewModel;
  @override
  void initState() {
    super.initState();
    unawaited(vm.load());
    _clock = Timer.periodic(const Duration(seconds: 30), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _clock?.cancel();
    vm.dispose();
    super.dispose();
  }

  Future<void> _report() async {
    await Navigator.push<void>(
      context,
      MaterialPageRoute(
        builder: (_) =>
            AttendanceReportView(viewModel: widget.createReportViewModel()),
      ),
    );
    if (mounted) unawaited(vm.refresh());
  }

  @override
  Widget build(BuildContext context) => ListenableBuilder(
    listenable: vm,
    builder: (context, _) => PopScope(
      canPop: !vm.busy,
      child: Scaffold(
        appBar: OrderTopBar(
          user: widget.user,
          sectionLabel: 'Absensi',
          onMenuPressed: vm.busy ? () {} : () => Navigator.pop(context),
          onLockPressed: vm.busy
              ? () {}
              : widget.onLock ?? () => Navigator.pop(context),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                color: const Color(0xff367a9d),
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                child: Row(
                  children: [
                    IconButton(
                      tooltip: 'Kembali',
                      onPressed: vm.busy
                          ? null
                          : () {
                              if (vm.method != null) {
                                vm.chooseMethod(null);
                              } else {
                                Navigator.pop(context);
                              }
                            },
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 28.r,
                      ),
                    ),
                    SizedBox(width: 22.w),
                    Expanded(
                      child: Text(
                        'Absensi Pegawai',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: vm.busy ? null : _report,
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xff666666),
                      ),
                      child: const Text('Laporan Absensi'),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, size) {
                    final hero = AttendanceHero(
                      entry: vm.entry,
                      now: vm.serverTime,
                      choosing: vm.method == null,
                    );
                    if (size.maxWidth < 700) {
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 330.h.clamp(240, 400).toDouble(),
                              child: hero,
                            ),
                            _panel(),
                          ],
                        ),
                      );
                    }
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(flex: 2, child: hero),
                        SizedBox(
                          width: 440.w.clamp(320, 480).toDouble(),
                          child: _panel(),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );

  Widget _panel() => SingleChildScrollView(
    padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 26.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Silakan Pilih Staff',
          style: TextStyle(
            color: Colors.grey,
            fontStyle: FontStyle.italic,
            fontSize: 18.sp,
          ),
        ),
        SizedBox(height: 14.h),
        DropdownButtonFormField<String>(
          key: ValueKey(vm.selected?.id),
          initialValue: vm.selected?.id,
          isExpanded: true,
          hint: const Text('Pilih Staff'),
          decoration: const InputDecoration(border: OutlineInputBorder()),
          items: vm.staff
              .map(
                (s) => DropdownMenuItem(
                  value: s.id,
                  child: Text(s.name, overflow: TextOverflow.ellipsis),
                ),
              )
              .toList(),
          onChanged: vm.busy
              ? null
              : (id) {
                  if (id != null) {
                    unawaited(
                      vm.select(vm.staff.firstWhere((s) => s.id == id)),
                    );
                  }
                },
        ),
        SizedBox(height: 12.h),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton.icon(
            onPressed: vm.busy ? null : vm.load,
            icon: Icon(Icons.refresh, size: 20.r),
            label: const Text('Muat ulang'),
          ),
        ),
        if (vm.staff.isEmpty && !vm.busy)
          const Text('Belum ada pegawai aktif di outlet ini.'),
        if (vm.selected != null && !vm.selected!.hasPin)
          const Text(
            'PIN belum diatur. Masuk ke akun pegawai lalu atur PIN di Pengaturan Akun.',
            style: TextStyle(color: Colors.deepOrange),
          ),
        if (vm.method == null) ...[
          SizedBox(height: 24.h),
          Text(
            'Silakan Pilih Cara Absensi',
            style: TextStyle(
              color: Colors.grey,
              fontStyle: FontStyle.italic,
              fontSize: 18.sp,
            ),
          ),
          SizedBox(height: 20.h),
          OutlinedButton(
            onPressed:
                vm.busy || !vm.statusReady || !(vm.selected?.hasPin ?? false)
                ? null
                : () => vm.chooseMethod(AttendanceMethod.pin),
            child: const Text('PIN'),
          ),
          SizedBox(height: 14.h),
          OutlinedButton(
            onPressed: vm.busy || !vm.statusReady || !vm.canFingerprint
                ? null
                : () => vm.chooseMethod(AttendanceMethod.fingerprint),
            child: const Text('Finger Print'),
          ),
          SizedBox(height: 12.h),
          Text(
            !vm.isSelf && vm.selected != null
                ? 'Fingerprint hanya untuk akun pegawai yang sedang login. Gunakan PIN untuk pegawai lain.'
                : !vm.fingerprintAvailable
                ? 'Sensor fingerprint belum tersedia. Silakan gunakan PIN.'
                : 'Fingerprint memakai sensor yang terdaftar pada perangkat pribadi Anda.',
            style: TextStyle(fontSize: 15.sp, color: Colors.grey),
          ),
        ] else ...[
          SizedBox(height: 18.h),
          if (vm.method == AttendanceMethod.pin ||
              !(vm.selected?.fingerprintEnrolled ?? false)) ...[
            Text(
              vm.method == AttendanceMethod.pin
                  ? 'Silakan Masukkan PIN Absensi'
                  : 'Masukkan PIN akun untuk daftar fingerprint',
              style: TextStyle(
                fontSize: 17.sp,
                fontStyle: FontStyle.italic,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 20.h),
            AttendancePinKeypad(
              length: vm.pin.length,
              enabled: !vm.busy && !vm.uncertain,
              onDigit: vm.digit,
              onClear: vm.clear,
              onBackspace: vm.backspace,
            ),
          ],
          if (vm.method == AttendanceMethod.fingerprint) ...[
            if (vm.selected?.fingerprintEnrolled ?? false) ...[
              Text(
                'Letakkan jari pada sensor fingerprint di perangkat Anda untuk melakukan absensi.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17.sp,
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(height: 30.h),
              Image.asset(
                'assets/images/fingerprint_scan.png',
                height: 220.h,
                semanticLabel: 'Pindai sidik jari dengan sensor perangkat',
              ),
              SizedBox(height: 16.h),
              TextButton(
                onPressed: vm.busy
                    ? null
                    : () {
                        vm.chooseMethod(AttendanceMethod.pin);
                      },
                child: const Text('Gunakan PIN'),
              ),
            ] else
              FilledButton(
                onPressed: vm.busy || vm.pin.length != 6
                    ? null
                    : vm.enrollFingerprint,
                child: const Text('Daftarkan Fingerprint'),
              ),
          ],
          if (vm.method == AttendanceMethod.pin ||
              (vm.selected?.fingerprintEnrolled ?? false)) ...[
            SizedBox(height: 20.h),
            Row(
              children: [
                Expanded(
                  child: _punch(
                    'Masuk',
                    AttendanceAction.clockIn,
                    vm.canClockIn,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: _punch(
                    'Pulang',
                    AttendanceAction.clockOut,
                    vm.canClockOut,
                  ),
                ),
              ],
            ),
            if (!vm.canClockIn && !vm.canClockOut && vm.statusReady && !vm.busy)
              Padding(
                padding: EdgeInsets.only(top: 12.h),
                child: const Text('Absensi hari ini sudah selesai.'),
              ),
          ],
        ],
        if (vm.busy)
          Padding(
            padding: EdgeInsets.only(top: 20.h),
            child: AppLoadingIndicator(
              label: vm.method == AttendanceMethod.fingerprint
                  ? 'Memproses fingerprint…'
                  : 'Memproses absensi…',
            ),
          ),
        if (vm.error != null)
          Padding(
            padding: EdgeInsets.only(top: 16.h),
            child: Semantics(
              liveRegion: true,
              child: Text(
                vm.error!,
                style: TextStyle(color: Colors.red.shade700, fontSize: 16.sp),
              ),
            ),
          ),
        if (vm.success != null)
          Padding(
            padding: EdgeInsets.only(top: 16.h),
            child: Semantics(
              liveRegion: true,
              child: Text(
                vm.success!,
                style: TextStyle(color: Colors.green.shade700, fontSize: 16.sp),
              ),
            ),
          ),
        SizedBox(height: 32.h),
        FilledButton(
          onPressed: vm.busy ? null : () => Navigator.pop(context),
          child: const Text('Kembali ke Dashboard'),
        ),
      ],
    ),
  );
  Widget _punch(String label, AttendanceAction action, bool enabled) =>
      FilledButton(
        onPressed:
            enabled && (vm.method != AttendanceMethod.pin || vm.pin.length == 6)
            ? () => vm.submit(action)
            : null,
        style: FilledButton.styleFrom(
          backgroundColor: const Color(0xffff8227),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
        child: Text(label),
      );
}
