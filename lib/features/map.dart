import 'package:salvation/features/appbar.dart';
import 'package:salvation/features/navbar.dart';
import 'package:flutter/material.dart';

class ChurchMap extends StatefulWidget {
  const ChurchMap({super.key});

  @override
  State<ChurchMap> createState() => _ChurchMapState();
}

class _ChurchMapState extends State<ChurchMap> {
  int _currentIndex = 1;

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
        appBar: appbar(context),
        bottomNavigationBar: navbar(
          currentIndex: _currentIndex,
          onTap: _onTabTapped,
        ),
        body: Column(children: [
          Center(
            child: Text(
              'Map',
              style: TextStyle(
                  fontFamily: 'Lobster',
                  fontSize: 40.0,
                  color: const Color.fromARGB(255, 222, 222, 222)),
            ),
          )
        ]));
  }
}
