import 'package:flutter/material.dart';
import 'data/player_model.dart';

class PlayerDetailPage extends StatelessWidget {
  final Player player;

  const PlayerDetailPage({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(player.fullName)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Text('Position: ${player.position ?? '-'}'),
      ),
    );
  }
}
