import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// Make sure to store the following in .env file at root of project : API_KEY=your_api_key

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MapSample(),
    );
  }
}

class MapSample extends StatefulWidget {
  const MapSample({Key? key}) : super(key: key);

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  // Default Location when app is opened
  static const CameraPosition _kGooglePlex = CameraPosition(
    target:
        LatLng(37.42796133580664, -122.085749655962), // Location coordinates
    zoom:
        14.4746, // Zoom level (0.0 : default, increasing results camera to be closer to earth)
  );

  // Jump to this location button press
  static const CameraPosition _kApplePark = CameraPosition(
      bearing: 0.0, // Direction - 0.0: North facing, 90.0: East facing
      target: LatLng(
          37.33479732997545, -122.00903637518307), // Location coordinates
      tilt: 59.440717697143555, // Tilt degree - 0.0: directly facing earth,
      zoom:
          16 // Zoom level (0.0 : default, increasing results camera to be closer to earth)
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        myLocationButtonEnabled: false,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheApplePark,
        label: const Text('Show Apple Park'),
        icon: const Icon(Icons.navigation_rounded),
      ),
    );
  }

  Future<void> _goToTheApplePark() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kApplePark));
  }
}
