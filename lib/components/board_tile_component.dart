import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hackathon/game.dart';

class BoardTileComponent extends RectangleComponent
    with TapCallbacks, HasGameRef<BattleshipGame> {
  BoardTileComponent({
    required this.row,
    required this.column,
    required double size,
  }) : super(
          position: Vector2(row * size, column * size),
          size: Vector2.all(size),
          anchor: Anchor.topLeft,
          paint: Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2
            ..color = Colors.red,
        );

  final int row;
  final int column;

  bool tapped = false;
  bool hovered = false;

  void setHovered(bool value) {
    hovered = value;
  }

  @override
  void onTapUp(TapUpEvent event) {
    tapped = !tapped;
    super.onTapUp(event);
  }

  @override
  void render(Canvas canvas) {
    if (hovered) {
      canvas.drawRect(
        Rect.fromLTWH(
          0,
          0,
          size.x,
          size.y,
        ),
        Paint()
          ..color = Colors.yellow
          ..strokeWidth = 2,
      );
    } else if (tapped) {
      canvas.drawRect(
        Rect.fromLTWH(
          0,
          0,
          size.x,
          size.y,
        ),
        Paint()
          ..color = Colors.green
          ..strokeWidth = 2,
      );
    }

    super.render(canvas);
  }
}
