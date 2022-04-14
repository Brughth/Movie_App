import 'dart:convert';

class TVPopularModel {
  String backdropPath;
  String firstAirDate;
  List<int> genreIds;
  int id;
  String name;
  List<String> originCountry;
  String originalLanguage;
  String originalName;
  String overview;
  double popularity;
  String posterPath;
  double voteArage;
  int voteCount;

  TVPopularModel({
    required this.backdropPath,
    required this.firstAirDate,
    required this.genreIds,
    required this.id,
    required this.name,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.voteArage,
    required this.voteCount,
  });

  Map<String, dynamic> toMap() {
    return {
      'backdropPath': backdropPath,
      'firstAirDate': firstAirDate,
      'genreIds': genreIds,
      'id': id,
      'name': name,
      'originCountry': originCountry,
      'originalLanguage': originalLanguage,
      'originalName': originalName,
      'overview': overview,
      'popularity': popularity,
      'posterPath': posterPath,
      'voteArage': voteArage,
      'voteCount': voteCount,
    };
  }

  factory TVPopularModel.fromMap(Map<String, dynamic> map) {
    return TVPopularModel(
      backdropPath: map['backdrop_path'] ?? '',
      firstAirDate: map['first_air_date'] ?? '',
      genreIds: List<int>.from(map['genre_ids']),
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      originCountry: List<String>.from(map['origin_country']),
      originalLanguage: map['original_language'] ?? '',
      originalName: map['original_name'] ?? '',
      overview: map['overview'] ?? '',
      popularity: map['popularity']?.toDouble() ?? 0.0,
      posterPath: map['poster_path'] ?? '',
      voteArage: map['vote_average']?.toDouble() ?? 0.0,
      voteCount: map['vote_count']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory TVPopularModel.fromJson(String source) =>
      TVPopularModel.fromMap(json.decode(source));
}
