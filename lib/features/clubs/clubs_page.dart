import 'package:flutter/material.dart';
import '../../core/supabase/supabase_client.dart';
import 'data/club_model.dart';
import 'club_detail_page.dart';

class ClubsPage extends StatelessWidget {
  const ClubsPage({super.key});

  Future<List<Club>> _fetchClubs() async {
    final data = await supabase
        .from('clubs')
        .select('id, name, slug, stadium, league, founded_year, logo_url');

    return (data as List)
        .map((e) => Club.fromJson(e))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Clubs')),
      body: FutureBuilder<List<Club>>(
        future: _fetchClubs(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final clubs = snapshot.data!;
          return ListView.builder(
            itemCount: clubs.length,
            itemBuilder: (_, i) {
              final club = clubs[i];
              return ListTile(
                title: Text(club.name),
                subtitle: Text(club.league ?? ''),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ClubDetailPage(club: club),
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
