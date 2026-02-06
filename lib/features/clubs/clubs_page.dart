import 'package:flutter/material.dart';
import '../../core/supabase/supabase_client.dart';
import 'data/club_model.dart';
import 'club_detail_page.dart';

class ClubsPage extends StatefulWidget {
  const ClubsPage({super.key});

  @override
  State<ClubsPage> createState() => _ClubsPageState();
}

class _ClubsPageState extends State<ClubsPage> {
  String _search = '';
  String _league = 'All';

  static const _leagues = [
    'All',
    'V-League',
    'V-League 2',
  ];

  Future<List<Club>> _fetchClubs() async {
    var query = supabase
        .from('clubs')
        .select(
          'id, name, slug, stadium, league, founded_year, logo_url',
        );

    if (_search.isNotEmpty) {
      query = query.ilike('name', '%$_search%');
    }

    if (_league != 'All') {
      query = query.eq('league', _league);
    }

    final data = await query.order('name');

    return (data as List)
        .map((e) => Club.fromJson(e))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Clubs')),
      body: Column(
        children: [
          _ClubSearchBar(
            leagues: _leagues,
            selectedLeague: _league,
            onLeagueChanged: (v) => setState(() => _league = v),
            onSearchChanged: (v) => setState(() => _search = v),
          ),
          Expanded(
            child: FutureBuilder<List<Club>>(
              future: _fetchClubs(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final clubs = snapshot.data!;
                if (clubs.isEmpty) {
                  return const Center(child: Text('No results'));
                }

                return ListView.builder(
                  itemCount: clubs.length,
                  itemBuilder: (_, i) {
                    final club = clubs[i];
                    return ListTile(
                      leading: club.logoUrl != null
                          ? Image.network(
                              club.logoUrl!,
                              width: 36,
                              height: 36,
                            )
                          : const Icon(Icons.shield),
                      title: Text(club.name),
                      subtitle: Text(club.league ?? ''),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                ClubDetailPage(club: club),
                          ),
                        );
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

class _ClubSearchBar extends StatelessWidget {
  final List<String> leagues;
  final String selectedLeague;
  final ValueChanged<String> onLeagueChanged;
  final ValueChanged<String> onSearchChanged;

  const _ClubSearchBar({
    required this.leagues,
    required this.selectedLeague,
    required this.onLeagueChanged,
    required this.onSearchChanged,
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
              hintText: 'Search clubs',
              border: OutlineInputBorder(),
            ),
            onChanged: onSearchChanged,
          ),
          const SizedBox(height: 8),
          // DropdownButtonFormField<String>(
          //   initialValue: selectedLeague,
          //   decoration: const InputDecoration(
          //     labelText: 'League',
          //     border: OutlineInputBorder(),
          //   ),
          //   items: leagues
          //       .map(
          //         (l) => DropdownMenuItem(
          //           value: l,
          //           child: Text(l),
          //         ),
          //       )
          //       .toList(),
          //   onChanged: (v) => onLeagueChanged(v!),
          // ),
        ],
      ),
    );
  }
}
