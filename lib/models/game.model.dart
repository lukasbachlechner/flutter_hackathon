import 'package:flutter_hackathon/models/board.model.dart';

const int gridSize = 10;

class Game {
  final Board playerA = Board(name: 'Player A', gridSize: gridSize);
  final Board playerB = Board(name: 'Player B', gridSize: gridSize);
  bool gameStarted = false;

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
    gameStarted = true;
  }

  isGameOver() {
    return playerA.isAllShipSunk() || playerB.isAllShipSunk();
  }

  Board getWinner() {
    if (!isGameOver()) {
      throw Exception('Game is not over yet');
    }
    return playerA.isAllShipSunk() ? playerB : playerA;
  }
}
