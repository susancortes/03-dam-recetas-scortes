import 'package:flutter/material.dart';

import 'screens/splash_screen.dart';

const _aqua = Color(0xFF4BC8C2);
const _turquesa = Color(0xFF007F79);
const _rosado = Color(0xFFC8497B);
const _fondo = Color(0xFFF4FAF9);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recetas App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: _turquesa).copyWith(
          primary: _turquesa,
          onPrimary: Colors.white,
          secondary: _aqua,
          onSecondary: const Color(0xFF003F3C),
          tertiary: _rosado,
          onTertiary: Colors.white,
          surface: _fondo,
          primaryContainer: const Color(0xFFD1F2EF),
          onPrimaryContainer: const Color(0xFF004D48),
          secondaryContainer: const Color(0xFFFFE3ED),
          onSecondaryContainer: const Color(0xFF5C1732),
        ),
        scaffoldBackgroundColor: _fondo,
        appBarTheme: const AppBarTheme(
          backgroundColor: _turquesa,
          foregroundColor: Colors.white,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: _rosado, width: 2),
          ),
          floatingLabelStyle: TextStyle(color: _rosado),
        ),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: _rosado,
        ),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
