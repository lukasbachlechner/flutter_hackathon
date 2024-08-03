import 'dart:math';

import 'package:flutter_hackathon/models/helper/coordinates.model.dart';
import 'package:flutter_hackathon/models/helper/hits.model.dart';
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
  final List<CellHit> cellHits = [];
  final Map<PowerShots, int> powerShotsUsed = {
    PowerShots.bomb: 0,
    PowerShots.torpedo: 0,
    PowerShots.missile: 0,
    PowerShots.radar: 0,
    PowerShots.random: 0
  };

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

  CellHasWhat getCellStatus(Coordinates coordinates) {
    for (var cellHit in cellHits) {
      if (cellHit.coordinates.latitude == coordinates.latitude &&
          cellHit.coordinates.longitude == coordinates.longitude) {
        return cellHit.cellHas;
      }
    }
    return CellHasWhat.undiscovered;
  }

  ShipType? cellHasShip(Coordinates coordinates) {
    for (var ship in ships) {
      final shipStartEndPosition = ship.getStartEndPosition();
      if (shipStartEndPosition.start.latitude <= coordinates.latitude &&
          shipStartEndPosition.end.latitude >= coordinates.latitude &&
          shipStartEndPosition.start.longitude <= coordinates.longitude &&
          shipStartEndPosition.end.longitude >= coordinates.longitude) {
        return ship.type;
      }
    }
    return null;
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

  CellHit hitCell(Coordinates coordinates, HitType hitType) {
    if (isCoordinateOutOfBounds(coordinates)) {
      throw Exception('Coordinates are out of bounds');
    }
    for (var cellHit in cellHits) {
      if (cellHit.coordinates.latitude == coordinates.latitude &&
          cellHit.coordinates.longitude == coordinates.longitude) {
        return CellHit(
            coordinates: coordinates,
            status: cellHit.status,
            cellHas: CellHasWhat.alreadyHit);
      }
    }
    var isCellHasShip = false;
    for (var ship in ships) {
      final shipStartEndPosition = ship.getStartEndPosition();
      if (shipStartEndPosition.start.latitude <= coordinates.latitude &&
          shipStartEndPosition.end.latitude >= coordinates.latitude &&
          shipStartEndPosition.start.longitude <= coordinates.longitude &&
          shipStartEndPosition.end.longitude >= coordinates.longitude) {
        if (hitType == HitType.damage) {
          ship.hitShip(coordinates);
        }
        isCellHasShip = true;
        break;
      }
    }
    final isCellHasMine = mines.any((mine) =>
        mine.latitude == coordinates.latitude &&
        mine.longitude == coordinates.longitude);
    final cellHit = CellHit(
        coordinates: coordinates,
        status: hitType,
        cellHas: isCellHasShip
            ? isCellHasMine
                ? CellHasWhat.shipAndMine
                : CellHasWhat.ship
            : CellHasWhat.ship);
    cellHits.add(cellHit);
    return cellHit;
  }

  isAllShipSunk() {
    return ships.every((ship) => ship.isSunk);
  }

  List<CellHit> hitCellWithPowerShot(Coordinates coordinates,
      PowerShots powerShot, ShipOrientation? direction) {
    switch (powerShot) {
      case PowerShots.bomb:
        return hitCellWithBomb(coordinates);
      case PowerShots.torpedo:
        return hitCellWithTorpedo(
            coordinates, direction ?? ShipOrientation.horizontal);
      case PowerShots.missile:
        return hitCellWithMissile(
            coordinates, direction ?? ShipOrientation.horizontal);
      case PowerShots.radar:
        return hitCellWithRadar(coordinates);
      case PowerShots.random:
        // return hitCellWithRandom(coordinates);
        throw Exception('Random power shot not implemented');
      default:
        throw Exception('Invalid power shot');
    }
  }

  List<CellHit> hitCellWithBomb(Coordinates coordinates) {
    final List<CellHit> hitCellImpacts = [];
    final int bombRangeFromCentre = (gridSize / 20).round();
    for (var i = coordinates.latitude - bombRangeFromCentre;
        i <= coordinates.latitude + bombRangeFromCentre;
        i++) {
      for (var j = coordinates.longitude - bombRangeFromCentre;
          j <= coordinates.longitude + bombRangeFromCentre;
          j++) {
        if (i < 0 || i >= gridSize || j < 0 || j >= gridSize) {
          continue;
        }
        hitCellImpacts.add(
            hitCell(Coordinates(latitude: i, longitude: j), HitType.damage));
      }
    }
    powerShotsUsed[PowerShots.bomb] =
        (powerShotsUsed[PowerShots.bomb] ?? 0) + 1;
    return hitCellImpacts;
  }

  List<CellHit> hitCellWithTorpedo(
      Coordinates coordinates, ShipOrientation direction) {
    final List<CellHit> hitCellImpacts = [];
    final int torpedoRange = (gridSize / 4).round();
    for (var i = 0; i <= torpedoRange; i++) {
      final latitude = direction == ShipOrientation.horizontal
          ? coordinates.latitude
          : coordinates.latitude + i;
      final longitude = direction == ShipOrientation.horizontal
          ? coordinates.longitude + i
          : coordinates.longitude;
      if (latitude < 0 ||
          latitude >= gridSize ||
          longitude < 0 ||
          longitude >= gridSize) {
        continue;
      }
      final hitCellImpact = hitCell(
          Coordinates(latitude: latitude, longitude: longitude),
          HitType.damage);
      hitCellImpacts.add(hitCellImpact);
      if (hitCellImpact.cellHas == CellHasWhat.ship) {
        break;
      }
    }
    powerShotsUsed[PowerShots.torpedo] =
        (powerShotsUsed[PowerShots.torpedo] ?? 0) + 1;
    return hitCellImpacts;
  }

  List<CellHit> hitCellWithMissile(
      Coordinates coordinates, ShipOrientation direction) {
    final List<CellHit> hitCellImpacts = [];
    final int torpedoRange = (gridSize / 4).round();
    for (var i = 0; i <= torpedoRange; i++) {
      final latitude = direction == ShipOrientation.horizontal
          ? coordinates.latitude
          : coordinates.latitude + i;
      final longitude = direction == ShipOrientation.horizontal
          ? coordinates.longitude + i
          : coordinates.longitude;
      final hitCellImpact = hitCell(
          Coordinates(latitude: latitude, longitude: longitude),
          HitType.damage);
      if (latitude < 0 ||
          latitude >= gridSize ||
          longitude < 0 ||
          longitude >= gridSize) {
        continue;
      }
      hitCellImpacts.add(hitCellImpact);
    }
    powerShotsUsed[PowerShots.missile] =
        (powerShotsUsed[PowerShots.missile] ?? 0) + 1;
    return hitCellImpacts;
  }

  List<CellHit> hitCellWithRadar(Coordinates coordinates) {
    final hitCellImpact = hitCell(
        Coordinates(
            latitude: coordinates.latitude, longitude: coordinates.longitude),
        HitType.reveal);
    powerShotsUsed[PowerShots.radar] =
        (powerShotsUsed[PowerShots.radar] ?? 0) + 1;
    return [hitCellImpact];
  }

  Map<PowerShots, int> get availablePowerShots {
    final unsunkShips = ships.where((ship) => !ship.isSunk);
    final availablePowerShots = {
      PowerShots.bomb: 0,
      PowerShots.torpedo: 0,
      PowerShots.missile: 0,
      PowerShots.radar: 0,
      PowerShots.random: 0
    };
    for (var ship in unsunkShips) {
      for (var powerShot in ship.type.powerShots.keys) {
        availablePowerShots[powerShot] =
            ship.type.powerShots[powerShot]! - powerShotsUsed[powerShot]!;
      }
    }
    return availablePowerShots;
  }

  // List<CellHit> hitCellWithRandom(Coordinates coordinates) {}
}

class CellHit {
  final Coordinates coordinates;
  final HitType status;
  final CellHasWhat cellHas;

  CellHit(
      {required this.coordinates, required this.status, required this.cellHas});
}

enum CellHasWhat { ship, shipAndMine, alreadyHit, undiscovered }
