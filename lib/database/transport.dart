
import 'package:moveout1/database/client.dart';
import 'package:moveout1/database/driver.dart';
import 'package:moveout1/database/request.dart';
import 'package:moveout1/database/vehicle.dart';

enum Situation {
  running,
  completed,
  pending,
  canceled
}

class Transport {
  final Request request;
  final Vehicle vehicle;
  final Driver driver;
  final Client client;
  Situation situation;
  int rating = 0;
  DateTime scheduledAt;
  DateTime finishedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  Transport({
    required this.request,
    required this.vehicle,
    required this.driver,
    required this.client,
    required this.situation,
    required this.rating,
    required this.scheduledAt,
    required this.finishedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'request': request,
      'vehicle': vehicle,
      'driver': driver,
      'client': client,
      'situation': situation,
      'rating': rating,
      'scheduledAt': scheduledAt,
      'finishedAt': finishedAt,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  Transport.fromMap(Map<String, dynamic> map) :
    request = map['request'],
    vehicle = map['vehicle'],
    driver = map['driver'],
    client = map['client'],
    situation = map['situation'],
    rating = map['rating'],
    scheduledAt = map['scheduledAt'],
    finishedAt = map['finishedAt'],
    createdAt = map['createdAt'],
    updatedAt = map['updatedAt'];
}