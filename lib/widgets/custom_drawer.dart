import 'package:flutter/material.dart';
import 'profile_image_container.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
