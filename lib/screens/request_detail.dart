// ignore_for_file: library_private_types_in_public_api

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:moveout1/classes/request.dart';
import 'package:moveout1/constants/main.dart' as constants;
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class RequestDetailScreen extends StatefulWidget {
  final Request request;
  const RequestDetailScreen({super.key, required this.request});

  @override
  _RequestDetailScreenState createState() => _RequestDetailScreenState();
}

class _RequestDetailScreenState extends State<RequestDetailScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  late GoogleMapController mapController;
  // double _originLatitude = 6.5212402, _originLongitude = 3.3679965;
  // double _destLatitude = 6.849660, _destLongitude = 3.648190;
  // double _originLatitude = 26.48424, _originLongitude = 50.04551;
  // double _destLatitude = 26.46423, _destLongitude = 50.06358;
  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPiKey = constants.API_KEY;

  @override
  void initState() {
    super.initState();

    _addMarker(LatLng(widget.request.origin["lat"], widget.request.origin["long"]), "origin",
        BitmapDescriptor.defaultMarker);

    _addMarker(LatLng(widget.request.destination["lat"], widget.request.destination["long"]), "destination",
        BitmapDescriptor.defaultMarkerWithHue(90));

    _getPolyline();
  }

  @override
  void deactivate(){
    super.deactivate();
  
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          child: GoogleMap(
            initialCameraPosition: _calculateCameraPosition(),
            myLocationEnabled: false,
            tiltGesturesEnabled: false,
            compassEnabled: false,
            scrollGesturesEnabled: false,
            zoomGesturesEnabled: false,
            zoomControlsEnabled: true,
            onMapCreated: _onMapCreated,
            markers: Set<Marker>.of(markers.values),
            polylines: Set<Polyline>.of(polylines.values),
          ),
        ),
        Container(
          color: Colors.white,
          height: MediaQuery.sizeOf(context).height *
              0.50,
          child: const Center(
            child: Text(
              'Conteúdo na parte inferior',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    ));
  }

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    _controller.complete(controller);

    LatLngBounds bounds = LatLngBounds(
      southwest: LatLng(widget.request.origin["lat"], widget.request.origin["long"]),
      northeast: LatLng(widget.request.destination["lat"], widget.request.destination["long"]),
    );

    Future.delayed(const Duration(milliseconds: 500), () {
      CameraUpdate zoomToFit = CameraUpdate.newLatLngBounds(bounds, 70);
      mapController.animateCamera(zoomToFit);
    });
    
  }

  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker =
        Marker(markerId: markerId, icon: descriptor, position: position);
    markers[markerId] = marker;
  }

  _addPolyLine() {
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id, color: Colors.red, points: polylineCoordinates, width: 5);
    polylines[id] = polyline;
    setState(() {});
  }

  _getPolyline() async {
    List<PolylineWayPoint> polylineWayPoints = [];

    polylineWayPoints.add(PolylineWayPoint(location: "${widget.request.origin["lat"].toString()}, ${widget.request.origin["long"]}", stopOver: false));
    polylineWayPoints.add(PolylineWayPoint(location: "${widget.request.destination["lat"].toString()}, ${widget.request.destination["long"]}", stopOver: false));
  
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleAPiKey,
        PointLatLng(widget.request.origin["lat"], widget.request.origin["long"]),
        PointLatLng(widget.request.destination["lat"], widget.request.destination["long"]),
        travelMode: TravelMode.driving,
        wayPoints: polylineWayPoints);
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }
    _addPolyLine();
  }

  CameraPosition _calculateCameraPosition() {
    LatLngBounds bounds = LatLngBounds(
      northeast: LatLng(widget.request.origin["lat"], widget.request.origin["long"]),
      southwest: LatLng(widget.request.destination["lat"], widget.request.destination["long"]),
    );

    LatLng center = LatLng(
        (bounds.northeast.latitude + bounds.southwest.latitude) / 2,
        (bounds.northeast.longitude + bounds.southwest.longitude) / 2);

    CameraPosition initialCameraPosition = CameraPosition(
      target: center,
      zoom: 10,
    );

    return initialCameraPosition;
  }
}
