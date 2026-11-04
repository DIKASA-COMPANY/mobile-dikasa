import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_dikasa/components/app_remote_image.dart';

class ProfilePhoto extends StatelessWidget {
  const ProfilePhoto({
    super.key,
    this.bytes,
    this.url,
    required this.editing,
    required this.onUpload,
    required this.onRemove,
  });
  final Uint8List? bytes;
  final String? url;
  final bool editing;
  final VoidCallback onUpload, onRemove;
  @override
  Widget build(BuildContext c) => Column(
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
          'Foto Profil',
          style: TextStyle(
            color: Colors.white,
            fontSize: 21.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      Container(
        padding: EdgeInsets.all(26.r),
        color: const Color(0xfff4f4f4),
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xffe6e6e6),
                  border: Border.all(
                    color: const Color(0xffbbbbbb),
                    width: 3.w,
                  ),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                clipBehavior: Clip.antiAlias,
                child: bytes != null
                    ? Image.memory(bytes!, fit: BoxFit.cover)
                    : url != null
                    ? AppRemoteImage(
                        url: url!,
                        fit: BoxFit.cover,
                        fallback: Icon(Icons.person_outline, size: 90.r),
                      )
                    : Icon(Icons.person_outline, size: 90.r),
              ),
            ),
            if (editing) ...[
              SizedBox(height: 24.h),
              OutlinedButton(
                onPressed: onUpload,
                child: const Text('Upload Foto'),
              ),
              TextButton(onPressed: onRemove, child: const Text('Hapus Foto')),
              Text(
                'PNG/JPEG • Maksimal 3 MiB',
                style: TextStyle(fontSize: 12.sp),
              ),
            ],
          ],
        ),
      ),
    ],
  );
}
