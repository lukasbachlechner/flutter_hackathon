enum ShipType {
  carrier(size: 5, name: 'Carrier'),
  battleship(size: 4, name: 'Battleship'),
  cruiser(size: 3, name: 'Cruiser'),
  submarine(size: 3, name: 'Submarine'),
  destroyer(size: 2, name: 'Destroyer');

  final int size;
  final String name;

  const ShipType({required this.size, required this.name});
}

enum powerShots { bomb, torpedo, missile, radar }
