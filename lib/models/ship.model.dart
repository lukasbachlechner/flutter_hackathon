import 'package:flutter_hackathon/models/helper/coordinates.model.dart';
import 'package:flutter_hackathon/models/helper/shiptype.model.dart';

class CoordinatesTuple {
  final Coordinates start;
  final Coordinates end;

  CoordinatesTuple(this.start, this.end);
}

class Ship {
  Ship({required this.type, required this.position, required this.orientation});

  final ShipType type;
  final Coordinates position;
  final ShipOrientation orientation;

  CoordinatesTuple getStartEndPosition() {
    Coordinates start = position;
    Coordinates end;

    if (orientation == ShipOrientation.horizontal) {
      end = Coordinates(
          latitude: position.latitude,
          longitude: position.longitude + type.size - 1);
    } else {
      end = Coordinates(
          latitude: position.latitude + type.size - 1,
          longitude: position.longitude);
    }

    return CoordinatesTuple(start, end);
  }
}
