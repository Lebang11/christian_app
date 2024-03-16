import 'package:christian_app/features/account.dart';
import 'package:christian_app/features/diary/presentation/diary.dart';
import 'package:christian_app/features/map.dart';
import 'package:christian_app/features/verse.dart';
import 'package:flutter/material.dart';
import 'package:christian_app/features/diary/data/diary_database.dart';
import 'package:christian_app/features/home.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DiaryDatabase.initialize()
      .then((value) => print('Initialized local db'))
      .catchError((err) => print('Error: $err'));

  runApp(ChangeNotifierProvider(
      create: (context) => DiaryDatabase(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        //To view your route, flutter run and click the button with your route name
        initialRoute: '/home',
        routes: {
          // '/': (context) => const Loading(),
          '/home': (context) => const Home(),
          '/map': (context) => const ChurchMap(),
          '/diary': (context) => const Diary(),
          '/verse': (context) => const Verse(),
          '/account': (context) => const Account()
        },
      )));
}
