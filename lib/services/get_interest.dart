import 'package:moveout1/database/driver_db.dart';

Future<List<String>> getInterests(List<String> driversId) async{
  DriverDb.connect();
  List<String> drivers = DriverDb.getInfoByField(driversId, 'cnh') as List<String>;

  print(drivers);

  return drivers;
}