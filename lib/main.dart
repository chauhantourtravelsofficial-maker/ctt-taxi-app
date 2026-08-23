// main.dart
import 'package:flutter/material.dart';

// हमने अपनी दूसरी फाइल को यहाँ जोड़ (import) लिया है!
import 'splash_screen.dart'; 
import 'login_screen.dart';
import 'dashboard.dart';
import 'database.dart';

void main() {
  runApp(const CTTTaxiApp());
}

class CTTTaxiApp extends StatelessWidget {
  const CTTTaxiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CTT Taxi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFFFFB100),
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFFB100)),
        useMaterial3: true,
      ),
      // ऐप शुरू होते ही सीधा splash_screen.dart वाली फाइल पर चली जाएगी
      home: const SplashScreen(), 
    );
  }
}