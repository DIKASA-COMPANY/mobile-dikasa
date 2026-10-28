import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'app_loading_indicator.dart';

class AppRemoteImage extends StatelessWidget {
  const AppRemoteImage({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.fallback,
  });

  final String url;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final Widget? fallback;

  Widget _frame(Widget child) => ClipRRect(
    borderRadius: borderRadius ?? BorderRadius.zero,
    child: SizedBox(width: width, height: height, child: child),
  );

  @override
  Widget build(BuildContext context) {
    if (url.startsWith('data:image/')) {
      final comma = url.indexOf(',');
      Uint8List? bytes;
      if (comma > 0) {
        try {
          bytes = base64Decode(url.substring(comma + 1));
        } on FormatException {
          bytes = null;
        }
      }
      if (bytes == null) {
        return _frame(fallback ?? const Icon(Icons.broken_image));
      }
      return _frame(Image.memory(bytes, fit: fit));
    }
    return _frame(
      Image.network(
        url,
        fit: fit,
        loadingBuilder: (context, child, progress) => progress == null
            ? child
            : const Center(child: AppLoadingIndicator(compact: true)),
        errorBuilder: (context, error, stackTrace) =>
            fallback ?? const Icon(Icons.broken_image_outlined),
      ),
    );
  }
}
