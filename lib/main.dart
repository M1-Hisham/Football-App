import 'package:flutter/material.dart';

import 'screens/auth/login.dart';
import 'screens/profile.dart';
import 'screens/random.dart';
import 'screens/home.dart';
import 'screens/details.dart';
import 'screens/auth/register.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Football Finder',
      initialRoute: '/register',
      debugShowCheckedModeBanner: false,
      theme: themeData(),
      routes: {
        '/register': (context) => Register(),
        '/login': (context) => const Login(),
        '/home': (context) => const Home(),
        '/details': (context) => const Details(),
        '/random': (context) => const Random(),
        '/profile': (context) => const Profile(),
      },
    );
  }

  ThemeData themeData() {
    return ThemeData(
      colorScheme: ThemeData().colorScheme.copyWith(
            primary: const Color.fromARGB(255, 38, 164, 45),
          ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 38, 164, 45),
          foregroundColor: Colors.white,
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        labelStyle: TextStyle(color: Colors.black),
      ),
    );
  }
}
