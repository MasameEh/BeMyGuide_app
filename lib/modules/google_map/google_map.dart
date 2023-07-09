import 'dart:async';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:graduation_project/shared/components/localization/app_local.dart';


class GoogleMapsScreen extends StatefulWidget {
  const GoogleMapsScreen({Key? key}) : super(key: key);

  @override
  State<GoogleMapsScreen> createState() => _GoogleMapsScreenState();
}

class _GoogleMapsScreenState extends State<GoogleMapsScreen> {
  Position? c1;
  var long;
  var lat;
  late CameraPosition _kGooglePlex;

  Future getPer() async {
    bool services;
    LocationPermission per;
    services = await Geolocator.isLocationServiceEnabled();
    if (services == false) {
      AwesomeDialog(
          context: context,
          title: "services",
          body: const Text("Services Not Enabled"))
        .show();
    }
    per = await Geolocator.checkPermission();
    if (per == LocationPermission.denied) {
      per = await Geolocator.requestPermission();
    }
    print("==============================");
    print(per);
    print("===============================");
    return per;
  }

  Future<void> getLatAndLong() async {
    c1 = await Geolocator.getCurrentPosition();
    if (c1 != null) {
      lat = c1!.latitude;
      long = c1!.longitude;
      _kGooglePlex = CameraPosition(
        target: LatLng(lat, long),
        zoom: 14.4746,
      );
      setState(() {});
    }
  }

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  void initState() {
    getLatAndLong();
    getPer();
    super.initState();
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
          _kGooglePlex == null
              ? const CircularProgressIndicator()
              : GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: _kGooglePlex,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                ),
        ],
      ),
    );
  }
}
