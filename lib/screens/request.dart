import 'package:flutter/material.dart';
import 'package:moveout1/widgets/sliding_panel_widgets/custom_divider.dart';

import '../widgets/request_card.dart';

class RequestsScreen extends StatelessWidget {
  final List<RequestCard> items = [
    RequestCard(size: 'S', status: 'EA', destinationAddress: 'Rua dos Flamboyants, 524 - Mairiporã, SP (07621-250)', requestCode: 1,),
    RequestCard(size: 'M', status: 'CO', destinationAddress: 'Rua dos Flamboyants, 524 - Mairiporã, SP (07621-250)', requestCode: 2,),
    RequestCard(size: 'L', status: 'CA', destinationAddress: 'Rua dos Flamboyants, 524 - Mairiporã, SP (07621-250)', requestCode: 3,),
    RequestCard(size: 'S', status: 'AG', destinationAddress: 'Rua dos Flamboyants, 524 - Mairiporã, SP (07621-250)', requestCode: 4,),
    RequestCard(size: 'S', status: 'CO', destinationAddress: 'Rua dos Flamboyants, 524 - Mairiporã, SP (07621-250)', requestCode: 5,),
    RequestCard(size: 'L', status: 'AG', destinationAddress: 'Rua dos Flamboyants, 524 - Mairiporã, SP (07621-250)', requestCode: 6,),
  ];

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
              Navigator.maybePop(context);
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
              RequestCard(size: item.size, status: item.status, destinationAddress: item.destinationAddress, requestCode: item.requestCode,),
              const CustomDivider(),
            ],
          );
        },
      ),
    );
  }
}
