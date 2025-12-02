// lib/screens/movie_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/movie.dart';

class MovieDetailScreen extends StatelessWidget {
  final Movie movie;

  const MovieDetailScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // 1. KISIM: Esneyen Başlık (Resimli Alan)
          SliverAppBar(
            expandedHeight: 400, // Açıkken ne kadar yüksek olsun?
            pinned: true, // Yukarı kaydırınca tavan yapışsın mı? Evet.
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                movie.title,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [const Shadow(color: Colors.black, blurRadius: 10)], // Yazı okunsun diye gölge
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Arka plandaki büyük resim
                  Image.network(
                    movie.fullImageUrl,
                    fit: BoxFit.cover,
                  ),
                  // Resmin üzerine hafif siyah perde çekelim ki yazı okunsun
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black87],
                        stops: [0.6, 1.0], // Siyahlık sadece altta olsun
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 2. KISIM: İçerik (SliverList)
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Puan ve Vizyon Bilgisi Satırı
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 24),
                          const SizedBox(width: 5),
                          Text(
                            "${movie.voteAverage.toStringAsFixed(1)} / 10",
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      
                      const Text(
                        "Özet",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.amber),
                      ),
                      const SizedBox(height: 10),
                      
                      Text(
                        movie.overview.isEmpty ? "Bu film için özet bulunamadı." : movie.overview,
                        style: const TextStyle(fontSize: 16, height: 1.5, color: Colors.white70),
                      ),
                      
                      const SizedBox(height: 30),
                      
                      // Rastgele bir buton (Görsellik olsun diye)
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {}, 
                          icon: const Icon(Icons.play_arrow),
                          label: const Text("Fragmanı İzle"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}