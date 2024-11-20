import 'package:flutter/material.dart';

extension HexColor on String {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
 Color toColor() {
    final buffer = StringBuffer();
    if (length == 6 || length == 7) buffer.write('ff');
    buffer.write(replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

class AppColors {
  static const baseShimmer = Color(0xFFE0E0E0);
  static const highlightShimmer = Color(0xFFF5F5F5);

  // static final Color color = HexColor.fromHex('#aabbcc');
}