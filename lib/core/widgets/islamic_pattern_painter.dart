import 'dart:math';
import 'package:flutter/material.dart';

/// Custom painter untuk menggambar pattern Islamic geometris
/// Digunakan sebagai background dekoratif di hero banner dan header
class IslamicPatternPainter extends CustomPainter {
  final Color color;
  final double opacity;

  IslamicPatternPainter({
    this.color = Colors.white,
    this.opacity = 0.08,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(opacity)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    final fillPaint = Paint()
      ..color = color.withOpacity(opacity * 0.4)
      ..style = PaintingStyle.fill;

    final spacing = 60.0;

    // Gambar pattern grid geometris Islamic
    for (double x = -spacing; x < size.width + spacing; x += spacing) {
      for (double y = -spacing; y < size.height + spacing; y += spacing) {
        _drawIslamicStar(canvas, Offset(x, y), spacing * 0.35, paint);
        _drawOctagon(canvas, Offset(x + spacing / 2, y + spacing / 2),
            spacing * 0.2, paint, fillPaint);
      }
    }

    // Gambar border dekoratif di atas dan bawah
    _drawDecorativeBorder(canvas, size, paint);
  }

  /// Menggambar bintang segi-8 (khas Islamic geometry)
  void _drawIslamicStar(
      Canvas canvas, Offset center, double radius, Paint paint) {
    final path = Path();
    const points = 8;

    for (int i = 0; i < points; i++) {
      final outerAngle = (i * 2 * pi / points) - pi / 2;
      final innerAngle = ((i + 0.5) * 2 * pi / points) - pi / 2;

      final outerX = center.dx + radius * cos(outerAngle);
      final outerY = center.dy + radius * sin(outerAngle);
      final innerX = center.dx + (radius * 0.45) * cos(innerAngle);
      final innerY = center.dy + (radius * 0.45) * sin(innerAngle);

      if (i == 0) {
        path.moveTo(outerX, outerY);
      } else {
        path.lineTo(outerX, outerY);
      }
      path.lineTo(innerX, innerY);
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  /// Menggambar bentuk octagon kecil
  void _drawOctagon(Canvas canvas, Offset center, double radius, Paint paint,
      Paint fillPaint) {
    final path = Path();
    const sides = 8;

    for (int i = 0; i < sides; i++) {
      final angle = (i * 2 * pi / sides) - pi / 8;
      final x = center.dx + radius * cos(angle);
      final y = center.dy + radius * sin(angle);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    canvas.drawPath(path, fillPaint);
    canvas.drawPath(path, paint);
  }

  /// Garis dekoratif di bagian bawah
  void _drawDecorativeBorder(Canvas canvas, Size size, Paint paint) {
    final borderPaint = Paint()
      ..color = color.withOpacity(opacity * 1.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;

    // Lengkungan dekoratif di bottom
    final bottomY = size.height - 20;
    final path = Path();
    const arcWidth = 40.0;

    for (double x = 0; x < size.width; x += arcWidth) {
      path.moveTo(x, bottomY);
      path.quadraticBezierTo(
        x + arcWidth / 2,
        bottomY - 12,
        x + arcWidth,
        bottomY,
      );
    }
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Widget wrapper untuk Islamic pattern background
class IslamicPatternBackground extends StatelessWidget {
  final Widget child;
  final Color patternColor;
  final double patternOpacity;

  const IslamicPatternBackground({
    super.key,
    required this.child,
    this.patternColor = Colors.white,
    this.patternOpacity = 0.08,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: IslamicPatternPainter(
        color: patternColor,
        opacity: patternOpacity,
      ),
      child: child,
    );
  }
}
