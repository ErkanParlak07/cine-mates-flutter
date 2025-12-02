// lib/services/api_service.dart

import 'package:dio/dio.dart';
import 'package:flutter/rendering.dart';
import '../core/constants.dart';
import '../models/movie.dart';

class ApiService {
  final Dio _dio = Dio();

  // Popüler filmleri çeken fonksiyon
  Future<List<Movie>> getPopularMovies() async {
    try {
      // 1. İsteği hazırla
      final response = await _dio.get(
        '${Constants.baseUrl}/movie/popular',
        queryParameters: {
          'api_key': Constants.apiKey,
          'language': 'tr-TR', // Türkçe veri isteyelim 🇹🇷
          'page': 1,
        },
      );

      // 2. Cevap başarılı mı? (200 OK)
      if (response.statusCode == 200) {
        // Gelen JSON'ın içindeki 'results' listesini al
        final List results = response.data['results'];
        
        // O listeyi tek tek Movie objesine çevir (Map işlemi)
        return results.map((json) => Movie.fromJson(json)).toList();
      } else {
        throw Exception('Veri yüklenemedi');
      }
    } catch (e) {
      // Hata olursa konsola yaz (Debug için)
      debugPrint('Hata çıktı: $e');
      rethrow; // Hatayı UI katmanına fırlat ki orada gösterelim
    }
  }
}