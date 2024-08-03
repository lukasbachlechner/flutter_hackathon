import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

import '../models/ship.model.dart';
import 'ship_component.dart';

Color colorOfState(ShipPlacementState state) {
  switch (state) {
    case ShipPlacementState.available:
      return const Color.fromARGB(255, 62, 62, 62);
    case ShipPlacementState.placing:
      return Color.fromARGB(255, 127, 191, 247);
    case ShipPlacementState.placed:
      return const Color.fromARGB(255, 225, 225, 225);
  }
}

class ShipSelectionComponent extends RectangleComponent with TapCallbacks {
  ShipSelectionComponent({
    required this.ship,
    required Vector2 position,
    this.state = ShipPlacementState.available,
  }) : super(
            size: sizeOfShip(ship)..scale(100),
            position: position,
            paint: Paint()..color = colorOfState(state));

  final Ship ship;
  ShipPlacementState state;

  @override
  bool onTapUp(TapUpEvent event) {
    if (state == ShipPlacementState.available) {
      state = ShipPlacementState.placing;
    } else if (state == ShipPlacementState.placing) {
      state = ShipPlacementState.placed;
    } else {
      state = ShipPlacementState.available;
    }

    paint = Paint()..color = colorOfState(state);
    return true;
  }
}

enum ShipPlacementState { available, placing, placed }
