// custom paint widget
import 'package:dui/models/node.dart';
import 'package:flutter/material.dart';

class SunburstChart extends StatelessWidget {
  const SunburstChart({
    Key? key,
    required this.items,
    required this.animation,
  }) : super(key: key);

  final List<Item> items;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: SunburstPainter(data: items, intialAngle: animation.value),
    );
  }
}

class SunburstPainter extends CustomPainter {
  final List<Item> data;
  final double intialAngle;
  SunburstPainter({required this.intialAngle, required this.data});

  int level = -1;
  final double strokeWidth = 25;
  final double miniStrokeWidth = 10;

  double get radius {
    if (level >= 3) {
      return (strokeWidth * 2) + ((level - 2) * 11) + 10;
    }
    return (strokeWidth + 1) * level;
  }

  @override
  void paint(Canvas canvas, Size size) {
    void dd({
      required List<Item> items,
      required double maxSweepAngle,
      required double startAngle,
    }) {
      level++;
      double startAng = startAngle;

      items.forEach((item) {
        Paint p = Paint()
          ..color = item.color
          ..strokeWidth = level >= 3 ? miniStrokeWidth : strokeWidth
          ..style = PaintingStyle.stroke;
        double sweepAng = item.size * maxSweepAngle;
        drawArc(sweepAng - 0.01, canvas, size, startAng, maxSweepAngle, p,
            60.0 + (level > 0 ? radius : 0));
        dd(items: item.children, maxSweepAngle: sweepAng, startAngle: startAng);
        startAng += sweepAng;
      });
      level--;
    }

    dd(items: data, startAngle: 0, maxSweepAngle: intialAngle);
  }

  void drawArc(double sweepAngle, Canvas canvas, Size size, double startAngle,
      double maxSweepAngle, Paint p,
      [double radius = 100]) {
    canvas.drawArc(
        Rect.fromCircle(
            center: Offset(size.width / 2, size.height / 2), radius: radius),
        startAngle,
        sweepAngle,
        false,
        p);
  }

  @override
  bool shouldRepaint(SunburstPainter oldDelegate) => true;
}
