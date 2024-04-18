import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:salvation/features/diary/data/diary.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class GoogleShowMap extends StatefulWidget {
  LatLng center;
  List<Map> closeChurches;
  GoogleShowMap( {required this.center, super.key, required this.closeChurches}) {
    this.center = center;
  }

  @override
  State<GoogleShowMap> createState() => _GoogleShowMapState(this.center, this.closeChurches);
}

class _GoogleShowMapState extends State<GoogleShowMap> {
  bool Loaded = false;
  late LatLng center;
  late List<Map> closeChurches;

  _GoogleShowMapState(LatLng center, List<Map> closeChurches) {
    this.center = center;
    this.closeChurches = closeChurches;
  }
  
  @override
  void didUpdateWidget(covariant GoogleShowMap oldWidget) {
    print("didUpdate was called");
    
    setState(() {
      
    this.center = widget.center;

    });

    print("New center: " + widget.center.toString());
    Loaded = true;

    super.didUpdateWidget(oldWidget);



   }

  
  
  @override
  Widget build(BuildContext context) {
    late GoogleMapController mapController;
    
    void onMapCreated(GoogleMapController controller) {
      mapController = controller;
    }

    
    Set<Marker> markers = {Marker(icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),markerId: MarkerId("Here"), infoWindow: InfoWindow(snippet: "You are here"), position: this.center),};

    if (!Loaded) {
      return SpinKitCircle(
        color: Colors.blueAccent,
      );
    }
    return GoogleMap(
            onMapCreated: onMapCreated,
            initialCameraPosition: CameraPosition(
              target: this.center,
              zoom: 12.0,
            ),
            markers: markers,
            );
  }
}