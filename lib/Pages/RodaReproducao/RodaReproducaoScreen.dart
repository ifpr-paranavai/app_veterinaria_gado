import 'dart:math';
import 'package:flutter/material.dart';

class RodaReproducaoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 300,
      child: Stack(
        children: [
          // Desenhar o círculo e as linhas
          Positioned.fill(
            child: CustomPaint(
              painter: CircleAndLinesPainter(),
            ),
          ),
          // Desenhar os ícones
          for (var i = 0; i < 20; i++)
            Positioned.fill(
              child: Transform.rotate(
                angle: i * pi / 10,
                child: Transform.translate(
                  offset: Offset(0, -130),
                  child: Icon(
                    Icons.star,
                    size: 20,
                    color: getColor(i),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  // Função para determinar a cor do ícone com base no índice
  Color getColor(int index) {
    if (index < 5) {
      return Colors.green;
    } else if (index < 10) {
      return Colors.red;
    } else if (index < 15) {
      return Colors.yellow;
    } else {
      return Colors.orange;
    }
  }
}

class CircleAndLinesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint circlePaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final Paint linePaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final center = Offset(size.width / 2, size.height / 2);
    final double radius = 150;

    // Desenha o círculo
    canvas.drawCircle(center, radius, circlePaint);

    // Desenha as linhas do centro até a borda do círculo
    for (var i = 0; i < 20; i++) {
      final double x = center.dx + radius * cos(i * pi / 10);
      final double y = center.dy + radius * sin(i * pi / 10);
      canvas.drawLine(center, Offset(x, y), linePaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
