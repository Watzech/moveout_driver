class Request {
  String? id;
  final String cpfClient;
  dynamic price;
  dynamic origin;
  dynamic destination;
  dynamic distance;
  bool helpers;
  List<String> interesteds = [];
  List<dynamic> date = [];
  Map<dynamic, dynamic> load;
  final DateTime createdAt;
  final DateTime updatedAt;
  String status;

  Request(
      {required this.cpfClient,
      required this.price,
      required this.origin,
      required this.destination,
      required this.distance,
      required this.date,
      required this.helpers,
      required this.load,
      required this.createdAt,
      required this.updatedAt,
      required this.status,
      this.id});

  Map<String, dynamic> toMap() {
    return {
      'cpfClient': cpfClient,
      'price': price,
      'origin': origin,
      'destination': destination,
      'distance': distance,
      'interesteds': interesteds,
      'date': date,
      'helpers': helpers,
      'load': load,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'status': status
    };
  }

  Request.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        cpfClient = map['cpfClient'],
        price = map['price'],
        origin = map['origin'],
        destination = map['destination'],
        distance = map['distance'],
        helpers = map['helpers'],
        interesteds = map['interesteds'],
        date = map['date'],
        load = map['load'],
        createdAt = map['createdAt'],
        status = map['status'],
        updatedAt = map['updatedAt'];
}
