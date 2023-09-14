import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';

import '../widgets/custom_icon_button_container.dart';

const String cloudMapId = 'f49afda8074367d0';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  SlidingUpPanelController panelController = SlidingUpPanelController();
  GoogleMapController? _controller;
  LocationData? _currentLocation;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  late ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.offset >=
              scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange) {
        panelController.expand();
      } else if (scrollController.offset <=
              scrollController.position.minScrollExtent &&
          !scrollController.position.outOfRange) {
        panelController.anchor();
      } else {}
    });
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
    if (_controller != null && _currentLocation != null) {
      _controller!.animateCamera(
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
      drawer: Drawer(
        shape: const BeveledRectangleBorder(),
        width: MediaQuery.of(context).size.width * 0.65,
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            children: const [
              Row(
                children: [
                  ImageContainer(),
                  Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nome',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Info. Adicionais',
                          style: TextStyle(fontSize: 13, color: Colors.white),
                        )
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 30),
              CustomListTile(icon: Icons.home, text: 'Início'),
              SizedBox(height: 15),
              CustomListTile(icon: Icons.content_paste, text: 'Pedidos'),
              SizedBox(height: 15),
              CustomListTile(icon: Icons.calendar_month, text: 'Agenda'),
              SizedBox(height: 15),
              CustomListTile(icon: Icons.settings, text: 'Configurações')
              // selected: _selectedIndex == 0,
              // onTap: () {
              //   // Update the state of the app
              //   _onItemTapped(0);
              //   // Then close the drawer
              //   Navigator.pop(context);
              // },
            ],
          ),
        ),
      ),
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
                      _controller = controller;
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
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 10, 10, 10),
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
                              iconColor:
                                  Theme.of(context).colorScheme.secondary,
                            )),
                      ),
                    ],
                  ),
                ),
                SafeArea(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: CustomIconButtonContainer(
                            submitFunction: () {
                              _centerMap();
                            },
                            size: 25,
                            icon: Icons.gps_fixed,
                            backgroundColor:
                                Theme.of(context).colorScheme.background,
                            iconColor:
                                Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                CustomSlidingPanel(
                    panelController: panelController,
                    scrollController: scrollController)
              ],
            ),
    );
  }
}

class CustomSlidingPanel extends StatelessWidget {
  const CustomSlidingPanel({
    super.key,
    required this.panelController,
    required this.scrollController,
  });

  final SlidingUpPanelController panelController;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    final BoxShadow shadow = BoxShadow(
        blurRadius: 5.0,
        spreadRadius: 2.0,
        color: Theme.of(context).colorScheme.shadow);
    return SlidingUpPanelWidget(
      controlHeight: 50.0,
      panelController: panelController,
      child: Container(
        // margin: const EdgeInsets.symmetric(horizontal: 5.0),
        decoration: ShapeDecoration(
          color: Theme.of(context).colorScheme.background,
          shadows: [shadow],
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0),
              topRight: Radius.circular(15.0),
            ),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              height: 50.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.drag_handle,
                    color: Theme.of(context).colorScheme.onBackground,
                    size: 30,
                  ),
                ],
              ),
            ),
            Divider(
              height: 0.5,
              color: Colors.grey[300],
            ),
            Flexible(
              child: Container(
                color: Colors.white,
                child: ListView.separated(
                  controller: scrollController,
                  physics: const ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('list item $index'),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(
                      height: 0.5,
                    );
                  },
                  shrinkWrap: true,
                  itemCount: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ImageContainer extends StatelessWidget {
  const ImageContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        border: Border.all(
          width: 3,
          color: Theme.of(context).colorScheme.secondary,
        ),
        borderRadius: BorderRadius.circular(200),
      ),
      width: 75,
      height: 75,
      child: Icon(
        Icons.camera_alt,
        size: MediaQuery.sizeOf(context).width * 0.075,
        color: Theme.of(context).colorScheme.onBackground,
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  final IconData icon;
  final String text;
  const CustomListTile({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          Icon(
            icon,
            color: Theme.of(context).colorScheme.secondary,
            size: 25,
          ),
          const SizedBox(width: 15),
          Text(
            text,
            style: const TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
