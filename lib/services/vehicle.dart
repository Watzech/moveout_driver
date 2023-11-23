import 'package:moveout1/classes/vehicle.dart';
import 'package:moveout1/database/vehicle_db.dart';
import 'package:moveout1/services/device_info.dart';

Future<bool> addVehicle(Vehicle vehicle) async {

  try {
    
    var plateExistList = await VehicleDb.getInfoByField([vehicle.plate], "plate");
    bool plateExists = plateExistList != null && plateExistList.isNotEmpty;

    if(!plateExists){
      await VehicleDb.insert(vehicle);
      return true;
    }
    else{
      print("Placa já foi cadastrada");
      return false;
    }

  } catch (e) {
    print(e);
    return false;
  }

}

Future<List<Map<String, dynamic>>?> getVehicleList() async {

  try {
    
    var driver = await getUserInfo();
    var cnhDriver = driver["cnh"];
    var vehicleList = await VehicleDb.getInfoByField([cnhDriver], "cnhDriver");
    await saveVehicle(vehicleList);

    return vehicleList;

  } catch (e) {
    print("getVehicleList");
    print(e);
    return null;
  }

}