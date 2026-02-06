import 'package:flutter/material.dart';
import 'data/club_model.dart';

class ClubDetailPage extends StatelessWidget {
  final Club club;

  const ClubDetailPage({super.key, required this.club});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(club.name)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('League: ${club.league ?? '-'}'),
            Text('Stadium: ${club.stadium ?? '-'}'),
            Text('Founded: ${club.foundedYear ?? '-'}'),
          ],
        ),
      ),
    );
  }
}
