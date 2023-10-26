import 'package:flutter/material.dart';
import 'package:moveout1/classes/request.dart';
import 'package:moveout1/screens/request_detail.dart';
import 'package:moveout1/services/save_info.dart';
import 'package:moveout1/widgets/sliding_panel_widgets/custom_divider.dart';

import '../widgets/request_card.dart';

class RequestsScreen extends StatefulWidget {
  RequestsScreen({super.key});

  @override
  State<RequestsScreen> createState() => _RequestsScreenState();
}

class _RequestsScreenState extends State<RequestsScreen> {
  List<Request> items = [];

  late List<RequestCard> requests;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
  
      final requestsByUser = await getRequestsInfo();

      // ATENÇÃO
      // print(requestsByUser);
      // ATENÇÃO

      requestsByUser?.forEach((element) {
        items.add(Request(
            cpfClient: element['cpfClient'],
            price: element['price'],
            origin: element['origin'],
            destination: element['destination'],
            date: element['date'],
            helpers: element['helpers'],
            load: element['load'],
            createdAt: DateTime.parse(element['createdAt']),
            updatedAt: DateTime.parse(element['updatedAt']),
            status: element['status']));
      });
    });
  }

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
                            builder: (context) =>
                                RequestDetailScreen(request: item)));
                  },
                  child: RequestCard(request: item)),
              const CustomDivider(),
            ],
          );
        },
      ),
    );
  }
}
