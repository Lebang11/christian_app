import 'dart:async';
import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:salvation/features/appbar.dart';
import 'package:salvation/features/map/presentation/flutter_map.dart';
import 'package:salvation/features/map/presentation/google_map.dart';
import 'package:salvation/features/navbar.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';

class ChurchMap extends StatefulWidget {
  const ChurchMap({super.key});

  @override
  State<ChurchMap> createState() => _ChurchMapState();
}

class _ChurchMapState extends State<ChurchMap> {
  late GoogleMapController mapController;
  final searchController = SearchController();
  late bool foundPosition;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.foundPosition = false;
  }

  late Position? position;
  late String? userLat;
  late String? userLong;
  late LatLng? newCenter;

  int _currentIndex = 1;

  List<Map> results = [];
  List<Map> closeChurches = [];

  GoogleShowMap GoogleMapView = GoogleShowMap(
    center: LatLng(-28, 24),
    closeChurches: [],
  );

  late FlutterShowMap FlutterMapView;

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

    Uri uri = Uri.https(
        "maps.googleapis.com",
        'maps/api/place/autocomplete/json',
        {"input": query, "key": apiKey, "types": types, "region": region});

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

  Future<void> ClosePlacesSearch(String location) async {
    closeChurches.clear();
    print('location = ' + location);
    String apiKey = "AIzaSyA__TXPjWnJHmL67G2xeqtwEyB61birpMU";
    String types = "church";
    String region = "za";

    Uri uri = Uri.https(
        "maps.googleapis.com", 'maps/api/place/nearbysearch/json', {
      "location": location,
      "key": apiKey,
      "types": types,
      "radius": "10000"
    });

    String? response = await fetchUrl(uri);

    if (response != null) {
      var decoded_json = jsonDecode(response);
      List closeResults = decoded_json["results"];
      closeResults.forEach((element) {
        closeChurches.add(element);
      });
    }

    // print("Search results: " + results.toString());
    // print("Close churches: " + closeChurches.toString());
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

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;
    print('Getting Location permission');
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<Position?> userPosition() async {
    print("Getting user location");

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    return position;
  }

  Future<Position?> getLocation(BuildContext context) async {
    await _handleLocationPermission();
    this.position = await userPosition();
    this.userLat = this.position!.latitude.toString();
    this.userLong = this.position!.longitude.toString();
    this.newCenter = LatLng(this.position!.latitude, this.position!.longitude);
    print("found User permission: ($userLat, $userLong)");
    // await ClosePlacesSearch("$userLat,$userLong");
    setState(() {
      // GoogleMapView = GoogleShowMap(
      //   center: LatLng(this.position!.latitude, this.position!.longitude),
      //   closeChurches: this.closeChurches,
      // );
      this.foundPosition = true;
      FlutterMapView = FlutterShowMap(
        center: LatLng(this.position!.latitude, this.position!.longitude),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_element
    if (!this.foundPosition) {
      getLocation(context);
    }
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
        body: SingleChildScrollView(
          child: Column(children: [
            SearchAnchor(
                builder: (BuildContext context, SearchController controller) {
              return SearchBar(
                controller: controller,
                leading: Icon(Icons.search),
                backgroundColor: MaterialStateColor.resolveWith((states) {
                  return Colors.transparent;
                }),
                elevation: MaterialStateProperty.resolveWith((states) => 0.0),
                onChanged: (_) {
                  setState(() {
                    controller.openView();
                  });
                },
                // onTap: () {controller.openView();},
              );
            }, suggestionsBuilder:
                    (BuildContext context, SearchController controller) async {
              await PlacesSearch(controller.text);

              return List<ListTile>.generate(5, (int index) {
                final String item = results.isNotEmpty
                    ? results.elementAt(index)["description"]
                    : "";
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
                width: MediaQuery.of(context)
                    .size
                    .width, // or use fixed size like 200
                height: MediaQuery.of(context).size.height / 2.5,
                child: foundPosition
                    ? FlutterMapView
                    : SpinKitCircle(
                        color: Colors.blueAccent,
                      )),
            Text(
              'Closest churches',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(
              width: MediaQuery.of(context)
                  .size
                  .width, // or use fixed size like 200
              height: MediaQuery.of(context).size.height / 3,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: ListView.separated(
                    itemBuilder: (BuildContext context, int index) {
                      final String churchName = closeChurches.isNotEmpty
                          ? closeChurches.elementAt(index)["name"]
                          : "";
                      final String churchVicinity = closeChurches.isNotEmpty
                          ? closeChurches.elementAt(index)["vicinity"]
                          : "";
                      return Text(churchName + " ~ " + churchVicinity);
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(),
                    itemCount:
                        closeChurches.length < 11 ? closeChurches.length : 10),
              ),
            )
          ]),
        ));
  }
}
