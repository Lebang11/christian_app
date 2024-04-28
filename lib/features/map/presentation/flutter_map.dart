import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:latlong2/latlong.dart' as LatLng2;
import 'package:salvation/utilities/network.dart';
import 'package:geolocator/geolocator.dart';

class FlutterShowMap extends StatefulWidget {
  final LatLng center;
  const FlutterShowMap({super.key, required this.center});

  @override
  State<FlutterShowMap> createState() => _FlutterShowMapState(this.center);
}

class _FlutterShowMapState extends State<FlutterShowMap> {
  final LatLng center;
  _FlutterShowMapState(this.center);

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        initialCenter:
            LatLng2.LatLng(this.center.latitude, this.center.longitude),
        initialZoom: 14.0,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.app',
        ),
        RichAttributionWidget(
          attributions: [
            TextSourceAttribution('OpenStreetMap contributors',
                onTap: () => Network().fetchUrl(
                    Uri.parse('https://openstreetmap.org/copyright'))),
          ],
        ),
      ],
    );
    ;
  }
}
