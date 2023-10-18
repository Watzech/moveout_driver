import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../widgets/custom_drawer.dart';
import '../widgets/custom_icon_button_container.dart';
import '../widgets/custom_sliding_panel.dart';
import '../widgets/search_address_text_field.dart';

const String cloudMapId = 'f49afda8074367d0';
const EdgeInsets stackWidgetsPadding = EdgeInsets.fromLTRB(20, 20, 20, 20);

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _mapController;
  final PanelController _panelController = PanelController();
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  TextEditingController originAddressController = TextEditingController();
  TextEditingController destinationAddressController = TextEditingController();
  TextEditingController firstDateController = TextEditingController();
  TextEditingController secondDateController = TextEditingController();
  TextEditingController furnitureCheckController = TextEditingController();
  TextEditingController boxCheckController = TextEditingController();
  TextEditingController fragileCheckController = TextEditingController();
  TextEditingController otherCheckController = TextEditingController();
  LocationData? _currentLocation;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    final location = Location();
    final locationData = await location.getLocation();
    setState(() {
      _currentLocation = locationData;
    });
  }

  void _centerMap() {
    if (_mapController != null && _currentLocation != null) {
      _mapController!.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(
            _currentLocation!.latitude!,
            _currentLocation!.longitude!,
          ),
        ),
      );
    }
  }

  _addMarker(LatLng position, BitmapDescriptor descriptor) {
    MarkerId markerId = const MarkerId("locationPin");
    Marker marker =
        Marker(markerId: markerId, icon: descriptor, position: position);
    setState(() {
      _markers[markerId] = marker;
    });
  }

  void _moveTo(LatLng newLocation) {
    if (_mapController != null && _currentLocation != null) {
      _mapController!.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(
            newLocation.latitude,
            newLocation.longitude,
          ),
        ),
      );
      _addMarker(newLocation, id, descriptor)
    }
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    final FocusNode addressSearchFocusNode = FocusNode();

    return Scaffold(
      key: _scaffoldKey,
      drawer: const CustomDrawer(),
      resizeToAvoidBottomInset: false,
      body: _currentLocation == null
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Theme.of(context).colorScheme.primary,
                color: Theme.of(context).colorScheme.secondary,
              ),
            )
          : Stack(
              children: [
                GoogleMap(
                  padding: EdgeInsets.only(
                      bottom: bottomPadding,
                      top: topPadding,
                      right: 0,
                      left: 0),
                  myLocationButtonEnabled: false,
                  mapToolbarEnabled: true,
                  zoomControlsEnabled: false,
                  cloudMapId: cloudMapId,
                  markers: _markers,
                  myLocationEnabled: true,
                  onMapCreated: (controller) {
                    setState(() {
                      _mapController = controller;
                    });
                  },
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      _currentLocation!.latitude!,
                      _currentLocation!.longitude!,
                    ),
                    zoom: 15.0,
                  ),
                ),
                SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: stackWidgetsPadding,
                        child: Center(
                          child: Container(
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                  blurRadius: 5.0,
                                  spreadRadius: 2.0,
                                  color: Theme.of(context).colorScheme.shadow)
                            ]),
                            // child: Focus(
                            //   onFocusChange: (hasFocus) {
                            //     if (hasFocus) {
                            //       _panelController.isPanelOpen
                            //           ? _panelController.close()
                            //           : null;
                            //     }
                            //   },
                            child: SearchAddressTextField(
                              addressSearchFocusNode: addressSearchFocusNode,
                              searchController: _searchController,
                              onChangedFunction: _moveTo,
                            ),
                            // ),
                          ),
                        ),
                      ),
                      Stack(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: stackWidgetsPadding,
                                child: Align(
                                    alignment: Alignment.topLeft,
                                    child: CustomIconButtonContainer(
                                      submitFunction: () {
                                        _scaffoldKey.currentState?.openDrawer();
                                        _panelController.isPanelOpen
                                            ? _panelController.close()
                                            : null;
                                      },
                                      size: 40,
                                      icon: Icons.format_list_bulleted,
                                      backgroundColor:
                                          Theme.of(context).colorScheme.primary,
                                      iconColor: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    )),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: stackWidgetsPadding,
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: CustomIconButtonContainer(
                                    submitFunction: () {
                                      _centerMap();
                                    },
                                    size: 25,
                                    icon: Icons.gps_fixed,
                                    backgroundColor: Theme.of(context)
                                        .colorScheme
                                        .background,
                                    iconColor: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                CustomSlidingPanel(
                  panelController: _panelController,
                  scrollController: _scrollController,
                  originAddressController: originAddressController,
                  destinationAddressController: destinationAddressController,
                  firstDateController: firstDateController,
                  secondDateController: secondDateController,
                  furnitureCheckController: furnitureCheckController,
                  boxCheckController: boxCheckController,
                  fragileCheckController: fragileCheckController,
                  otherCheckController: otherCheckController,
                )
              ],
            ),
    );
  }
}
