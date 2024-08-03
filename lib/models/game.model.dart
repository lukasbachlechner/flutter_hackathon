import 'package:flutter_hackathon/models/board.model.dart';

const int gridSize = 100;

class Game {
  final Board playerA = Board(name: 'Player A', gridSize: gridSize);
  final Board playerB = Board(name: 'Player B', gridSize: gridSize);

  bool isGameReadyToStart() {
    return playerA.isBoardReady() && playerB.isBoardReady();
  }

  Board whoPlaysNext() {
    return playerA.numberOfTurnsFinished > playerB.numberOfTurnsFinished
        ? playerB
        : playerA;
  }

  void startGame() {
    if (!isGameReadyToStart()) {
      throw Exception('Game is not ready to start');
    }
  }
}
