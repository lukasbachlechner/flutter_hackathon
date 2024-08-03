import 'package:flutter/material.dart';
import 'package:flutter_hackathon/game_provider.dart';
import 'package:provider/provider.dart';

class GameAppBar extends StatelessWidget {
  const GameAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: switch (context.watch<GameController>().state) {
        GlobalGameState.start => const Text('Start'),
        GlobalGameState.choosing => const Text('Choose your ships'),
        GlobalGameState.playing => const Text('Playing'),
      },
    );
  }
}
