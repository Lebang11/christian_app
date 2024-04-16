import 'package:salvation/features/appbar.dart';
import 'package:salvation/features/map/presentation/google_map.dart';
import 'package:salvation/features/navbar.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';



class ChurchMap extends StatefulWidget {
  const ChurchMap({super.key});

  @override
  State<ChurchMap> createState() => _ChurchMapState();
}

class _ChurchMapState extends State<ChurchMap> {
  late GoogleMapController mapController;


  int _currentIndex = 1;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      List routes = ['/home', '/map', '/diary', '/verse'];

      Navigator.of(context, rootNavigator: true).pushNamed(routes[index]);
    });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          title: Text(
              'Map',
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
        body: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: "Search church here",
              labelStyle: TextStyle(
                color: Colors.white,
                fontSize: 20.0
              )
            ),
          ),
        SizedBox(
          width: MediaQuery.of(context).size.width,  // or use fixed size like 200
          height: MediaQuery.of(context).size.height /2,
          child: GoogleShowMap())
        ])
          

        );
  }
}
