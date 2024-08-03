import 'dart:math';

import 'package:flutter_hackathon/models/helper/coordinates.model.dart';
import 'package:flutter_hackathon/models/helper/shiptype.model.dart';
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

  bool isShipTypeAlreadyAdded(ShipType shipType) {
    return ships.any((ship) => ship.type == shipType);
  }

  void addShipGuard(Ship shipToAdd) {
    if (ships.length >= 5) {
      throw Exception('Board already has 5 ships');
    }
    if (isShipTypeAlreadyAdded(shipToAdd.type)) {
      throw Exception('Ship type already added');
    }
    final shipStartEndPosition = shipToAdd.getStartEndPosition();
    if (isCoordinateOutOfBounds(shipStartEndPosition.start) ||
        isCoordinateOutOfBounds(shipStartEndPosition.end)) {
      throw Exception('Ship is out of bounds');
    }
    if (ships.any((ship) => isOverlapping(shipToAdd))) {
      throw Exception('Ship is overlapping with another one');
    }
  }

  void addShip(Ship ship) {
    addShipGuard(ship);
    ships.add(ship);
  }

  bool isBoardReady() {
    return ships.length == 5;
  }

  bool isCoordinateOutOfBounds(Coordinates coordinates) {
    return coordinates.latitude < 0 ||
        coordinates.latitude >= gridSize ||
        coordinates.longitude < 0 ||
        coordinates.longitude >= gridSize;
  }

  bool isOverlapping(Ship shipToAdd) {
    for (var ship in ships) {
      final shipStartEndPosition = ship.getStartEndPosition();
      final shipToAddStartEndPosition = shipToAdd.getStartEndPosition();

      if (shipStartEndPosition.start.latitude <=
              shipToAddStartEndPosition.end.latitude &&
          shipStartEndPosition.end.latitude >=
              shipToAddStartEndPosition.start.latitude &&
          shipStartEndPosition.start.longitude <=
              shipToAddStartEndPosition.end.longitude &&
          shipStartEndPosition.end.longitude >=
              shipToAddStartEndPosition.start.longitude) {
        return true;
      }
    }
    return false;
  }
}
