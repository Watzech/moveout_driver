
class Request {
  String? id;
  final String cpfClient;
  dynamic price;
  String originAddress;
  String destinyAddress;
  bool helpers;
  List<String> interesteds = [];
  List<dynamic> date = [];
  List<String> load;
  final DateTime createdAt;
  final DateTime updatedAt;

  Request({
    required this.cpfClient,
    required this.price,
    required this.originAddress,
    required this.destinyAddress,
    required this.date,
    required this.helpers,
    required this.load,
    required this.createdAt,
    required this.updatedAt,
    this.id
  });

  Map<String, dynamic> toMap() {
    return {
      'cpfClient': cpfClient,
      'price': price,
      'originAddress': originAddress,
      'destinyAddress': destinyAddress,
      'interesteds': interesteds,
      'date': date,
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
    date = map['date'],
    load = map['load'],
    createdAt = map['createdAt'],
    updatedAt = map['updatedAt'];
}