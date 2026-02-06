import 'package:flutter/material.dart';
import '../../core/supabase/supabase_client.dart';
import 'data/player_model.dart';

class PlayerDetailPage extends StatelessWidget {
  final String playerId;

  const PlayerDetailPage({super.key, required this.playerId});

  Future<Player> _fetchPlayer() async {
    final data = await supabase
        .from('players')
        .select('''
          id,
          full_name,
          short_name,
          birth_date,
          nationality,
          position,
          height_cm,
          preferred_foot,
          current_club,
          club_jersey_number,
          bio,
          career_highlights,
          profile_image_url,
          is_verified
        ''')
        .eq('id', playerId)
        .single();

    return Player.fromJson(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Player Details')),
      body: FutureBuilder<Player>(
        future: _fetchPlayer(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final p = snapshot.data!;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 56,
                    backgroundImage: p.profileImageUrl != null
                        ? NetworkImage(p.profileImageUrl!)
                        : null,
                    child: p.profileImageUrl == null
                        ? const Icon(Icons.person, size: 56)
                        : null,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      p.fullName,
                      style:
                          Theme.of(context).textTheme.headlineSmall,
                    ),
                    if (p.isVerified)
                      const Padding(
                        padding: EdgeInsets.only(left: 6),
                        child: Icon(Icons.verified,
                            color: Colors.blue, size: 20),
                      ),
                  ],
                ),
                if (p.shortName != null)
                  Center(child: Text(p.shortName!)),
                const SizedBox(height: 24),

                _InfoRow('Nationality', p.nationality),
                _InfoRow('Position', p.position),
                _InfoRow('Height', p.heightCm != null
                    ? '${p.heightCm} cm'
                    : null),
                _InfoRow('Preferred Foot', p.preferredFoot),
                _InfoRow('Current Club', p.currentClub),
                _InfoRow('Jersey Number',
                    p.clubJerseyNumber?.toString()),

                if (p.bio != null) ...[
                  const SizedBox(height: 16),
                  Text('Bio',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium),
                  Text(p.bio!),
                ],

                if (p.careerHighlights.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  Text('Career Highlights',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium),
                  ...p.careerHighlights
                      .map((e) => Text('• $e')),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String? value;

  const _InfoRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    if (value == null || value!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(child: Text(value!)),
        ],
      ),
    );
  }
}
