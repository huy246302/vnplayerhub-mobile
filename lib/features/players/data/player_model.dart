class Player {
  final String id;
  final String fullName;
  final String? shortName;
  final DateTime? birthDate;
  final String nationality;
  final String? position;
  final int? heightCm;
  final String? preferredFoot;
  final String? currentClub;
  final int? clubJerseyNumber;
  final String? bio;
  final List<String> careerHighlights;
  final String? profileImageUrl;
  final bool isVerified;

  Player({
    required this.id,
    required this.fullName,
    this.shortName,
    this.birthDate,
    required this.nationality,
    this.position,
    this.heightCm,
    this.preferredFoot,
    this.currentClub,
    this.clubJerseyNumber,
    this.bio,
    required this.careerHighlights,
    this.profileImageUrl,
    required this.isVerified,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      id: json['id'],
      fullName: json['full_name'],
      shortName: json['short_name'],
      birthDate: json['birth_date'] != null
          ? DateTime.parse(json['birth_date'])
          : null,
      nationality: json['nationality'] ?? 'Việt Nam',
      position: json['position'],
      heightCm: json['height_cm'],
      preferredFoot: json['preferred_foot'],
      currentClub: json['current_club'],
      clubJerseyNumber: json['club_jersey_number'],
      bio: json['bio'],
      careerHighlights:
          List<String>.from(json['career_highlights'] ?? []),
      profileImageUrl: json['profile_image_url'],
      isVerified: json['is_verified'] ?? false,
    );
  }
}
