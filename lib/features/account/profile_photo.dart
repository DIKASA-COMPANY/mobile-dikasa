import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';

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
        height: 73,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: const BoxDecoration(
          color: Color(0xff529dc8),
          borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
        ),
        child: const Text(
          'Foto Profil',
          style: TextStyle(
            color: Colors.white,
            fontSize: 21,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      Container(
        padding: const EdgeInsets.all(26),
        color: const Color(0xfff4f4f4),
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xffe6e6e6),
                  border: Border.all(color: const Color(0xffbbbbbb), width: 3),
                  borderRadius: BorderRadius.circular(10),
                ),
                clipBehavior: Clip.antiAlias,
                child: bytes != null
                    ? Image.memory(bytes!, fit: BoxFit.cover)
                    : url != null && url!.startsWith('data:image/')
                    ? Image.memory(
                        base64Decode(url!.split(',').last),
                        fit: BoxFit.cover,
                      )
                    : url != null
                    ? Image.network(
                        url!,
                        fit: BoxFit.cover,
                        errorBuilder: (_, e, s) =>
                            const Icon(Icons.person_outline, size: 90),
                      )
                    : const Icon(Icons.person_outline, size: 90),
              ),
            ),
            if (editing) ...[
              const SizedBox(height: 24),
              OutlinedButton(
                onPressed: onUpload,
                child: const Text('Upload Foto'),
              ),
              TextButton(onPressed: onRemove, child: const Text('Hapus Foto')),
              const Text(
                'PNG/JPEG • Maksimal 3 MiB',
                style: TextStyle(fontSize: 12),
              ),
            ],
          ],
        ),
      ),
    ],
  );
}
