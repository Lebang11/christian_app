import 'package:christian_app/features/appbar.dart';
import 'package:christian_app/features/navbar.dart';
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
      appBar: appbar(context),
      bottomNavigationBar: navbar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}
