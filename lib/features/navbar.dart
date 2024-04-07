import 'package:flutter/material.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';

class navbar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  navbar({required this.currentIndex, required this.onTap});
  @override
  Widget build(BuildContext context) {
    // return BottomNavigationBar(
    //   elevation: 0.0,
    //   type: BottomNavigationBarType.fixed,
    //   selectedItemColor: Colors.black,
    //   backgroundColor: Colors.white,
    //   items: const <BottomNavigationBarItem>[
    //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    //     BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map'),
    //     BottomNavigationBarItem(icon: Icon(Icons.edit), label: 'Diary'),
    //     BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Verse'),
    //   ],
    //   currentIndex: currentIndex,
    //   onTap: onTap,
    // );
    return DotNavigationBar(
      margin: EdgeInsets.only(left: 10, right: 10),
      currentIndex: currentIndex,
      dotIndicatorColor: Colors.white,
      unselectedItemColor: Colors.grey[300],
      splashBorderRadius: 50,
      enableFloatingNavBar: true,
      enablePaddingAnimation: true,
      onTap: onTap,
      marginR: EdgeInsets.symmetric(horizontal: 40, vertical: 0),
      itemPadding: EdgeInsets.symmetric(vertical: 7, horizontal: 8),
      items: [
        /// Home
        DotNavigationBarItem(
          icon: Icon(Icons.home),
          selectedColor: Colors.black,
        ),

        /// Likes
        DotNavigationBarItem(
          icon: Icon(Icons.map),
          selectedColor: Colors.black,
        ),

        /// Search
        DotNavigationBarItem(
          icon: Icon(Icons.edit),
          selectedColor: Colors.black,
        ),

        /// Profile
        DotNavigationBarItem(
          icon: Icon(Icons.book),
          selectedColor: Colors.black,
        ),
      ],
    );
  }
}
