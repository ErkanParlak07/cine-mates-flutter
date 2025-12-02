// lib/main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart'; // Font paketi
import 'providers/movie_provider.dart';
import 'screens/home_screen.dart'; // Birazdan oluşturacağız

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MovieProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'CineMates',
        theme: ThemeData.dark().copyWith( // Koyu tema (Dark Mode) olsun 🌑
          scaffoldBackgroundColor: const Color(0xFF121212),
          textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme), // Modern font
        ),
        home: const HomeScreen(),
      ),
    );
  }
}