class Club {
  final String id;
  final String name;
  final String slug;
  final String? stadium;
  final String? league;
  final int? foundedYear;
  final String? logoUrl;

  Club({
    required this.id,
    required this.name,
    required this.slug,
    this.stadium,
    this.league,
    this.foundedYear,
    this.logoUrl,
  });

  factory Club.fromJson(Map<String, dynamic> json) {
    return Club(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      stadium: json['stadium'],
      league: json['league'],
      foundedYear: json['founded_year'],
      logoUrl: json['logo_url'],
    );
  }
}
