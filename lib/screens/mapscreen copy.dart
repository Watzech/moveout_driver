// // ignore_for_file: must_be_immutable

// import 'package:flutter/material.dart';

// import 'package:flutter_map/plugin_api.dart';
// import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:geolocator/geolocator.dart';

// Future<Position> _determinePosition() async {
//   bool serviceEnabled;
//   LocationPermission permission;

//   serviceEnabled = await Geolocator.isLocationServiceEnabled();
//   if (!serviceEnabled) {
//     return Future.error('Serviços de localização estão desligados.');
//   }

//   permission = await Geolocator.checkPermission();
//   if (permission == LocationPermission.denied) {
//     permission = await Geolocator.requestPermission();
//     if (permission == LocationPermission.denied) {
//       return Future.error('Permissão de acesso à localização negada.');
//     }
//   }

//   if (permission == LocationPermission.deniedForever) {
//     return Future.error(
//         'Permissão de acesso à localização permanentemente negada.');
//   }

//   return await Geolocator.getCurrentPosition();
// }

// class MapScreen extends StatelessWidget {
//   MapScreen({super.key});
//   final Future<Position> currentPosition = _determinePosition();
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
//   final GlobalKey<FlutterMapState> _mapKey = GlobalKey();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         key: _scaffoldKey,
//         drawer: Drawer(
//           shape: const BeveledRectangleBorder(),
//           width: MediaQuery.of(context).size.width * 0.75,
//           backgroundColor: Theme.of(context).primaryColor,
//           child: Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: ListView(
//               children: const [
//                 Row(
//                   children: [
//                     ImageContainer(),
//                     Padding(
//                       padding: EdgeInsets.all(15.0),
//                       child: Column(
//                         children: [
//                           Text(
//                             'Nome',
//                             style: TextStyle(fontSize: 30, color: Colors.white),
//                           ),
//                           Text(
//                             'Info. Adicionais',
//                             style: TextStyle(fontSize: 18, color: Colors.white),
//                           )
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//                 SizedBox(height: 40),
//                 CustomListTile(icon: Icons.home, text: 'Início'),
//                 SizedBox(height: 15),
//                 CustomListTile(icon: Icons.content_paste, text: 'Pedidos'),
//                 SizedBox(height: 15),
//                 CustomListTile(icon: Icons.calendar_month, text: 'Agenda'),
//                 SizedBox(height: 15),
//                 CustomListTile(icon: Icons.settings, text: 'Configurações')
//                 // selected: _selectedIndex == 0,
//                 // onTap: () {
//                 //   // Update the state of the app
//                 //   _onItemTapped(0);
//                 //   // Then close the drawer
//                 //   Navigator.pop(context);
//                 // },
//               ],
//             ),
//           ),
//         ),
//         body: Stack(children: [
//           Center(
//               child: FutureBuilder(
//             future: currentPosition,
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 return FlutterMap(
//                   key: _mapKey,
//                   options: MapOptions(
//                     center: LatLng(
//                         snapshot.data!.latitude, snapshot.data!.longitude),
//                     zoom: 15.0,
//                   ),
//                   children: [
//                     TileLayer(
//                       //tem como alterar a estilização do mapa depois, se quisermos
//                       urlTemplate:
//                           'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
//                       userAgentPackageName: 'com.example.app',
//                     ),
//                     CurrentLocationLayer(
//                       followOnLocationUpdate: FollowOnLocationUpdate.always,
//                       style: LocationMarkerStyle(
//                         marker: DefaultLocationMarker(
//                           color: Theme.of(context).colorScheme.primary,
//                           // child: Icon(
//                           //   Icons.person,
//                           //   color: Theme.of(context).colorScheme.secondary,
//                           // ),
//                         ),
//                         markerSize: const Size.square(20),
//                         headingSectorRadius: 0,
//                       ),
//                     ),
//                   ],
//                 );
//               } else {
//                 return const CircularProgressIndicator();
//               }
//             },
//           )),
//           SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Align(
//                   alignment: Alignment.topLeft,
//                   child: ElevatedButton(
//                       onPressed: () {
//                         _scaffoldKey.currentState?.openDrawer();
//                       },
//                       style: ElevatedButton.styleFrom(
//                         shape: const CircleBorder(),
//                         padding: const EdgeInsets.all(10),
//                         backgroundColor: Theme.of(context)
//                             .colorScheme
//                             .primary, // <-- Button color
//                       ),
//                       child: Icon(
//                         Icons.list,
//                         color: Theme.of(context).colorScheme.secondary,
//                         size: 35,
//                       ))),
//             ),
//           ),
//           SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Align(
//                   alignment: Alignment.bottomRight,
//                   child: ElevatedButton(
//                       onPressed: () {
//                         _mapKey.currentState?.center;
//                       },
//                       style: ElevatedButton.styleFrom(
//                         shape: const CircleBorder(),
//                         padding: const EdgeInsets.all(12),
//                         backgroundColor: Theme.of(context)
//                             .colorScheme
//                             .background, // <-- Button color
//                       ),
//                       child: Icon(
//                         Icons.gps_fixed,
//                         color: Theme.of(context).colorScheme.onBackground,
//                         size: 25,
//                       ))),
//             ),
//           )
//         ]));
//   }
// }

// Padding(
//                         padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
//                         child: Align(
//                             alignment: Alignment.topRight,
//                             child: ElevatedButton(
//                                 onPressed: () {
//                                   _scaffoldKey.currentState?.openDrawer();
//                                 },
//                                 style: ElevatedButton.styleFrom(
//                                   shape: const CircleBorder(),
//                                   padding: const EdgeInsets.all(10),
//                                   backgroundColor: Theme.of(context)
//                                       .colorScheme
//                                       .primary, // <-- Button color
//                                 ),
//                                 child: Icon(
//                                   Icons.gps_fixed,
//                                   color:
//                                       Theme.of(context).colorScheme.secondary,
//                                   size: 20,
//                                 ))),
//                       ),

// class ImageContainer extends StatelessWidget {
//   const ImageContainer({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Theme.of(context).colorScheme.onBackground,
//         border: Border.all(
//           width: 3,
//           color: Theme.of(context).colorScheme.secondary,
//         ),
//         borderRadius: BorderRadius.circular(200),
//       ),
//       // width: MediaQuery.sizeOf(context).width * 0.50,
//       // height: MediaQuery.sizeOf(context).height * 0.23,
//       width: 100,
//       height: 100,
//       child: Icon(
//         Icons.camera_alt,
//         size: MediaQuery.sizeOf(context).width * 0.075,
//         color: Theme.of(context).colorScheme.background,
//       ),
//     );
//   }
// }

// class CustomListTile extends StatelessWidget {
//   final IconData icon;
//   final String text;
//   const CustomListTile({
//     super.key,
//     required this.icon,
//     required this.text,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       title: Row(
//         children: [
//           Icon(
//             icon,
//             color: Theme.of(context).colorScheme.secondary,
//             size: 30,
//           ),
//           const SizedBox(width: 15),
//           Text(
//             text,
//             style: const TextStyle(
//                 fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
//           ),
//         ],
//       ),
//     );
//   }
// }
