import 'package:flutter/widgets.dart';
import 'package:flutter_hackathon/models/board.model.dart';

enum GlobalGameState { start, choosing, playing }

enum GameStateTurn { playerA, playerB, transition }

class GameController extends ChangeNotifier {
  GameController();

  GameStateTurn turn = GameStateTurn.playerA;
  GlobalGameState state = GlobalGameState.start;

  static const boardGridSize = 10;

  Board playerABoard = Board(
    name: 'Player A',
    gridSize: boardGridSize,
  );

  Board playerBBoard = Board(
    name: 'Player B',
    gridSize: boardGridSize,
  );

  final durationBetweenTurns = const Duration(seconds: 1);

  void nextTurn() {
    turn = GameStateTurn.transition;
    notifyListeners();

    Future.delayed(durationBetweenTurns, () {
      turn = turn == GameStateTurn.playerA
          ? GameStateTurn.playerB
          : GameStateTurn.playerA;
      notifyListeners();
    });
  }

  void startChoosing() {
    state = GlobalGameState.choosing;
    notifyListeners();
  }

  void startPlaying() {
    state = GlobalGameState.playing;
    notifyListeners();
  }

  Board? get currentBoard {
    return switch (turn) {
      GameStateTurn.playerA => playerABoard,
      GameStateTurn.playerB => playerBBoard,
      GameStateTurn.transition => null,
    };
  }
}
