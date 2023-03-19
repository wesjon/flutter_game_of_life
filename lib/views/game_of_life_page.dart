import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import '../painter/painter.dart';

final random = Random();
const cellSize = 3;

class GameOfLife extends StatefulWidget {
  final int width;
  final int height;

  const GameOfLife({
    super.key,
    required this.width,
    required this.height,
  });

  @override
  GameOfLifeState createState() => GameOfLifeState();
}

class GameOfLifeState extends State<GameOfLife> {
  late List<List<bool>> currentState;
  late Timer? timer;

  @override
  void initState() {
    super.initState();

    final cellsHorizontal = (widget.width / cellSize).round();
    final cellsVertical = (widget.height / cellSize).round();

    currentState = List.generate(cellsHorizontal,
            (index) => List.generate(cellsVertical, (index) => random.nextBool()));
    timer = Timer.periodic(const Duration(milliseconds: 24), (timer) {
      setState(() {
        currentState = updateState(currentState);
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() {
        currentState = updateState(List.generate(currentState.length,
                (i) => List.from(currentState[i]).map((e) => e == false? e == random.nextBool() && e == random.nextBool()&& e == random.nextBool()&& e == random.nextBool()&& e == random.nextBool(): true).toList()));
      }),
      child: SafeArea(
        child: CustomPaint(
          painter: GameOfLifePainter(
            cellSize: cellSize.toDouble(),
            aliveColor: Colors.green,
            deadColor: Colors.grey.withAlpha(100),
            grid: currentState,
          ),
        ),
      ),
    );
  }

  List<List<bool>> updateState(List<List<bool>> oldState) {
    List<List<bool>> newState =
    List.generate(oldState.length, (i) => List.from(oldState[i]));

    for (int i = 0; i < oldState.length; i++) {
      for (int j = 0; j < oldState[i].length; j++) {
        bool isCellAlive = oldState[i][j];
        int aliveNeighbors = 0;

        for (int k = -1; k <= 1; k++) {
          for (int l = -1; l <= 1; l++) {
            if (k == 0 && l == 0) {
              continue;
            }
            if (i + k < 0 || i + k >= oldState.length) {
              continue;
            }
            if (j + l < 0 || j + l >= oldState[i].length) {
              continue;
            }
            if (oldState[i + k][j + l]) {
              aliveNeighbors++;
            }
          }
        }

        if (isCellAlive) {
          newState[i][j] = (aliveNeighbors == 2 || aliveNeighbors == 3);
        } else {
          newState[i][j] = (aliveNeighbors == 3);
        }
      }
    }

    return newState;
  }
}
