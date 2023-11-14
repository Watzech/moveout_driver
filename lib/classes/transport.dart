
import 'package:mongo_dart/mongo_dart.dart';

class Transport {
  final ObjectId id;
  final ObjectId request;
  final ObjectId driver;
  final ObjectId client;
  final ObjectId vehicle;
  String situation;
  int rating = 0;
  DateTime scheduledAt;
  DateTime finishedAt;
  final DateTime createdAt;
  DateTime updatedAt;

  Transport({
    required this.id,
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
      '_id': id,
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
    id = map['_id'],
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