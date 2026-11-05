import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../models.dart';

class AttendanceHero extends StatelessWidget {
  const AttendanceHero({
    super.key,
    required this.entry,
    required this.now,
    required this.choosing,
  });
  final AttendanceEntry? entry;
  final DateTime now;
  final bool choosing;
  @override
  Widget build(BuildContext context) {
    final leaving = entry != null;
    final date = inJakarta(now);
    const weekdays = [
      'Senin',
      'Selasa',
      'Rabu',
      'Kamis',
      'Jumat',
      'Sabtu',
      'Minggu',
    ];
    const months = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            'assets/images/${choosing
                ? 'absen_selamat_datang'
                : leaving
                ? 'absen_pin_pulang'
                : 'absen_pin_masuk'}.png',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0x40000000), Color(0x10000000), Color(0x50000000)],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(44.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                attendanceTime(now),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 54.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                '${weekdays[date.weekday - 1]},\n${date.day} ${months[date.month - 1]} ${date.year}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 23.sp,
                  fontWeight: FontWeight.w600,
                  height: 1.6,
                ),
              ),
              const Spacer(),
              Text(
                leaving ? 'Selamat Istirahat' : 'Selamat Datang Kembali',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 23.sp,
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(height: 28.h),
              Row(
                children: [
                  Expanded(
                    child: _TimeCard(label: 'Jam Masuk', value: entry?.clockIn),
                  ),
                  SizedBox(width: 24.w),
                  Expanded(
                    child: _TimeCard(
                      label: 'Jam Pulang',
                      value: entry?.clockOut,
                    ),
                  ),
                ],
              ),
              if (entry != null)
                Padding(
                  padding: EdgeInsets.only(top: 10.h),
                  child: Text(
                    'Tanggal kerja: ${entry!.workDate} • WIB',
                    style: TextStyle(color: Colors.white, fontSize: 14.sp),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TimeCard extends StatelessWidget {
  const _TimeCard({required this.label, required this.value});
  final String label;
  final DateTime? value;
  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.symmetric(horizontal: 26.w, vertical: 18.h),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: .82),
      borderRadius: BorderRadius.circular(10.r),
      boxShadow: const [
        BoxShadow(
          color: Color(0x30000000),
          blurRadius: 5,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: const Color(0xff666666),
            fontSize: 19.sp,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 10.h),
        FittedBox(
          child: Text(
            attendanceTime(value),
            style: TextStyle(
              color: const Color(0xff666666),
              fontSize: 48.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    ),
  );
}
