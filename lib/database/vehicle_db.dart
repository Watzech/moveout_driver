import 'package:moveout1/classes/vehicle.dart';

import '../constants/main.dart' as constants;
import 'package:mongo_dart/mongo_dart.dart';

String url = constants.URL_CONNECTION;
String vehicleCollectionURL = constants.VEHICLE_COLLECTION;

class VehicleDb{

  static Db? db;
  static DbCollection? vehicleCollection;

  static connect() async {

    try{
      db?.close();
    } catch (e){
      print(e);
    }

    try {
      
      db = await Db.create(url);
      await db?.open();

      db?.databaseName = "MoveOut";

      vehicleCollection = db?.collection(vehicleCollectionURL);

    } catch (e) {
      print(e);
    }
  }
  
  static Future<List<Map<String, dynamic>>?> getInfo() async {
    try {
      final vehicle = await vehicleCollection?.find(where.sortBy('_id')).toList();
      return vehicle;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<List<Map<String, dynamic>>?> getInfoByField(List<String> values, String fieldName) async {
    try {
      await connect();
      final itemList = await vehicleCollection?.find(where.oneFrom(fieldName, values)).toList();
      return itemList;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static insert(Vehicle vehicle) async {
    await connect();
    await vehicleCollection?.insertAll([vehicle.toMap()]);
  }

  static update(Vehicle vehicle) async {
    var u = await vehicleCollection?.findOne({"plate": vehicle.plate});

    u?["cnhDriver"] = vehicle.cnhDriver;
    u?["crlv"] = vehicle.crlv;
    u?["plate"] = vehicle.plate;
    u?["model"] = vehicle.model;
    u?["brand"] = vehicle.brand;
    u?["updatedAt"] = vehicle.updatedAt;

    await vehicleCollection?.replaceOne({"cnh": vehicle.plate}, u!);
  }

}