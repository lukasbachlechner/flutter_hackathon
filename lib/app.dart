import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hackathon/game_provider.dart';
import 'package:flutter_hackathon/models/helper/coordinates.model.dart';
import 'package:flutter_hackathon/models/helper/shiptype.model.dart';
import 'package:flutter_hackathon/widgets/board.widget.dart';
import 'package:flutter_hackathon/widgets/shot_selection.widget.dart';
import 'package:flutter_hackathon/widgets/win_screen.dart';
import 'package:provider/provider.dart';

class BattleshipApp extends StatelessWidget {
  const BattleshipApp({super.key});

  @override
  Widget build(BuildContext context) {
    return switch (context.watch<GameController>().state) {
      GlobalGameState.start => const StartScreen(),
      GlobalGameState.choosing => const ChoosingScreen(),
      GlobalGameState.attacking => const PlayingScreen(),
      GlobalGameState.pressToPlay => const PressToContinue(),
      GlobalGameState.end => const WinScreen(),
    };
  }
}

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          context.read<GameController>().startChoosing();
        },
        child: const Text('Start the game'),
      ),
    );
  }
}

class ChoosingScreen extends StatelessWidget {
  const ChoosingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gameController = context.watch<GameController>();
    return Center(
      child: Row(
        children: [
          Flexible(
            flex: 3,
            child: gameController.turn != GameStateTurn.transition
                ? BoardWidget(
                    board: gameController.currentBoard!,
                    highlighted: const [],
                  )
                : const SizedBox(),
          ),
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...ShipType.values.map(
                  (shipType) => ListTile(
                    onTap: !gameController.currentBoard!
                            .isShipTypeAlreadyAdded(shipType)
                        ? () {
                            gameController.selectShipForPlacing(shipType);
                          }
                        : null,
                    tileColor: gameController.selectedShipType == shipType
                        ? Colors.lightBlue
                        : !gameController.currentBoard!
                                .isShipTypeAlreadyAdded(shipType)
                            ? Colors.white
                            : Colors.grey,
                    title: Text(shipType.name),
                  ),
                ),
                SwitchListTile(
                  title: const Text('Vertical orientation'),
                  value: gameController.selectedShipOrientation ==
                      ShipOrientation.vertical,
                  onChanged: (value) {
                    gameController.selectShipOrientation(value
                        ? ShipOrientation.vertical
                        : ShipOrientation.horizontal);
                  },
                ),
                ElevatedButton(
                  onPressed: gameController.turn == GameStateTurn.playerA &&
                          gameController.game.playerA.isBoardReady()
                      ? () {
                          gameController.nextTurn();
                        }
                      : null,
                  child: const Text('Next player'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: gameController.game.isGameReadyToStart()
                      ? () {
                          context.read<GameController>().startPlaying();
                        }
                      : null,
                  child: const Text('Done choosing'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PlayingScreen extends StatelessWidget {
  const PlayingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gameController = context.watch<GameController>();

    return Center(
      child: Row(
        children: [
          Flexible(
            flex: 3,
            child: gameController.turn != GameStateTurn.transition
                ? BoardWidget(
                    board: gameController.currentBoard!,
                    highlighted: const [],
                  )
                : const SizedBox(),
          ),
          const Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ShotSelectionWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PressToContinue extends StatelessWidget {
  const PressToContinue({super.key});

  @override
  Widget build(BuildContext context) {
    final gameController = context.watch<GameController>();

    return Center(
      child: Row(
        children: [
          Flexible(
            flex: 3,
            child: gameController.turn != GameStateTurn.transition
                ? BoardWidget(
                    board: gameController.currentBoard!,
                    highlighted: const [],
                  )
                : const SizedBox(),
          ),
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    context.read<GameController>().nextTurn();
                  },
                  child: const Text('Press to continue'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
