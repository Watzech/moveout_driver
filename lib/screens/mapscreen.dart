// import 'package:another_flushbar/flushbar.dart';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
// import 'package:moveout1/services/device_info.dart';

// import '../widgets/custom_drawer.dart';
// import '../widgets/custom_icon_button_container.dart';
// import '../widgets/search_address_text_field.dart';

// const String cloudMapId = 'f49afda8074367d0';
// const EdgeInsets stackWidgetsPadding = EdgeInsets.fromLTRB(20, 20, 20, 20);

// class MapScreen extends StatefulWidget {
//   const MapScreen({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _MapScreenState createState() => _MapScreenState();
// }

// class _MapScreenState extends State<MapScreen> {
//   GoogleMapController? _mapController;
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
//   final TextEditingController _searchController = TextEditingController();
//   final FocusNode _searchFieldFocus = FocusNode();
//   final FocusNode _originAddressFieldFocus = FocusNode();
//   final FocusNode _destinationAddressFieldFocus = FocusNode();

//   TextEditingController originAddressController = TextEditingController();
//   TextEditingController destinationAddressController = TextEditingController();
//   TextEditingController firstDateController = TextEditingController();
//   TextEditingController secondDateController = TextEditingController();
//   TextEditingController furnitureCheckController = TextEditingController();
//   TextEditingController boxCheckController = TextEditingController();
//   TextEditingController fragileCheckController = TextEditingController();
//   TextEditingController otherCheckController = TextEditingController();
//   Map<String, dynamic> originPlace = {};
//   Map<String, dynamic> destinationPlace = {};
//   LocationData? _currentLocation;
//   Set<Marker> _markers = {};
//   TextEditingController? searchCallerController;
//   String searchHintText = 'Pesquisar Endereço';
//   String searchIdentifier = '';
//   dynamic _userData;

//   @override
//   void initState() {
//     super.initState();
//     getInfo();
//     _getCurrentLocation();
//   }

//   getInfo() async {
//     var userData = await getUserInfo();
//     setState(() {
//       _userData = userData;
//     });
//   }

//   Future<void> _getCurrentLocation() async {
//     final location = Location();
//     final locationData = await location.getLocation();
//     setState(() {
//       _currentLocation = locationData;
//     });
//   }

//   void _centerMap() {
//     if (_mapController != null && _currentLocation != null) {
//       _mapController!.animateCamera(
//         CameraUpdate.newLatLng(
//           LatLng(
//             _currentLocation!.latitude!,
//             _currentLocation!.longitude!,
//           ),
//         ),
//       );
//     }
//   }

//   void _addressSelected(
//       LatLng location, TextEditingController? caller, String? identifier) {
//     _moveToAndPin(location);
//     if (caller != null && identifier != null) {
//       Map<String, dynamic> newLocation = {};
//       newLocation['name'] = caller.text;
//       newLocation['latitude'] = location.latitude;
//       newLocation['longitude'] = location.longitude;
//       switch (identifier) {
//         case 'O':
//           setState(() {
//             originPlace = newLocation;
//           });
//           break;
//         case 'D':
//           setState(() {
//             destinationPlace = newLocation;
//           });
//           break;
//       }
//     }
//   }

//   _addMarker(LatLng position, BitmapDescriptor descriptor) {
//     MarkerId markerId = const MarkerId("locationPin");
//     Marker marker =
//         Marker(markerId: markerId, icon: descriptor, position: position);
//     setState(() {
//       // _markers.add(marker);
//       _markers = {marker};
//     });
//   }

//   _resetMarkersAndPosition() {
//     setState(() {
//       _markers = {};
//     });
//     _centerMap();
//   }

//   void _moveToAndPin(LatLng newLocation) {
//     if (_mapController != null && _currentLocation != null) {
//       // _addMarker(newLocation, BitmapDescriptor.defaultMarkerWithHue(200));
//       _addMarker(newLocation,
//           BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed));
//       _mapController!.animateCamera(
//         CameraUpdate.newLatLng(
//           LatLng(
//             newLocation.latitude,
//             newLocation.longitude,
//           ),
//         ),
//       );
//     }
//   }

