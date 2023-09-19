
class Request {
  final String id;
  final String cpfClient;
  double price;
  String originAddress;
  String destinyAddress;
  int helpers;
  List<String> interesteds = [];
  String load;
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