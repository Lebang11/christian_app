import 'package:christian_app/features/account.dart';
import 'package:christian_app/features/diary.dart';
import 'package:christian_app/features/map.dart';
import 'package:christian_app/features/verse.dart';
import 'package:flutter/material.dart';
import 'package:christian_app/features/home.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    //To view your route, flutter run and click the button with your route name
    initialRoute: '/home',
    onGenerateRoute: (settings) {
      print(settings.name);
    },
    routes: {
      // '/': (context) => const Loading(),
      '/home': (context) => const Home(),
      '/map': (context) => const ChurchMap(),
      '/diary': (context) => const Diary(),
      '/verse': (context) => const Verse(),
      '/account': (context) => const Account()
    },
  ));
}
