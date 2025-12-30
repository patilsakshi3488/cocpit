import 'package:flutter/material.dart';

class RadarChartPainter extends CustomPainter {
  final Color primary;
  final Color textColor;
  RadarChartPainter({required this.primary, required this.textColor});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final paintGrid = Paint()
      ..color = textColor.withValues(alpha: 0.05)
      ..style = PaintingStyle.stroke;
    
    for (var i = 1; i <= 5; i++) {
      canvas.drawCircle(center, radius * (i / 5), paintGrid);
    }

    final paintFill = Paint()..color = primary.withValues(alpha: 0.2)..style = PaintingStyle.fill;
    final paintBorder = Paint()..color = primary..style = PaintingStyle.stroke..strokeWidth = 2;

    final path = Path();
    path.moveTo(center.dx, center.dy - radius * 0.8);
    path.lineTo(center.dx + radius * 0.7, center.dy - radius * 0.3);
    path.lineTo(center.dx + radius * 0.6, center.dy + radius * 0.5);
    path.lineTo(center.dx, center.dy + radius * 0.9);
    path.lineTo(center.dx - radius * 0.7, center.dy + radius * 0.4);
    path.lineTo(center.dx - radius * 0.6, center.dy - radius * 0.4);
    path.close();

    canvas.drawPath(path, paintFill);
    canvas.drawPath(path, paintBorder);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class LineChartPainter extends CustomPainter {
  final Color primary;
  final Color accent;
  final Color textColor;
  LineChartPainter({required this.primary, required this.accent, required this.textColor});

  @override
  void paint(Canvas canvas, Size size) {
    final paintGrid = Paint()..color = textColor.withValues(alpha: 0.1)..style = PaintingStyle.stroke;
    for (var i = 0; i < 5; i++) {
      double y = size.height - (size.height / 4 * i);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paintGrid);
    }

    final p1 = Path();
    p1.moveTo(0, size.height * 0.6);
    p1.quadraticBezierTo(size.width * 0.2, size.height * 0.7, size.width * 0.4, size.height * 0.4);
    p1.quadraticBezierTo(size.width * 0.6, size.height * 0.2, size.width * 0.8, size.height * 0.5);
    p1.lineTo(size.width, size.height * 0.3);

    final paint1 = Paint()..color = primary..style = PaintingStyle.stroke..strokeWidth = 3;
    canvas.drawPath(p1, paint1);

    final p2 = Path();
    p2.moveTo(0, size.height * 0.9);
    p2.lineTo(size.width * 0.3, size.height * 0.85);
    p2.lineTo(size.width * 0.6, size.height * 0.88);
    p2.lineTo(size.width, size.height * 0.8);

    final paint2 = Paint()..color = accent..style = PaintingStyle.stroke..strokeWidth = 3;
    canvas.drawPath(p2, paint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class DonutChartPainter extends CustomPainter {
  final Color primary;
  final Color textColor;
  DonutChartPainter({required this.primary, required this.textColor});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final paint = Paint()..style = PaintingStyle.stroke..strokeWidth = 12;

    paint.color = primary;
    canvas.drawArc(rect, -1.5, 2.5, false, paint);
    paint.color = Colors.tealAccent;
    canvas.drawArc(rect, 1.1, 1.8, false, paint);
    paint.color = Colors.orangeAccent;
    canvas.drawArc(rect, 3.0, 0.8, false, paint);
    paint.color = Colors.redAccent;
    canvas.drawArc(rect, 3.9, 0.6, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
