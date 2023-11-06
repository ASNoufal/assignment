import 'dart:async';

import 'package:assignment/application/const.dart';
import 'package:assignment/domain/stateauth/authentication_provider.dart';
import 'package:assignment/presentation/Login/Loginpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

// ignore: must_be_immutable
class Mymap extends ConsumerStatefulWidget {
  Mymap({required this.lat, required this.lon, super.key});

  double? lat;
  double? lon;

  @override
  ConsumerState<Mymap> createState() => _MymapState();
}

class _MymapState extends ConsumerState<Mymap> {
  final Location location = Location();
  LatLng? currentlatlng;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  static LatLng _googleloc = LatLng(11.254723287414867, 75.77839809303116);

  LatLng? retailstorelocation;
  CameraPosition? kGoogleplex;

  Map<PolylineId, Polyline> polylines = {};

  @override
  void initState() {
    kGoogleplex = CameraPosition(
      target: LatLng(widget.lat!, widget.lon!),
      zoom: 10,
    );
    // latitude = widget.lat;
    // longitude = widget.lon;
    retailstorelocation = LatLng(widget.lat!, widget.lon!);

    getcurrentloction()
        .then((_) => getpolylinepoints())
        .then((value) => generatePolyLinePoints(value));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        title: Text("Map"),
      ),
      body: currentlatlng == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                GoogleMap(
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  initialCameraPosition: kGoogleplex!,
                  markers: {
                    Marker(
                        markerId: const MarkerId("currentlocation"),
                        icon: BitmapDescriptor.defaultMarker,
                        position: currentlatlng!),
                    Marker(
                        markerId: const MarkerId("retailstore"),
                        icon: BitmapDescriptor.defaultMarker,
                        position: retailstorelocation!),
                  },
                  polylines: Set<Polyline>.of(polylines.values),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white),
                    width: double.infinity,
                    height: 100,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green[300]),
                        onPressed: () {
                          onmap(retailstorelocation!.latitude,
                              retailstorelocation!.longitude);
                        },
                        child: Text("Goto Drive")),
                  ),
                )
              ],
            ),
    );
  }

  ///position of camera while rendering
  Future<void> cameratoposition(LatLng pos) async {
    GoogleMapController controller = await _controller.future;

    CameraPosition cameraPosition = CameraPosition(target: pos, zoom: 16);

    await controller
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  /// current location of driver
  Future<void> getcurrentloction() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    location.onLocationChanged.listen((LocationData currentlocation) {
      if (currentlocation.latitude != null &&
          currentlocation.longitude != null) {
        setState(() {
          currentlatlng =
              LatLng(currentlocation.latitude!, currentlocation.longitude!);
        });

        /// added the camera postion to get the location while rendenring
        cameratoposition(currentlatlng!);
      }
    });
  }

  Future<List<LatLng>> getpolylinepoints() async {
    if (currentlatlng == null) {
      await Future.delayed(Duration(seconds: 1));
      return getpolylinepoints();
    }
    List<LatLng> polylinecoodinates = [];
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        apikey,
        PointLatLng(currentlatlng!.latitude, currentlatlng!.longitude),
        PointLatLng(
            retailstorelocation!.latitude, retailstorelocation!.longitude),
        travelMode: TravelMode.driving);
    if (result.points.isNotEmpty) {
      result.points.forEach((element) {
        polylinecoodinates.add(LatLng(element.latitude, element.longitude));
      });
    } else {
      print("error");
    }
    print(polylinecoodinates.toString());
    return polylinecoodinates;
  }

  void generatePolyLinePoints(List<LatLng> polylinecoordinate) {
    PolylineId polygonId = PolylineId("poly");
    List<LatLng> allpolylinecoordinate = [
      currentlatlng!,
      ...polylinecoordinate
    ];

    Polyline polyline = Polyline(
        polylineId: polygonId,
        color: Colors.black,
        points: allpolylinecoordinate,
        width: 8);
    setState(() {
      polylines[polygonId] = polyline;
    });
  }

  Future<void> onmap(double lat, double lon) async {
    final Uri _url =
        Uri.parse('https://www.google.com/maps/search/?api=1&query=$lat,$lon');
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}
