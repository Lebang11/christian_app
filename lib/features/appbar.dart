import 'package:flutter/material.dart';

PreferredSizeWidget appbar(BuildContext context) {
  return AppBar(
    actions: [
      PopupMenuButton(
          icon: const Padding(
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 15.0, 0.0),
            child: Icon(
              Icons.menu,
              size: 50.0,
              color: Color.fromARGB(255, 220, 220, 220),
            ),
          ),
          itemBuilder: (context) {
            return [
              const PopupMenuItem<int>(
                value: 0,
                child: Text("My Account"),
              ),
              const PopupMenuItem<int>(
                value: 0,
                child: Text("Church Map"),
              ),
              const PopupMenuItem<int>(
                value: 0,
                child: Text("Diary"),
              ),
              const PopupMenuItem<int>(
                value: 0,
                child: Text("Verse of the day"),
              )
            ];
          })
    ],
    toolbarHeight: 90.0,
    leading: Padding(
      padding: const EdgeInsets.fromLTRB(30.0, 0.0, 0.0, 0.0),
      child: Image.asset('assets/logo/logo-no-background.png'),
    ),
    leadingWidth: 240.0,
    shape: const Border(
        bottom:
            BorderSide(color: Color.fromARGB(255, 220, 220, 220), width: 3)),
    // TRY THIS: Try changing the color here to a specific color (to
    // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
    // change color while the other colors stay the same.
    backgroundColor: const Color.fromARGB(255, 40, 38, 52),
    // Here we take the value from the MyHomePage object that was created by
    // the App.build method, and use it to set our appbar title.
  );
}
