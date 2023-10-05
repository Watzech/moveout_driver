import 'package:flutter/material.dart';
import 'package:moveout1/classes/request.dart';
import 'package:moveout1/screens/request_detail.dart';
import 'package:moveout1/widgets/sliding_panel_widgets/custom_divider.dart';

import '../widgets/request_card.dart';

class RequestsScreen extends StatelessWidget {
  final List<List<String>> loadItems = [
    ['aa', 'aa'],
    ['aa', 'aa'],
    ['aa', 'aa'],
    ['aa', 'aa'],
    ['aa', 'aa'],
    ['aa', 'aa'],
    ['aa', 'aa'],
  ];

  final List<RequestCard> items = [
    const RequestCard(
      size: 'S',
      status: 'EA',
      destinationAddress:
          'Rua dos Flamboyants, 524 - Mairiporã, SP (07621-250)',
      itensList: ['Sofá', 'Mesa', 'Abacaxi'],
      price: 1020.10,
      requestCode: 1,
    ),
    const RequestCard(
      size: 'M',
      status: 'CO',
      destinationAddress:
          'Rua dos Flamboyants, 524 - Mairiporã, SP (07621-250)',
      itensList: ['Sofá', 'Mesa', 'Abacaxi'],
      price: 1020.10,
      requestCode: 2,
    ),
    const RequestCard(
      size: 'L',
      status: 'CA',
      destinationAddress:
          'Rua dos Flamboyants, 524 - Mairiporã, SP (07621-250)',
      itensList: ['Sofá', 'Mesa', 'Abacaxi'],
      price: 1020.10,
      requestCode: 3,
    ),
    const RequestCard(
      size: 'S',
      status: 'AG',
      destinationAddress:
          'Rua dos Flamboyants, 524 - Mairiporã, SP (07621-250)',
      itensList: ['Sofá', 'Mesa', 'Abacaxi'],
      price: 1020.10,
      requestCode: 4,
    ),
    const RequestCard(
      size: 'S',
      status: 'CO',
      destinationAddress:
          'Rua dos Flamboyants, 524 - Mairiporã, SP (07621-250)',
      itensList: ['Sofá', 'Mesa', 'Abacaxi'],
      price: 1020.10,
      requestCode: 5,
    ),
    const RequestCard(
      size: 'L',
      status: 'AG',
      destinationAddress:
          'Rua dos Flamboyants, 524 - Mairiporã, SP (07621-250)',
      itensList: ['Sofá', 'Mesa', 'Abacaxi'],
      price: 1020.10,
      requestCode: 6,
    ),
    const RequestCard(
      size: 'S',
      status: 'EA',
      destinationAddress:
          'Rua dos Flamboyants, 524 - Mairiporã, SP (07621-250)',
      itensList: ['Sofá', 'Mesa', 'Abacaxi'],
      price: 1020.10,
      requestCode: 7,
    ),
    const RequestCard(
      size: 'M',
      status: 'CO',
      destinationAddress:
          'Rua dos Flamboyants, 524 - Mairiporã, SP (07621-250)',
      itensList: ['Sofá', 'Mesa', 'Abacaxi'],
      price: 1020.10,
      requestCode: 8,
    ),
    const RequestCard(
      size: 'L',
      status: 'CA',
      destinationAddress:
          'Rua dos Flamboyants, 524 - Mairiporã, SP (07621-250)',
      itensList: ['Sofá', 'Mesa', 'Abacaxi'],
      price: 1020.10,
      requestCode: 9,
    ),
    const RequestCard(
      size: 'S',
      status: 'AG',
      destinationAddress:
          'Rua dos Flamboyants, 524 - Mairiporã, SP (07621-250)',
      itensList: ['Sofá', 'Mesa', 'Abacaxi'],
      price: 1020.10,
      requestCode: 10,
    ),
    const RequestCard(
      size: 'S',
      status: 'CO',
      destinationAddress:
          'Rua dos Flamboyants, 524 - Mairiporã, SP (07621-250)',
      itensList: ['Sofá', 'Mesa', 'Abacaxi'],
      price: 1020.10,
      requestCode: 11,
    ),
    const RequestCard(
      size: 'L',
      status: 'AG',
      destinationAddress:
          'Rua dos Flamboyants, 524 - Mairiporã, SP (07621-250)',
      itensList: ['Sofá', 'Mesa', 'Abacaxi'],
      price: 1020.10,
      requestCode: 12,
    ),
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
                            builder: (context) => RequestDetailScreen()));
                  },
                  child: RequestCard(
                    size: item.size,
                    status: item.status,
                    destinationAddress: item.destinationAddress,
                    itensList: item.itensList,
                    price: item.price,
                    requestCode: item.requestCode,
                  )),
              const CustomDivider(),
            ],
          );
        },
      ),
    );
  }
}
