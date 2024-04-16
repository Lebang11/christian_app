import 'package:salvation/features/account.dart';
import 'package:salvation/features/diary/presentation/diary.dart';
import 'package:salvation/features/map/presentation/map.dart';
import 'package:salvation/features/verse.dart';
import 'package:flutter/material.dart';
import 'package:salvation/features/diary/data/diary_database.dart';
import 'package:salvation/features/home.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:salvation/theme/dark-theme.dart';
import 'package:salvation/theme/light-theme.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DiaryDatabase.initialize()
      .then((value) => print('Initialized local db'))
      .catchError((err) => print('Error: $err'));

  runApp(ChangeNotifierProvider(
      create: (context) => DiaryDatabase(),
      child: MaterialApp(
        theme: darkMode,
        debugShowCheckedModeBanner: false,
        //To view your route, flutter run and click the button with your route name
        initialRoute: '/home',
        routes: {
          // '/': (context) => const Loading(),
          '/home': (context) => const Home(title: 'Home',),
          '/map': (context) => const ChurchMap(),
          '/diary': (context) => const Diary(),
          '/verse': (context) => const Verse(),
          '/account': (context) => const Account()
        },
      )));
}
