import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';


class GoogleShowMap extends StatefulWidget {
  const GoogleShowMap({super.key});

  @override
  State<GoogleShowMap> createState() => _GoogleShowMapState();
}

class _GoogleShowMapState extends State<GoogleShowMap> {
  @override
  Widget build(BuildContext context) {
    late GoogleMapController mapController;
    
    LatLng center = const LatLng(-28, 24);

    void onMapCreated(GoogleMapController controller) {
      mapController = controller;
    }

    void setLocation(LatLng newCenter) {
      center = newCenter;
    }

    
    Set<Marker> markers = {Marker(markerId: MarkerId("Here"), position: LatLng(-28, 24)),};

    return GoogleMap(
            onMapCreated: onMapCreated,
            initialCameraPosition: CameraPosition(
              target: center,
              zoom: 5.8,
            ),
            markers: markers,
            );
  }
}