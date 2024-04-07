import 'package:flutter/material.dart';
import 'package:draggable_home/draggable_home.dart';

PreferredSizeWidget appbar(BuildContext context) {
  return AppBar(
    // actions: [
    //   PopupMenuButton(
    //       icon: const Padding(
    //         padding: EdgeInsets.fromLTRB(0.0, 0.0, 15.0, 0.0),
    //         child: Icon(
    //           Icons.menu,
    //           size: 50.0,
    //           color: Color.fromARGB(255, 220, 220, 220),
    //         ),
    //       ),
    //       itemBuilder: (context) {
    //         return [
    //           const PopupMenuItem<int>(
    //             value: 0,
    //             child: Text("My Account"),
    //           ),
    //           const PopupMenuItem<int>(
    //             value: 0,
    //             child: Text("Church Map"),
    //           ),
    //           const PopupMenuItem<int>(
    //             value: 0,
    //             child: Text("Diary"),
    //           ),
    //           const PopupMenuItem<int>(
    //             value: 0,
    //             child: Text("Verse of the day"),
    //           )
    //         ];
    //       })
    // ],
    toolbarHeight: 90.0,
    leadingWidth: 240.0,
    centerTitle: true,
    title: Image.asset(
      'assets/logo/logo-no-background.png',
      width: 250.0,
    ),
    // shape: const Border(
    //     bottom:
    //         BorderSide(color: Color.fromARGB(255, 220, 220, 220), width: 3)),
    // TRY THIS: Try changing the color here to a specific color (to
    // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
    // change color while the other colors stay the same.
    backgroundColor: Color.fromARGB(255, 0, 0, 0),
    // Here we take the value from the MyHomePage object that was created by
    // the App.build method, and use it to set our appbar title.
  );
}
