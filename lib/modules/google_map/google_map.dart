import 'dart:async';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:graduation_project/shared/components/localization/app_local.dart';
import 'package:graduation_project/shared/TextToSpeech.dart';

class GoogleMapsScreen extends StatefulWidget {
  const GoogleMapsScreen({Key? key}) : super(key: key);

  @override
  State<GoogleMapsScreen> createState() => _GoogleMapsScreenState();
}

class _GoogleMapsScreenState extends State<GoogleMapsScreen> {
  Position? currentPosition;
  String? street;
  String? city;
  CameraPosition? initialCameraPosition;
  Set<Marker> markers = {};

  Future<LocationPermission> checkLocationPermission() async {
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isLocationServiceEnabled) {
      AwesomeDialog(
        context: context,
        title: "Services",
        body: const Text("Location Services Not Enabled"),
      ).show();
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    print("==============================");
    print(permission);
    print("===============================");
    return permission;
  }

  Future<void> getStreetAndCity() async {
    currentPosition = await Geolocator.getCurrentPosition();
    if (currentPosition != null) {
      double lat = currentPosition!.latitude;
      double long = currentPosition!.longitude;

      List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;
        street = placemark.street;
        city = placemark.locality;
        if (street != null && city != null) {
          speak("${getLang(context, 'm1')} $street, $city");
        } else {
          speak('Could not determine your current location');
        }

        initialCameraPosition = CameraPosition(
          target: LatLng(lat, long),
          zoom: 14.0,
        );

        setState(() {
          markers.add(
            Marker(
              markerId: MarkerId('currentLocation'),
              position: LatLng(lat, long),
            ),
          );
        });
      }
    }
  }

  void speak(String text) {
    TextToSpeech.speak(text); // Convert the given text to speech
  }

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  void initState() {
    super.initState();
    checkLocationPermission();
    getStreetAndCity();
    TextToSpeech.iniTts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 180, 31, 87),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_outlined, color: Colors.white),
        ),
        title: Text("${getLang(context, "feature5")}"),
      ),
      body: Column(
        children: [
          if (initialCameraPosition == null)
            CircularProgressIndicator()
          else
            Container(
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: initialCameraPosition!,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                markers: markers,
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
              ),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
            ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              speak(
                  "${getLang(context, 'back')}"); // Trigger the voice-over when the back button is tapped
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  const Color.fromARGB(255, 180, 31, 87)),
            ),
            child: Text("${getLang(context, 'bak')}"),
          ),
        ],
      ),
    );
  }
}
