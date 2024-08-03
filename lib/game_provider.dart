import 'package:flutter/widgets.dart';
import 'package:flutter_hackathon/mechanics/gameplay.dart';
import 'package:flutter_hackathon/models/board.model.dart';
import 'package:flutter_hackathon/models/game.model.dart';
import 'package:flutter_hackathon/models/helper/coordinates.model.dart';
import 'package:flutter_hackathon/models/helper/shiptype.model.dart';

enum GlobalGameState { start, choosing, playing }

enum GameStateTurn { playerA, playerB, transition }

class GameController extends ChangeNotifier {
  GameController(this.game);

  final Game game;

  GameStateTurn turn = GameStateTurn.playerA;
  GlobalGameState state = GlobalGameState.start;
  PowerShots? selectedShot;

  static const boardGridSize = 10;

  final durationBetweenTurns = const Duration(seconds: 1);

  void nextTurn() {
    turn = GameStateTurn.transition;
    selectedShot = null;
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

  void selectShot(PowerShots? shot) {
    selectedShot = shot;
    notifyListeners();
  }

  void shootShot(PowerShots? shot, Coordinates coordinates) {
    // final board = currentBoard!;

    notifyListeners();
  }

  void onCoordinatesClicked(Coordinates coordinates) {
    final board = currentBoard!;

    notifyListeners();
  }

  Board? get currentBoard {
    return switch (turn) {
      GameStateTurn.playerA => game.playerA,
      GameStateTurn.playerB => game.playerB,
      GameStateTurn.transition => null,
    };
  }
}
