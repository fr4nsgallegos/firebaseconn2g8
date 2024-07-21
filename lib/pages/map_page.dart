import 'package:firebaseconn2g8/pages/utils/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';

class MapPage extends StatefulWidget {
  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Logger _logger = Logger();

  Set<Marker> _markers = {};
  final _mapController = HomeController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        onMapCreated: _mapController.onMapCreated,
        initialCameraPosition: CameraPosition(
          target: LatLng(-12.051106645118788, -76.9591172953207),
          zoom: 15,
        ),
        onTap: (LatLng position) {
          // print(position);
          _logger.d(position);
          _markers.add(
            Marker(
              markerId: MarkerId(_markers.length.toString()),
              position: position,
            ),
          );
          setState(() {});
        },
        markers: _markers,
        // markers: {
        //   Marker(
        //     markerId: MarkerId("firstMarker"),
        //     position: LatLng(-12.051106645118788, -76.9591172953207),
        //   ),
        // },
      ),
    );
  }
}
