import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hackathon/models/ship.model.dart';

import '../models/helper/coordinates.model.dart';

Vector2 positionOfShip(Ship ship) {
  return Vector2(
    ship.position.latitude.toDouble(),
    ship.position.longitude.toDouble(),
  );
}

Vector2 sizeOfShip(Ship ship) {
  if (ship.orientation == ShipOrientation.horizontal) {
    return Vector2(ship.type.size.toDouble(), 1);
  } else {
    return Vector2(1, ship.type.size.toDouble());
  }
}

class ShipComponent extends PositionComponent {
  ShipComponent({
    required this.ship,
  }) : super(
          size: sizeOfShip(ship),
          position: positionOfShip(ship),
        );

  final Ship ship;

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.x, size.y),
      Paint()..color = Colors.green,
    );
  }
}
