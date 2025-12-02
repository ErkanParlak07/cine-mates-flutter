

import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../services/api_service.dart';

class MovieProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  // Durum değişkenlerimiz
  List<Movie> _movies = [];
  bool _isLoading = false;
  String? _errorMessage; // Hata varsa buraya mesaj gelecek

  // Dışarıdan okumak için getter'lar
  List<Movie> get movies => _movies;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Filmleri çeken fonksiyon
  Future<void> loadPopularMovies() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners(); // Ekrana "Yükleniyor..." göster der.

    try {
      _movies = await _apiService.getPopularMovies();
    } catch (e) {
      _errorMessage = "Filmler yüklenirken bir hata oluştu: $e";
    } finally {
      // Hata olsa da olmasa da yükleme bitti
      _isLoading = false;
      notifyListeners(); // Ekrana sonucu göster der.
    }
  }
}