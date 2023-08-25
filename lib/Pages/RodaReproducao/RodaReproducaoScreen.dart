import 'dart:math';
import 'package:flutter/material.dart';

class RodaReproducaoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
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
                  ), distance: 70),
              ],
            ),
          ),
          SizedBox(height: 20),
          Column(
            children: List.generate(
              5,
              (index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(
                  getAnimalName(index),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Constrói um ícone em uma posição específica do círculo
  Widget buildIcon(int index, int total, Widget child, {double offsetAngle = 0, double distance = 130}) {
    final double angle = (2 * pi / total) * index + offsetAngle;
    final double xOffset = cos(angle - pi / 2) * distance;
    final double yOffset = sin(angle - pi / 2) * distance;

    return Positioned(
      left: 150 + xOffset - 10,
      top: 150 + yOffset - 10,
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

  // Função para determinar o nome do animal com base no índice
  String getAnimalName(int index) {
    switch (index) {
      case 0:
        return 'Cachorro';
      case 1:
        return 'Gato';
      case 2:
        return 'Coelho';
      case 3:
        return 'Leão';
      case 4:
        return 'Panda';
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
