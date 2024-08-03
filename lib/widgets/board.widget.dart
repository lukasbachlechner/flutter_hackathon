import 'package:flutter/material.dart' hide PointerMoveEvent;
import 'package:flutter_hackathon/constants/constants.dart';
import 'package:flutter_hackathon/models/board.model.dart';
import 'package:flutter_hackathon/models/helper/coordinates.model.dart';

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
          (columnIndex) => _buildRow(columnIndex),
        ),
      ],
    );
  }

  Widget _buildRow(int columnIndex) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...List.generate(
          board.gridSize,
          (rowIndex) => _buildTile(columnIndex, rowIndex),
        ),
      ],
    );
  }

  Widget _buildTile(int columnIndex, int rowIndex) {
    // final tile = board.tiles[rowIndex][columnIndex];
    final isHighlighted = highlighted.any((coordinate) =>
        coordinate.latitude == rowIndex && coordinate.longitude == columnIndex);

    return GestureDetector(
      onTap: () {
        // board.onTileTap(rowIndex, columnIndex);
      },
      child: Container(
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: isHighlighted ? Colors.red : Colors.white,
        ),
        width: tileSizePx,
        height: tileSizePx,
      ),
    );
  }
}
