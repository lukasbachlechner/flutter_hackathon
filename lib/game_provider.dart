import 'package:flutter/widgets.dart';
import 'package:flutter_hackathon/mechanics/gameplay.dart';
import 'package:flutter_hackathon/models/board.model.dart';
import 'package:flutter_hackathon/models/game.model.dart';
import 'package:flutter_hackathon/models/helper/coordinates.model.dart';
import 'package:flutter_hackathon/models/helper/shiptype.model.dart';
import 'package:flutter_hackathon/models/ship.model.dart';

enum GlobalGameState { start, choosing, attacking, pressToPlay, end }

enum GameStateTurn { playerA, playerB, transition }

class GameController extends ChangeNotifier {
  GameController(this.game);

  final Game game;

  GameStateTurn turn = GameStateTurn.playerA;
  GlobalGameState state = GlobalGameState.start;
  ShipType? selectedShipType;
  PowerShots? selectedShot;
  GamePlay? gamePlay;

  static const boardGridSize = 10;

  final durationBetweenTurns = const Duration(seconds: 1);

  void nextTurn() {
    selectedShot = null;
    turn = turn == GameStateTurn.playerA
        ? GameStateTurn.playerB
        : GameStateTurn.playerA;

    gamePlay?.nextTurn();

    state = GlobalGameState.pressToPlay;

    notifyListeners();
  }

  void continueGame() {
    state = GlobalGameState.attacking;
    notifyListeners();
  }

  void startChoosing() {
    state = GlobalGameState.choosing;

    notifyListeners();
  }

  void startPlaying() {
    state = GlobalGameState.attacking;
    if (!game.isGameReadyToStart()) {
      throw Exception('Game is not ready to start');
    }
    game.startGame();
    gamePlay = GamePlay(game: game);
    state = GlobalGameState.attacking;

    notifyListeners();
  }

  void selectShot(PowerShots? shot) {
    selectedShot = shot;
    notifyListeners();
  }

  void shootShot(PowerShots? shot, Coordinates coordinates) {
    // final board = currentBoard!;
    gamePlay!.hitCell(coordinates, shot, null);

    nextTurn();
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

  void selectShipForPlacing(ShipType shipType) {
    selectedShipType = shipType;
    notifyListeners();
  }

  handleTileTapped(Coordinates coordinates) {
    if (state == GlobalGameState.choosing) {
      currentBoard!.addShip(
        Ship(
          type: selectedShipType!,
          position: coordinates,
          orientation: ShipOrientation.horizontal,
        ),
      );
      selectedShipType = null;
      notifyListeners();
    }
  }
}
