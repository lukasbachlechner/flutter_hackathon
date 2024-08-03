import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter_hackathon/components/board_tile_component.dart';
import 'package:flutter_hackathon/game.dart';

class BoardComponent extends PositionComponent
    with PointerMoveCallbacks, HasGameRef<BattleshipGame> {
  BoardComponent({
    super.position,
    super.size,
    required this.tiles,
  });

  final List<BoardTileComponent> tiles;

  @override
  FutureOr<void> onLoad() {
    addAll(tiles);
    return super.onLoad();
  }

  void unhoverAll() {
    for (var element in tiles) {
      element.setHovered(false);
    }
  }

  (BoardTileComponent? tile, int index) findTileAtGlobalPosition(
      Vector2 position) {
    final selectedTileIndex = tiles.indexWhere(
      (element) => element.containsPoint(position),
    );

    if (selectedTileIndex != -1) {
      return (tiles[selectedTileIndex], selectedTileIndex);
    }

    return (null, -1);
  }

  @override
  void onPointerMove(PointerMoveEvent event) {
    unhoverAll();

    final (tile, selectedTileIndex) =
        findTileAtGlobalPosition(event.canvasPosition);

    if (tile != null) {
      late final List<BoardTileComponent> neighbors;

      if (game.selectionIsHorizontal) {
        neighbors =
            _getRightNeighbors(selectedTileIndex, game.selectedShipSize);
      } else {
        neighbors =
            _getBottomNeighbors(selectedTileIndex, game.selectedShipSize);
      }

      tile.setHovered(true);
      for (var tile in neighbors) {
        tile.setHovered(true);
      }
    }

    super.onPointerMove(event);
  }

  List<BoardTileComponent> _getRightNeighbors(
      int selectedTileIndex, int shipSize) {
    final rightNeighbors = <BoardTileComponent>[];

    final countToReturn = shipSize - 1;

    for (var i = 1; i <= countToReturn; i++) {
      final targetIndex = selectedTileIndex + (game.gridSize * i);

      if (targetIndex < tiles.length) {
        rightNeighbors.add(tiles[targetIndex]);
      }
    }

    return rightNeighbors;
  }

  List<BoardTileComponent> _getBottomNeighbors(
      int selectedTileIndex, int shipSize) {
    final bottomNeighbors = <BoardTileComponent>[];

    final countToReturn = shipSize - 1;

    for (var i = 1; i <= countToReturn; i++) {
      final targetIndex = selectedTileIndex + i;

      if (targetIndex < tiles.length) {
        bottomNeighbors.add(tiles[targetIndex]);
      }
    }

    return bottomNeighbors;
  }
}
