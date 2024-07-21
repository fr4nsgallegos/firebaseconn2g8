import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPageMarkerCustom extends StatefulWidget {
  @override
  State<MapPageMarkerCustom> createState() => _MapPageMarkerCustomState();
}

class _MapPageMarkerCustomState extends State<MapPageMarkerCustom> {
  Set<Marker> _markers = {};
  CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();

  addMarkers() async {
    Set<Marker> auxMarkers = Set();
    LatLng pos1 = LatLng(-12.043623, -76.965636);
    BitmapDescriptor designBit1 = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(94, 94)), "assets/images/orange.png");

    auxMarkers.add(
      Marker(
          markerId: MarkerId("1"),
          position: pos1,
          icon: designBit1,
          onTap: () {
            _customInfoWindowController.addInfoWindow!(
                Container(
                  width: 200,
                  height: 300,
                  color: Colors.black,
                ),
                pos1);
          }),
    );

    _markers = auxMarkers;
    setState(() {});
  }

  @override
  void initState() {
    addMarkers();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Map with custom marker"),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(-12.051106645118788, -76.9591172953207),
              zoom: 16,
            ),
            markers: _markers,
            onTap: (position) {
              _customInfoWindowController.hideInfoWindow!();
            },
            onCameraMove: (position) {
              _customInfoWindowController.onCameraMove!();
            },
          ),
          CustomInfoWindow(
            controller: _customInfoWindowController,
            width: 200,
            height: 100,
            offset: 60,
          )
        ],
      ),
    );
  }
}
