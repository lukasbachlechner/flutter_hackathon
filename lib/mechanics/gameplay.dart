import 'package:flutter_hackathon/models/board.model.dart';
import 'package:flutter_hackathon/models/game.model.dart';
import 'package:flutter_hackathon/models/helper/coordinates.model.dart';
import 'package:flutter_hackathon/models/helper/hits.model.dart';

class GamePlay {
  const GamePlay({required this.game});
  final Game game;

  CellHit hitCell(Coordinates coordinates, HitType hitType) {
    final CellHit cellHitImpact = opponentBoard.hitCell(coordinates, hitType);

    return cellHitImpact;
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
