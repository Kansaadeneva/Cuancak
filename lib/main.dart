import 'package:flutter/material.dart';
import 'constants/colors.dart';
import 'constants/strings.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const CuancakApp());
}

class CuancakApp extends StatelessWidget {
  const CuancakApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: CuancakStrings.appName,
      theme: ThemeData(
        primaryColor: CuancakColors.primaryBlue,
        scaffoldBackgroundColor: CuancakColors.backgroundWhite,
        appBarTheme: const AppBarTheme(
          backgroundColor: CuancakColors.primaryBlue,
          foregroundColor: CuancakColors.backgroundWhite,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
