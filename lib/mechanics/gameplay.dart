import 'package:flutter_hackathon/models/board.model.dart';
import 'package:flutter_hackathon/models/game.model.dart';
import 'package:flutter_hackathon/models/helper/coordinates.model.dart';
import 'package:flutter_hackathon/models/helper/hits.model.dart';
import 'package:flutter_hackathon/models/helper/shiptype.model.dart';

class GamePlay {
  const GamePlay({required this.game});
  final Game game;

  List<CellHit> hitCell(Coordinates coordinates, PowerShots? powerShot,
      ShipOrientation? direction) {
    if (powerShot == null) {
      final CellHit cellHitImpact =
          opponentBoard.hitCell(coordinates, HitType.damage);
      return [cellHitImpact];
    } else {
      return opponentBoard.hitCellWithPowerShot(
          coordinates, powerShot, direction);
    }
  }

  nextTurn() {
    playerBoard.incrementTurns();
  }

  Board get playerBoard {
    return game.whoPlaysNext();
  }

  Board get opponentBoard {
    return playerBoard == game.playerA ? game.playerB : game.playerA;
  }
}
