import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hackathon/game_provider.dart';
import 'package:flutter_hackathon/models/helper/shiptype.model.dart';
import 'package:provider/provider.dart';

class ShotSelectionWidget extends StatelessWidget {
  const ShotSelectionWidget({super.key, required this.shots});

  final Map<PowerShots, int> shots;

  @override
  Widget build(BuildContext context) {
    final actualShots = shots.entries
        .where((element) => element.value > 0)
        .map((e) => e.key)
        .toList();

    final PowerShots? selectedShot =
        Provider.of<GameController>(context).selectedShot;

    return Column(
      children: [
        ListTile(
          title: const Text('Basic Shot'),
          trailing: const Icon(CupertinoIcons.infinite),
          tileColor:
              selectedShot == null ? Colors.lightBlueAccent : Colors.white,
          onTap: () {
            Provider.of<GameController>(context).selectShot(null);
          },
        ),
        ...List.generate(actualShots.length,
            (index) => _listTile(context, actualShots[index])),
      ],
    );
  }

  Widget _listTile(BuildContext context, PowerShots shot) {
    return ListTile(
      title: Text(shot.toString()),
      trailing: Text(shots[shot].toString()),
      tileColor: Colors.white,
      onTap: () {
        Provider.of<GameController>(context).selectShot(shot);
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