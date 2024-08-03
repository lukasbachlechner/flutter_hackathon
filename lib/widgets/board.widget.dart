import 'package:flutter/material.dart' hide PointerMoveEvent;
import 'package:flutter_hackathon/constants/constants.dart';
import 'package:flutter_hackathon/game_provider.dart';
import 'package:flutter_hackathon/models/board.model.dart';
import 'package:flutter_hackathon/models/helper/coordinates.model.dart';
import 'package:provider/provider.dart';

class BoardWidget extends StatelessWidget {
  const BoardWidget(
      {super.key, required this.board, this.highlighted = const []});

  final Board board;
  final List<Coordinates> highlighted;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...List.generate(
          board.gridSize,
          (columnIndex) => _buildRow(columnIndex, context),
        ),
      ],
    );
  }

  Widget _buildRow(int columnIndex, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...List.generate(
          board.gridSize,
          (rowIndex) => _buildTile(columnIndex, rowIndex, context),
        ),
      ],
    );
  }

  Widget _buildTile(int columnIndex, int rowIndex, BuildContext context) {
    final coordinate = Coordinates(latitude: rowIndex, longitude: columnIndex);

    Color tileColor = Colors.white;

    final isHighlighted = highlighted.any((coordinate) =>
        coordinate.latitude == rowIndex && coordinate.longitude == columnIndex);

    final hasShip = board.cellHasShip(coordinate);

    final cellStatus = board.getCellStatus(coordinate);

    if (hasShip != null) {
      tileColor = Colors.blue;
    } else if (cellStatus == CellHasWhat.undiscovered) {
      tileColor = Colors.white;
    } else if (cellStatus == CellHasWhat.alreadyHit) {
      tileColor = Color.fromARGB(255, 19, 19, 19);
    } else if (cellStatus == CellHasWhat.shipAndMine) {
      tileColor = const Color.fromARGB(255, 141, 36, 29);
    }

    return GestureDetector(
      onTap: () {
        context.read<GameController>().handleTileTapped(
            Coordinates(latitude: rowIndex, longitude: columnIndex));
      },
      child: Container(
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: tileColor,
        ),
        width: tileSizePx,
        height: tileSizePx,
      ),
    );
  }
}
