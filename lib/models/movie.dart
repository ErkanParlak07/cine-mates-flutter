

import '../core/constants.dart';

class Movie {
  final int id;
  final String title;
  final String? posterPath; // Bazen resim olmayabilir, o yüzden ? koyduk
  final double voteAverage;
  final String overview;

  Movie({
    required this.id,
    required this.title,
    this.posterPath,
    required this.voteAverage,
    required this.overview,
  });

  // 1. JSON verisini alıp Dart objesine çeviren "Fabrika" metodu
  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'] ?? 'İsimsiz Film', // Eğer null gelirse varsayılan metin
      posterPath: json['poster_path'], 
      // API bazen tam sayı (7), bazen ondalıklı (7.5) yollayabilir.
      // toDouble() diyerek garantiye alıyoruz.
      voteAverage: (json['vote_average'] as num).toDouble(),
      overview: json['overview'] ?? '',
    );
  }

  // 2. Resmin tam linkini oluşturan yardımcı bir özellik (Getter)
  String get fullImageUrl {
    if (posterPath == null) return 'https://via.placeholder.com/500x750'; // Resim yoksa
    return '${Constants.imageBaseUrl}$posterPath';
  }
}