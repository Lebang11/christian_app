import 'package:salvation/features/appbar.dart';
import 'package:salvation/features/navbar.dart';
import 'package:flutter/material.dart';

class Verse extends StatefulWidget {
  const Verse({super.key});

  @override
  State<Verse> createState() => _VerseState();
}

class _VerseState extends State<Verse> {
  int _currentIndex = 3;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      List routes = ['/home', '/map', '/diary', '/verse'];

      Navigator.of(context, rootNavigator: true).popAndPushNamed(routes[index]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          title: Text(
              'Verse of the day',
              style: TextStyle(
                  fontFamily: 'Lobster',
                  fontSize: 40.0,
                  color: const Color.fromARGB(255, 222, 222, 222)),
            ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
        ),
        bottomNavigationBar: navbar(
          currentIndex: _currentIndex,
          onTap: _onTabTapped,
        ),
        body: Column(children: [
          
        ]));
  }
}
