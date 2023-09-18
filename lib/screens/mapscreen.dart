import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/custom_icon_button_container.dart';
import '../widgets/custom_sliding_panel.dart';

const String cloudMapId = 'f49afda8074367d0';

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
  LocationData? _currentLocation;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _handleCheckboxChanged(bool checkboxValue, bool newValue) {
    setState(() {
      checkboxValue = newValue;
    });
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

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

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
                  // markers: {
                  //   Marker(
                  //     markerId: MarkerId('user_location'),
                  //     position: LatLng(
                  //       _currentLocation!.latitude!,
                  //       _currentLocation!.longitude!,
                  //     ),
                  //     infoWindow: InfoWindow(title: 'Sua Localização'),
                  //   ),
                  // },
                  myLocationEnabled: true,
                ),
                SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: Center(
                          child: Container(
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                  blurRadius: 5.0,
                                  spreadRadius: 2.0,
                                  color: Theme.of(context).colorScheme.shadow)
                            ]),
                            // child: GooglePlaceAutoCompleteTextField(
                            //   textEditingController: _searchController,
                            //   countries: const ["br"],
                            //   googleAPIKey:
                            //       'AIzaSyAzLqE1W-oS1F7Z5kMDKKZmIXMzUinkbhU',
                            //   textStyle: TextStyle(

                            //   ),
                            //   boxDecoration: BoxDecoration(
                            //     color: Theme.of(context).colorScheme.background,
                            //     boxShadow: [
                            //       BoxShadow(
                            //           blurRadius: 5.0,
                            //           spreadRadius: 2.0,
                            //           color:
                            //               Theme.of(context).colorScheme.shadow)
                            //     ],
                            //     border: Border.all(color: Colors.transparent),
                            //     borderRadius:
                            //         const BorderRadius.all(Radius.circular(5)),
                            //   ),
                            // )
                            child: TextField(
                              controller: _searchController,
                              decoration: InputDecoration(
                                filled: true,
                                hintText: 'Pesquisar Endereço',
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  borderSide:
                                      BorderSide(style: BorderStyle.none),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5)),
                                  borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                ),
                                fillColor:
                                    Theme.of(context).colorScheme.background,
                              ),
                            ),
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
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Align(
                                    alignment: Alignment.topLeft,
                                    child: CustomIconButtonContainer(
                                      submitFunction: () {
                                        _scaffoldKey.currentState?.openDrawer();
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
                                padding: const EdgeInsets.fromLTRB(7, 7, 7, 7),
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
                )
              ],
            ),
    );
  }
}

