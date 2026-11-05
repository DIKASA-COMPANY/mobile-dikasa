import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_dikasa/components/app_loading_indicator.dart';
import 'models.dart';
import 'report_view_model.dart';

class AttendanceReportView extends StatefulWidget {
  const AttendanceReportView({super.key, required this.viewModel});
  final AttendanceReportViewModel viewModel;
  @override
  State<AttendanceReportView> createState() => _AttendanceReportViewState();
}

class _AttendanceReportViewState extends State<AttendanceReportView> {
  AttendanceReportViewModel get vm => widget.viewModel;
  @override
  void initState() {
    super.initState();
    unawaited(vm.load());
  }

  @override
  void dispose() {
    vm.dispose();
    super.dispose();
  }

  Future<void> _dates() async {
    final range = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      initialDateRange: DateTimeRange(
        start: DateTime.parse(vm.from),
        end: DateTime.parse(vm.to),
      ),
      helpText: 'Pilih rentang laporan (maks. 31 hari)',
    );
    if (range != null && mounted) {
      await vm.load(
        start: range.start.toIso8601String().substring(0, 10),
        end: range.end.toIso8601String().substring(0, 10),
      );
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Laporan Absensi')),
    body: SafeArea(
      child: ListenableBuilder(
        listenable: vm,
        builder: (context, _) => Padding(
          padding: EdgeInsets.all(24.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Wrap(
                spacing: 16.w,
                runSpacing: 12.h,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  OutlinedButton.icon(
                    onPressed: vm.busy ? null : _dates,
                    icon: const Icon(Icons.date_range),
                    label: Text('${vm.from} — ${vm.to}'),
                  ),
                  TextButton.icon(
                    onPressed: vm.busy ? null : vm.load,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Muat ulang'),
                  ),
                  const Text('Waktu Indonesia Barat (WIB)'),
                ],
              ),
              SizedBox(height: 20.h),
              if (vm.busy)
                const Center(
                  child: AppLoadingIndicator(label: 'Memuat laporan…'),
                ),
              if (vm.error != null)
                Text(vm.error!, style: const TextStyle(color: Colors.red)),
              if (!vm.busy && vm.error == null && vm.entries.isEmpty)
                const Expanded(
                  child: Center(
                    child: Text('Belum ada absensi pada rentang ini.'),
                  ),
                ),
              if (!vm.busy && vm.entries.isNotEmpty)
                Expanded(
                  child: SingleChildScrollView(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text('Pegawai')),
                          DataColumn(label: Text('Tanggal')),
                          DataColumn(label: Text('Jam Masuk')),
                          DataColumn(label: Text('Jam Pulang')),
                          DataColumn(label: Text('Metode Masuk')),
                          DataColumn(label: Text('Metode Pulang')),
                        ],
                        rows: vm.entries
                            .map(
                              (e) => DataRow(
                                cells: [
                                  DataCell(Text(e.employeeName)),
                                  DataCell(Text(e.workDate)),
                                  DataCell(Text(attendanceTime(e.clockIn))),
                                  DataCell(Text(attendanceTime(e.clockOut))),
                                  DataCell(
                                    Text(
                                      e.inMethod == 'pin'
                                          ? 'PIN'
                                          : 'Fingerprint',
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      e.outMethod == null
                                          ? '—'
                                          : e.outMethod == 'pin'
                                          ? 'PIN'
                                          : 'Fingerprint',
                                    ),
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                      ),
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
