import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'design.dart';

class CashActivityTable extends StatelessWidget {
  const CashActivityTable({
    super.key,
    required this.events,
    required this.onDetail,
  });
  final List<Map<String, dynamic>> events;
  final ValueChanged<Map<String, dynamic>> onDetail;
  @override
  Widget build(BuildContext c) => LayoutBuilder(
    builder: (c, s) => SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: s.maxWidth),
        child: DataTable(
          showCheckboxColumn: false,
          headingRowColor: const WidgetStatePropertyAll(cashBlue),
          headingTextStyle: const TextStyle(
            color: Colors.white,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
          dataRowColor: const WidgetStatePropertyAll(Color(0xfff4f4f4)),
          dataRowMinHeight: 70,
          dataRowMaxHeight: 100,
          columnSpacing: 30,
          columns: const [
            DataColumn(label: Text('Nama Transaksi')),
            DataColumn(label: Text('Masuk')),
            DataColumn(label: Text('Keluar')),
            DataColumn(label: Text('Catatan')),
          ],
          rows: [
            for (final e in events)
              DataRow(
                onSelectChanged: (_) => onDetail(e),
                cells: [
                  DataCell(
                    SizedBox(
                      width: 170.w,
                      child: Text(
                        '${e['kind'] == 'reversal' ? 'Koreksi: ' : ''}${e['name']}\n${cashWIB(e['occurred_at'] as String?)}',
                        style: TextStyle(fontSize: 12.sp),
                      ),
                    ),
                  ),
                  DataCell(
                    Text(
                      e['direction'] == 'in'
                          ? movementMoney((e['amount'] as num).toInt())
                          : '—',
                    ),
                  ),
                  DataCell(
                    Text(
                      e['direction'] == 'out'
                          ? movementMoney((e['amount'] as num).toInt())
                          : '—',
                    ),
                  ),
                  DataCell(
                    SizedBox(
                      width: 170.w,
                      child: Text(
                        e['reason'] as String? ?? '',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    ),
  );
}
