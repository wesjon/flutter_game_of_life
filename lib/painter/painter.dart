import 'package:flutter/material.dart';

class GameOfLifePainter extends CustomPainter {
  final double cellSize;

  final Color aliveColor;
  final Color deadColor;

  final List<List<bool>> grid;

  GameOfLifePainter({
    required this.cellSize,
    required this.aliveColor,
    required this.deadColor,
    required this.grid,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.fill;

    for (int i = 0; i < grid.length; i++) {
      for (int j = 0; j < grid[i].length; j++) {
        double offsetX = i * cellSize;
        double offsetY = j * cellSize;

        Rect rect = Rect.fromLTWH(offsetX, offsetY, cellSize, cellSize);

        paint.color = grid[i][j] ? aliveColor : deadColor;

        canvas.drawOval(rect, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
