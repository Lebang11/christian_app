import 'package:flutter/material.dart';

class navbar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  navbar({required this.currentIndex, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 0.0,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: const Color.fromARGB(255, 40, 38, 52),
      backgroundColor: const Color.fromARGB(255, 220, 220, 220),
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map'),
        BottomNavigationBarItem(icon: Icon(Icons.edit), label: 'Diary'),
        BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Verse'),
      ],
      currentIndex: currentIndex,
      onTap: onTap,
    );
  }
}
