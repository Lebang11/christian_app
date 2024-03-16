import 'package:christian_app/features/appbar.dart';
import 'package:christian_app/features/navbar.dart';
import 'package:flutter/material.dart';

class Diary extends StatefulWidget {
  const Diary({super.key});

  @override
  State<Diary> createState() => _DiaryState();
}

class _DiaryState extends State<Diary> {
  int _currentIndex = 2;

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
      body: Center(
        child: Column(
          children: [
            Text(
              'Diary',
              style: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Colors.blueAccent,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.blueAccent),
            )
          ],
        ),
      ),
    );
  }
}
