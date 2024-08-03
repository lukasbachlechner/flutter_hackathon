import 'dart:math';

import 'package:flutter_hackathon/models/helper/coordinates.model.dart';
import 'package:flutter_hackathon/models/ship.model.dart';

class Board {
  Board({required this.name, required this.gridSize}) {
    placeMines();
  }

  final String name;
  int numberOfTurnsFinished = 0;
  final int gridSize;

  final List<Coordinates> mines = [];

  final List<Ship> ships = [];

  void placeMines() {
    final mineCount = gridSize / 10;
    final random = Random();
    final mines = <Coordinates>[];

    for (var i = 0; i < mineCount; i++) {
      final randomLatitude = random.nextInt(gridSize);
      final randomLongitude = random.nextInt(gridSize);
      mines.add(
          Coordinates(latitude: randomLatitude, longitude: randomLongitude));
    }
  }

  void incrementTurns() {
    numberOfTurnsFinished++;
  }

  bool canAddShip(Ship ship) {
    // TODO: Implement this method
    return ships.length < 5;
  }

  void addShip(Ship ship) {
    if (ships.length == 5) {
      throw Exception('Board already has 5 ships');
    }

    ships.add(ship);
  }

  bool isBoardReady() {
    return ships.length == 5;
  }
}
