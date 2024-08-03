import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

import '../models/ship.model.dart';
import 'ship_component.dart';

Color colorOfState(ShipPlacementState state) {
  switch (state) {
    case ShipPlacementState.available:
      return Colors.green;
    case ShipPlacementState.placing:
      return Colors.yellow;
    case ShipPlacementState.placed:
      return Colors.red;
  }
}

class ShipSelectionComponent extends RectangleComponent with TapCallbacks {
  ShipSelectionComponent({
    required this.ship,
    required Vector2 position,
    this.state = ShipPlacementState.available,
  }) : super(
            size: sizeOfShip(ship),
            position: position,
            paint: Paint()..color = colorOfState(state));

  final Ship ship;
  final ShipPlacementState state;

  // @override
  // bool onTapUp() {
  //   return true;
  // }
}

enum ShipPlacementState { available, placing, placed }
