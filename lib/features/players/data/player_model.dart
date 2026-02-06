class Player {
  final String id;
  final String fullName;
  final String? position;
  final String? profileImageUrl;

  Player({
    required this.id,
    required this.fullName,
    this.position,
    this.profileImageUrl,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      id: json['id'],
      fullName: json['full_name'],
      position: json['position'],
      profileImageUrl: json['profile_image_url'],
    );
  }
}
