import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parks/util/app_colors.dart';
import 'package:parks/util/back_widget.dart';

class MapPage extends StatefulWidget {
  MapPage({required this.latitude, required this.longitude});
  final double latitude;
  final double longitude;

  @override
  _MapPageState createState() => _MapPageState(latitude, longitude);
}

class _MapPageState extends State<MapPage> {
  final double latitude;
  final double longitude;
  _MapPageState(this.latitude, this.longitude);

  late GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        GoogleMap(
          myLocationEnabled: true,
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
              target: LatLng(latitude, longitude),
              zoom: 18.0,
              tilt: 0,
              bearing: 0),
          markers: _createMarker(latitude, longitude),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: AppColors.primaryTextColor,
              ),
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
              },
            ),
          ),
        ),
      ],
    ));
  }

  Set<Marker> _createMarker(double latitude, double longitude) {
    return {
      Marker(
        markerId: MarkerId("marker_1"),
        position: LatLng(latitude, longitude),
        infoWindow: InfoWindow(title: 'Marker 1'),
      ),
    };
  }
}
