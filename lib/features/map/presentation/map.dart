import 'dart:convert';

import 'package:salvation/features/appbar.dart';
import 'package:salvation/features/map/presentation/google_map.dart';
import 'package:salvation/features/navbar.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;


class ChurchMap extends StatefulWidget {
  const ChurchMap({super.key});

  @override
  State<ChurchMap> createState() => _ChurchMapState();
}

class _ChurchMapState extends State<ChurchMap> {
  late GoogleMapController mapController;
  final searchController = SearchController();

  int _currentIndex = 1;

  List<Map> results = [];
  
   get selectedText => null;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      List routes = ['/home', '/map', '/diary', '/verse'];

      Navigator.of(context, rootNavigator: true).pushNamed(routes[index]);
    });
  }

  Future<void> PlacesSearch(String query) async {
    results.clear();
    print('query = ' + query);
    String apiKey = "AIzaSyA__TXPjWnJHmL67G2xeqtwEyB61birpMU";
    String types = "church";
    String region = "za";

    Uri uri = Uri.https("maps.googleapis.com",
      'maps/api/place/autocomplete/json',
      {
        "input": query,
        "key": apiKey,
        "types": types,
        "region": region
      }
    );

    String? response = await fetchUrl(uri);
    

    if (response != null) {
      var decoded_json = jsonDecode(response);
      List predictions = decoded_json["predictions"];
      predictions.forEach((element) { 
        
        results.add(element);
      });
      // print(predictions);
    }
    print(results);
  }

  Future<String?> fetchUrl(Uri uri, {Map<String, String>? headers}) async {
        try {
          final response = await http.get(uri);
          if (response.statusCode == 200) {
            return response.body;
          }
        } catch (e) {
          debugPrint(e.toString());
        }
        return null;
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
          SearchAnchor(builder: (BuildContext context, SearchController controller) {
            return SearchBar(
              
              controller: controller,
                leading: Icon(Icons.search),
                backgroundColor: MaterialStateColor.resolveWith((states) {
                  return Colors.transparent;
                  }),
                  elevation: MaterialStateProperty.resolveWith((states) => 0.0),
              onChanged: (_) {
                setState(() {
                controller.openView();});
                },
              // onTap: () {controller.openView();},
            );
          }, suggestionsBuilder: 
                  (BuildContext context, SearchController controller) async {
                    await PlacesSearch(controller.text);

                    return List<ListTile>.generate(5, (int index) {

                    final String item = results.isNotEmpty ? results.elementAt(index)["description"] : "";
                    print(item);
                    return ListTile(
                      title: Text(item),
                      onTap: () {
                        setState(() {
                          controller.closeView(item);
                        });
                      },
                    );
                  });
          }),
          SizedBox(
            width: MediaQuery.of(context).size.width,  // or use fixed size like 200
            height: MediaQuery.of(context).size.height /2.5,
            child: GoogleShowMap()),
          FloatingActionButton(onPressed:(){
            print(searchController.text + " church");
            }),
        ])
          

        );
  }
}
