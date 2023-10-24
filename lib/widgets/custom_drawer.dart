import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:moveout1/screens/requests.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'profile_image_container.dart';

Future<Map<String, dynamic>> getInfo() async {
  var prefs = await SharedPreferences.getInstance();
  final user = prefs.getString("userData") ?? "";

  return jsonDecode(user);
}

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getInfo(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            String? name = snapshot.data!['name'];
            String? number = snapshot.data!['phone'];

            return Drawer(
              shape: const BeveledRectangleBorder(),
              width: MediaQuery.of(context).size.width * 0.65,
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListView(
                  children: [
                    Row(
                      children: [
                        const ImageContainer(),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  name ?? 'Carregando..',
                                  textAlign: TextAlign.left,
                                  maxLines: 1,
                                  style: const TextStyle(
                                      overflow: TextOverflow.clip,
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  number ?? 'Carregando..',
                                  maxLines: 1,
                                  style: const TextStyle(
                                      fontSize: 13,
                                      color: Colors.white,
                                      overflow: TextOverflow.clip),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 30),
                    CustomListTile(
                      icon: Icons.home,
                      text: 'Início',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RequestsScreen()));
                      },
                    ),
                    const SizedBox(height: 15),
                    CustomListTile(
                      icon: Icons.content_paste,
                      text: 'Pedidos',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RequestsScreen()));
                      },
                    ),
                    const SizedBox(height: 15),
                    CustomListTile(
                      icon: Icons.calendar_month,
                      text: 'Agenda',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RequestsScreen()));
                      },
                    ),
                    const SizedBox(height: 15),
                    CustomListTile(
                      icon: Icons.settings,
                      text: 'Configurações',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RequestsScreen()));
                      },
                    )
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
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}

class CustomListTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;
  const CustomListTile({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: InkWell(
        onTap: onTap,
        child: Row(
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
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
