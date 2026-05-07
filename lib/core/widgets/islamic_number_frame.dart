import 'dart:math';
import 'package:flutter/material.dart';
import '../../config/theme/app_colors.dart';

/// Widget untuk menampilkan nomor urut dengan bingkai islami (segi delapan)
class IslamicNumberFrame extends StatelessWidget {
  final int number;
  final double size;
  final Color? color;

  const IslamicNumberFrame({
    super.key,
    required this.number,
    this.size = 36,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final frameColor = color ?? AppColors.primary;

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(size, size),
            painter: _IslamicFramePainter(color: frameColor),
          ),
          Text(
            number.toString(),
            style: TextStyle(
              color: frameColor,
              fontSize: size * 0.35,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }
}

class _IslamicFramePainter extends CustomPainter {
  final Color color;

  _IslamicFramePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    // final fillPaint = Paint()
    //   ..color = color.withOpacity(0.08)
    //   ..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Draw the 8-pointed Islamic star (Rub el Hizb style)
    final path = Path();
    const points = 8;

    // Rotating slightly to make it look better
    const double rotation = pi / 8;

    for (int i = 0; i < points * 2; i++) {
      final isOuter = i % 2 == 0;
      final angle = (i * pi / points) - pi / 2 + rotation;
      final currentRadius = isOuter ? radius : radius * 0.75;

      final x = center.dx + currentRadius * cos(angle);
      final y = center.dy + currentRadius * sin(angle);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();

    // canvas.drawPath(path, fillPaint);
    canvas.drawPath(path, paint);

    // Draw inner circle for focus
    // canvas.drawCircle(center, radius * 0.5, paint..strokeWidth = 0.5);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
