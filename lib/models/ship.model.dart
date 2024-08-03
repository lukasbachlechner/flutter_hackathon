import 'package:flutter_hackathon/models/helper/coordinates.model.dart';
import 'package:flutter_hackathon/models/helper/shiptype.model.dart';

class Ship {
  Ship({required this.type, required this.position, required this.orientation});

  final ShipType type;
  final Coordinates position;
  final Orientation orientation;
}
