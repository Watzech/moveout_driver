
class Vehicle {
  final String cnhDriver;
  final String crlv;
  final String plate;
  final String model;
  final String brand;
  final DateTime createdAt;
  final DateTime updatedAt;

  Vehicle({
    required this.cnhDriver,
    required this.crlv,
    required this.plate,
    required this.model,
    required this.brand,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'cnhDriver': cnhDriver,
      'crlv': crlv,
      'plate': plate,
      'model': model,
      'brand': brand,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  Vehicle.fromMap(Map<String, dynamic> map) :
    cnhDriver = map['cnhDriver'],
    crlv = map['crlv'],
    plate = map['plate'],
    model = map['model'],
    brand = map['brand'],
    createdAt = map['createdAt'],
    updatedAt = map['updatedAt'];
}