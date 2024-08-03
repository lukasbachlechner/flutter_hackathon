enum ShipType {
  carrier(size: 5, name: 'Carrier', powerShots: {PowerShots.bomb: 1}),
  battleship(size: 4, name: 'Battleship', powerShots: {PowerShots.torpedo: 1}),
  cruiser(size: 3, name: 'Cruiser', powerShots: {PowerShots.missile: 1}),
  submarine(size: 3, name: 'Submarine', powerShots: {PowerShots.radar: 1}),
  destroyer(size: 2, name: 'Destroyer', powerShots: {});

  final int size;
  final String name;
  final Map<PowerShots, int> powerShots;
  const ShipType(
      {required this.size, required this.name, required this.powerShots});
}

enum PowerShots { bomb, torpedo, missile, radar }
