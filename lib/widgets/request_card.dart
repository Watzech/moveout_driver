import 'dart:ffi';

import 'package:flutter/material.dart';

class CustomIcons {
  CustomIcons._();

  static const _kFontFam = 'CustomIcons';
  static const String? _kFontPkg = null;

  static const IconData truck =
      IconData(0xf0d1, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData truckMoving =
      IconData(0xf4df, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData truckPickup =
      IconData(0xf63c, fontFamily: _kFontFam, fontPackage: _kFontPkg);
}

class RequestCard extends StatelessWidget {
  final String size;
  final String status;
  final String destinationAddress;
  final int requestCode;

  const RequestCard(
      {super.key,
      required this.size,
      required this.status,
      required this.destinationAddress,
      required this.requestCode});

  @override
  Widget build(BuildContext context) {
    IconData icon;
    switch (size) {
      case 'S':
        icon = CustomIcons.truckPickup;
        break;
      case 'M':
        icon = CustomIcons.truck;
        break;
      case 'L':
        icon = CustomIcons.truckMoving;
        break;
      default:
        icon = Icons.error;
        break;
    }
    Color statusColor;
    String statusText;
    switch (status) {
      case 'CO': //Concluído
        statusColor = Colors.green;
        statusText = 'Concluído';
        break;
      case 'CA': //Cancelado
        statusColor = Colors.grey;
        statusText = 'Cancelado';
        break;
      case 'EA': //Em Aberto
        statusColor = Theme.of(context).colorScheme.secondary;
        statusText = 'Em Aberto';
        break;
      case 'AG': //Agendado
        statusColor = Colors.blue;
        statusText = 'Agendado';
        break;
      default:
        statusColor = Colors.red;
        statusText = 'ERRO';
        break;
    }
    return SizedBox(
      height: 115,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Column(
            children: [
              Expanded(
                child: SizedBox(
                  width: 8,
                  child: ColoredBox(color: statusColor),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  // color: Theme.of(context).colorScheme.secondary,
                  color: statusColor,
                  size: 50,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
            child: Column(
              children: [
                Expanded(
                  child: SizedBox(
                    width: 2,
                    child: ColoredBox(color: Colors.grey.shade200),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Pedido $requestCode ',
                      style: TextStyle(
                        fontFamily: 'BebasKai',
                        fontSize: 20,
                        color: statusColor,
                      ),
                    ),
                    Icon(
                      Icons.circle,
                      color: statusColor,
                      size: 5,
                    ),
                    Text(
                      ' $statusText',
                      style: TextStyle(
                        fontFamily: 'BebasKai',
                        fontSize: 20,
                        color: statusColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Destino: ',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      destinationAddress,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
