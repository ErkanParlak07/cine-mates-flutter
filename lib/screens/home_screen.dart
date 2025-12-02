// lib/screens/home_screen.dart

import 'package:film_kesif/screens/movie_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart'; // Resim yüklenirken boşluk göstermek için
import '../providers/movie_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  @override
  void initState() {
    super.initState();
    // Sayfa ilk açıldığında verileri çekmeye başla
    // initState içinde context kullanırken "Future.microtask" güvenlidir.
    Future.microtask(() => 
      Provider.of<MovieProvider>(context, listen: false).loadPopularMovies()
    );
  }

  @override
  Widget build(BuildContext context) {
    // UI güncellemelerini dinlemek için Consumer kullanıyoruz
    return Scaffold(
      appBar: AppBar(
        title: const Text("Popüler Filmler 🔥"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Consumer<MovieProvider>(
        builder: (context, provider, child) {
          // 1. DURUM: Yükleniyor
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator(color: Colors.red));
          }

          // 2. DURUM: Hata var
          if (provider.errorMessage != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 60, color: Colors.red),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(provider.errorMessage!, textAlign: TextAlign.center),
                  ),
                  ElevatedButton(
                    onPressed: () => provider.loadPopularMovies(),
                    child: const Text("Tekrar Dene"),
                  )
                ],
              ),
            );
          }

          // 3. DURUM: Veri geldi (Success)
          return GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Yan yana 2 film
              childAspectRatio: 0.7, // Dikdörtgen poster oranı
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: provider.movies.length,
            itemBuilder: (context, index) {
              final movie = provider.movies[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MovieDetailScreen(movie: movie), // Veriyi postalıyoruz
                    ),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: GridTile(
                    footer: GridTileBar(
                      backgroundColor: Colors.black54,
                      title: Text(movie.title, textAlign: TextAlign.center),
                      trailing: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(5)
                        ),
                        child: Text(
                          movie.voteAverage.toStringAsFixed(1),
                          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    // FadeInImage: Resim yüklenene kadar şeffaf durur, yüklenince yumuşakça gelir.
                    child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: movie.fullImageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}