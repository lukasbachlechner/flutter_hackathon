import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hackathon/game_provider.dart';
import 'package:flutter_hackathon/models/helper/shiptype.model.dart';
import 'package:provider/provider.dart';

class ShotSelectionWidget extends StatelessWidget {
  const ShotSelectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<PowerShots, int> shots =
        context.watch<GameController>().currentBoard?.availablePowerShots ?? {};
    final actualShots = shots.entries
        .where((element) => element.value > 0)
        .map((e) => e)
        .toList();

    final PowerShots? selectedShot =
        context.read<GameController>().selectedShot;

    return Column(
      children: [
        ListTile(
          title: const Text('Basic Shot'),
          trailing: const Icon(CupertinoIcons.infinite),
          tileColor:
              selectedShot == null ? Colors.lightBlueAccent : Colors.white,
          onTap: () {
            context.read<GameController>().selectShot(null);
          },
        ),
        ...List.generate(
          actualShots.length,
          (index) => _listTile(
            context,
            actualShots[index].key,
            actualShots[index].value,
            selectedShot == actualShots[index].key,
          ),
        ),
      ],
    );
  }

  Widget _listTile(
      BuildContext context, PowerShots shot, int shotNumber, bool isSelected) {
    return ListTile(
      title: Text(shot.toString()),
      trailing: Text(shotNumber.toString()),
      tileColor: isSelected ? Colors.lightBlueAccent : Colors.white,
      onTap: () {
        context.read<GameController>().selectShot(shot);
      },
    );
  }
}


// Row(
//             children: [
//               Expanded(
//                 flex: 2,
//                 child: BoardWidget(
//                   board: Board(
//                     name: '',
//                     gridSize: 20,
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     ShotSelectionWidget(
//                       shots: {
//                         PowerShots.bomb: 5,
//                         PowerShots.missile: 3,
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ],