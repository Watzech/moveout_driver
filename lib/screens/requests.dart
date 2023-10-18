import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:moveout1/classes/request.dart';
import 'package:moveout1/classes/client.dart';
import 'package:moveout1/database/request_db.dart';
import 'package:moveout1/screens/request_detail.dart';
import 'package:moveout1/widgets/sliding_panel_widgets/custom_divider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/request_card.dart';

class RequestsScreen extends StatelessWidget {
  final List<Request> items = [];

  late List<RequestCard> requests;

  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      var prefs = await SharedPreferences.getInstance();
      final user = prefs.getString("userData") ?? "";
      final userData = json.decode(user);

      await RequestDb.connect();
      //ainda precisamos pegar o estado/cidade do endereço do usuário logado
      //ainda precisamos pegar pelo ID do cliente que postou o request
      final requestsByUser =
          await RequestDb.getFilteredInfo("SP", "Vila Santista", true);

      requestsByUser?.forEach((element) {
        // requests.add(json.decode(element.v));
      });
    });
  }

  RequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          'Pedidos',
          style: TextStyle(
              fontFamily: 'BebasKai', fontSize: 35, color: Colors.white),
        ),
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_sharp,
              color: Theme.of(context).colorScheme.secondary,
              size: 35,
            )),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(0),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Column(
            children: [
              InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RequestDetailScreen(request: item)));
                  },
                  child: RequestCard(
                    request: item
                  )),
              const CustomDivider(),
            ],
          );
        },
      ),
    );
  }
}
