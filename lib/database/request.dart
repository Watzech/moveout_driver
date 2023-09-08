
import 'package:moveout1/database/vehicle.dart';

class Request {
  final String id;
  final String cpfClient;
  final double price;
  final String originAddress;
  final String destinyAddress;
  final int helpers;
  List<Vehicle> interesteds = [];
  final String load;
  final DateTime createdAt;
  final DateTime updatedAt;

  Request({
    required this.id,
    required this.cpfClient,
    required this.price,
    required this.originAddress,
    required this.destinyAddress,
    required this.helpers,
    required this.load,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'cpfClient': cpfClient,
      'price': price,
      'originAddress': originAddress,
      'destinyAddress': destinyAddress,
      'interesteds': interesteds,
      'helpers': helpers,
      'load': load,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  Request.fromMap(Map<String, dynamic> map) :
    id = map['id'],
    cpfClient = map['cpfClient'],
    price = map['price'],
    originAddress = map['originAddress'],
    destinyAddress = map['destinyAddress'],
    helpers = map['helpers'],
    interesteds = map['interesteds'],
    load = map['load'],
    createdAt = map['createdAt'],
    updatedAt = map['updatedAt'];
}