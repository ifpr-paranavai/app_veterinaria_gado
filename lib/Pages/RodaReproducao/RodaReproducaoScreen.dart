import 'dart:math';
import 'package:flutter/material.dart';

class RodaReproducaoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
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
            // Desenhar os ícones de estrela
            for (var i = 0; i < 20; i++)
              buildIcon(i, 20, Icon(
                Icons.star,
                size: 20,
                color: getColor(i),
              )),
            // Desenhar os ícones de animais
            for (var i = 0; i < 5; i++)
              buildIcon(i, 5, CircleAvatar(
                radius: 15,
                backgroundColor: Colors.white,
                child: Text(
                  getAnimalEmoji(i),
                  style: TextStyle(fontSize: 18),
                ),
              )),
          ],
        ),
      ),
    );
  }

  // Constrói um ícone em uma posição específica do círculo
  Widget buildIcon(int index, int total, Widget child, {double offsetAngle = 0}) {
  final double angle = (2 * pi / total) * index + offsetAngle;
  final double xOffset = cos(angle - pi / 2) * 130;
  final double yOffset = sin(angle - pi / 2) * 130;

  return Positioned(
    left: 150 + xOffset - 10, // Subtrair metade da largura do ícone
    top: 150 + yOffset - 10, // Subtrair metade da altura do ícone
    child: child,
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

  // Função para determinar o emoji do animal com base no índice
  String getAnimalEmoji(int index) {
    switch (index) {
      case 0:
        return '🐶';
      case 1:
        return '🐱';
      case 2:
        return '🐰';
      case 3:
        return '🦁';
      case 4:
        return '🐼';
      default:
        return '';
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

    canvas.drawCircle(center, radius, circlePaint);

    for (var i = 0; i < 20; i++) {
      final double x = center.dx + radius * cos(i * 2 * pi / 20);
      final double y = center.dy + radius * sin(i * 2 * pi / 20);
      canvas.drawLine(center, Offset(x, y), linePaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
