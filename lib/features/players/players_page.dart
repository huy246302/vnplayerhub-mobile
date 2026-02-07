import 'package:flutter/material.dart';
import '../../core/supabase/supabase_client.dart';
import 'data/player_model.dart';
import 'player_detail_page.dart';

class PlayersPage extends StatefulWidget {
  const PlayersPage({super.key});

  @override
  State<PlayersPage> createState() => _PlayersPageState();
}

class _PlayersPageState extends State<PlayersPage> {
  String _search = '';
  String _position = 'All';

  static const _positions = [
    'All',
    'Thủ môn',
    'Hậu vệ',
    'Tiền vệ',
    'Tiền đạo',
  ];

  Future<List<Player>> _fetchPlayers() async {
    var query = supabase
        .from('players')
        .select('id, full_name, position, profile_image_url');

    if (_search.isNotEmpty) {
      query = query.ilike('full_name', '%$_search%');
    }

    if (_position != 'All') {
      query = query.eq('position', _position);
    }

    final data = await query.order('full_name');

    return (data as List)
        .map((e) => Player.fromJson(e))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Players')),
      body: Column(
        children: [
          _SearchBar(
            positions: _positions,
            onChanged: (v) => setState(() => _search = v),
            position: _position,
            onPositionChanged: (v) =>
                setState(() => _position = v),
          ),
          Expanded(
            child: FutureBuilder<List<Player>>(
              future: _fetchPlayers(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                      child: CircularProgressIndicator());
                }

                final players = snapshot.data!;
                if (players.isEmpty) {
                  return const Center(child: Text('No results'));
                }

                return ListView.builder(
                  itemCount: players.length,
                  itemBuilder: (_, i) {
                    final player = players[i];
                    return ListTile(
                      leading: player.profileImageUrl != null
                          ? CircleAvatar(
                              backgroundImage:
                                  NetworkImage(player.profileImageUrl!),
                            )
                          : const CircleAvatar(
                              child: Icon(Icons.person),
                            ),
                      title: Text(player.fullName),
                      subtitle: Text(player.position ?? ''),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PlayerDetailPage(playerId: player.id),
                        ));
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final String position;
  final ValueChanged<String> onPositionChanged;
  final List<String> positions;

  const _SearchBar({
    required this.onChanged,
    required this.position,
    required this.onPositionChanged,
    required this.positions,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          TextField(
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Search players',
              border: OutlineInputBorder(),
            ),
            onChanged: onChanged,
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            initialValue: position,
            items: positions
                .map(
                  (p) => DropdownMenuItem(
                    value: p,
                    child: Text(p),
                  ),
                )
                .toList(),
            onChanged: (v) => onPositionChanged(v!),
            decoration: const InputDecoration(
              labelText: 'Position',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }
}
