import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class GoogleShowMap extends StatefulWidget {
  const GoogleShowMap({super.key});

  @override
  State<GoogleShowMap> createState() => _GoogleShowMapState();
}

class _GoogleShowMapState extends State<GoogleShowMap> {
  @override
  Widget build(BuildContext context) {
    late GoogleMapController mapController;
    
    final LatLng center = const LatLng(-28, 24);

    void onMapCreated(GoogleMapController controller) {
      mapController = controller;
    }

    return GoogleMap(
            onMapCreated: onMapCreated,
            initialCameraPosition: CameraPosition(
              target: center,
              zoom: 5.8,
            ));
  }
}