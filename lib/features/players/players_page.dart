import 'package:flutter/material.dart';
import '../../core/supabase/supabase_client.dart';
import 'data/player_model.dart';
import 'player_detail_page.dart';

class PlayersPage extends StatelessWidget {
  const PlayersPage({super.key});

  Future<List<Player>> _fetchPlayers() async {
    final data = await supabase
        .from('players')
        .select('id, full_name, position, profile_image_url');

    return (data as List)
        .map((e) => Player.fromJson(e))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Players')),
      body: FutureBuilder<List<Player>>(
        future: _fetchPlayers(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final players = snapshot.data!;
          return ListView.builder(
            itemCount: players.length,
            itemBuilder: (_, i) {
              final player = players[i];
              return ListTile(
                title: Text(player.fullName),
                subtitle: Text(player.position ?? ''),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          PlayerDetailPage(player: player),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