//   void closePanelAndFocusSearch(
//       TextEditingController? caller, String newHintText, String identifier) {
//     _searchController.text = '';
//     setState(() {
//       searchCallerController = caller;
//       searchHintText = newHintText;
//       searchIdentifier = identifier;
//     });
//     _searchFieldFocus.requestFocus();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final topPadding = MediaQuery.of(context).padding.top;
//     final bottomPadding = MediaQuery.of(context).padding.bottom;

//     return WillPopScope(
//       onWillPop: () async {
//         return false;
//       },
//       child: Scaffold(
//         key: _scaffoldKey,
//         drawer: CustomDrawer(
//           userData: _userData,
//           context: context,
//         ),
//         resizeToAvoidBottomInset: false,
//         body: _currentLocation == null
//             ? Center(
//                 child: CircularProgressIndicator(
//                   backgroundColor: Theme.of(context).colorScheme.primary,
//                   color: Theme.of(context).colorScheme.secondary,
//                 ),
//               )
//             : Stack(
//                 children: [
//                   GoogleMap(
//                     padding: EdgeInsets.only(
//                         bottom: bottomPadding,
//                         top: topPadding,
//                         right: 0,
//                         left: 0),
//                     compassEnabled: false,
//                     myLocationButtonEnabled: false,
//                     mapToolbarEnabled: true,
//                     zoomControlsEnabled: false,
//                     cloudMapId: cloudMapId,
//                     markers: _markers,
//                     myLocationEnabled: true,
//                     onMapCreated: (controller) {
//                       setState(() {
//                         _mapController = controller;
//                       });
//                     },
//                     initialCameraPosition: CameraPosition(
//                       target: LatLng(
//                         _currentLocation!.latitude!,
//                         _currentLocation!.longitude!,
//                       ),
//                       zoom: 15.0,
//                     ),
//                   ),
//                   SafeArea(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       mainAxisSize: MainAxisSize.max,
//                       children: [
//                         Padding(
//                           padding: stackWidgetsPadding,
//                           child: Center(
//                             child: Container(
//                               decoration: BoxDecoration(boxShadow: [
//                                 BoxShadow(
//                                     blurRadius: 5.0,
//                                     spreadRadius: 2.0,
//                                     color: Theme.of(context).colorScheme.shadow)
//                               ]),
//                               child: SearchAddressTextField(
//                                 hintText: searchHintText,
//                                 callerController: searchCallerController,
//                                 addressSearchFocusNode: _searchFieldFocus,
//                                 searchController: _searchController,
//                                 onChangedFunction: _addressSelected,
//                                 callerIdentifier: searchIdentifier,
//                               ),
//                             ),
//                           ),
//                         ),
//                         Stack(
//                           children: [
//                             Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Padding(
//                                   padding: stackWidgetsPadding,
//                                   child: Align(
//                                       alignment: Alignment.topLeft,
//                                       child: CustomIconButtonContainer(
//                                         submitFunction: () {},
//                                         size: 40,
//                                         icon: Icons.format_list_bulleted,
//                                         backgroundColor: Theme.of(context)
//                                             .colorScheme
//                                             .primary,
//                                         iconColor: Theme.of(context)
//                                             .colorScheme
//                                             .secondary,
//                                       )),
//                                 ),
//                               ],
//                             ),
//                             Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Padding(
//                                   padding: stackWidgetsPadding,
//                                   child: Align(
//                                     alignment: Alignment.topRight,
//                                     child: CustomIconButtonContainer(
//                                       submitFunction: () {
//                                         _centerMap();
//                                       },
//                                       size: 25,
//                                       icon: Icons.gps_fixed,
//                                       backgroundColor: Theme.of(context)
//                                           .colorScheme
//                                           .background,
//                                       iconColor: Theme.of(context)
//                                           .colorScheme
//                                           .onBackground,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//       ),
//     );
//   }
// }
