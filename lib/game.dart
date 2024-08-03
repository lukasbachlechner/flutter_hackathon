import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/layout.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hackathon/components/board_component.dart';
import 'package:flutter_hackathon/components/board_tile_component.dart';

import 'components/ship_selection_component.dart';
import 'models/helper/coordinates.model.dart';
import 'models/helper/shiptype.model.dart';
import 'models/ship.model.dart';

const int gridSize = 10;
const double itemSize = 48.0;

class BattleshipGame extends FlameGame with HasKeyboardHandlerComponents {
  BattleshipGame();

  final List<BoardTileComponent> board = [];

  bool selectionIsHorizontal = true;

  // TODO: Change ship size here when selecting
  int selectedShipSize = 3;

  void toggleSelection() {
    selectionIsHorizontal = !selectionIsHorizontal;
  }

  @override
  void onLoad() {
    final tiles = _generateBoardTiles();

    add(KeyboardListenerComponent(keyUp: {
      LogicalKeyboardKey.comma: (keys) {
        toggleSelection();

        return false;
      },
    }));

    add(
      AlignComponent(
        child: BoardComponent(
          tiles: tiles,
          position: Vector2.zero(),
          size: Vector2.all(itemSize * gridSize),
        ),
        alignment: Anchor.center,
      ),
    );

    add(
      ButtonComponent(
        onPressed: toggleSelection,
        button:
            TextComponent(text: 'Toggle selection', position: Vector2.zero()),
        position: Vector2(1000, 400),
        anchor: Anchor.topLeft,
      ),
    );

    add(
      AlignComponent(
        child: ShipSelectionComponent(
          ship: Ship(
            type: ShipType.battleship,
            orientation: ShipOrientation.vertical,
            position: Coordinates(latitude: 0, longitude: 0),
          ),
          position: Vector2(1000, 400),
        ),
        alignment: Anchor.topRight,
      ),
    );

    add(FpsTextComponent());
  }

  List<BoardTileComponent> _generateBoardTiles() {
    final tiles = <BoardTileComponent>[];
    for (var i = 0; i < gridSize; i++) {
      for (var j = 0; j < gridSize; j++) {
        tiles.add(BoardTileComponent(row: i, column: j, size: itemSize));
      }
    }
    return tiles;
  }
}
