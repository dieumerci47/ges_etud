import 'package:flutter/material.dart';
import 'package:ges_etud/aimation/loading.dart';
// import 'package:ges_etud/pages/home_page.dart';
// import 'package:ges_etud/pages/onboarding_page.dart';

const d_blue = Color(0xFF1A2B6D);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestion des Etudiants',
      debugShowCheckedModeBanner: false,
      home: LoadingPage(),
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.bl),
        /*         primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: const Color.fromARGB(255, 228, 231, 233), */
      ),
    );
  }
}
