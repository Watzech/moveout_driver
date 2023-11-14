import 'package:moveout1/classes/driver.dart';
import 'package:moveout1/classes/vehicle.dart';
import 'package:moveout1/database/driver_db.dart';
import 'package:moveout1/database/vehicle_db.dart';

Future<bool> doSignup(Driver driver, Vehicle vehicle) async {

  try {
    await DriverDb.connect();
    
    var emailExistList = await DriverDb.getInfoByField([driver.email], "email");
    var cpfExistList = await DriverDb.getInfoByField([driver.cpf], "cpf");
    var cnhExistList = await DriverDb.getInfoByField([driver.cnh], "cnh");

    var plateExistList = await VehicleDb.getInfoByField([vehicle.plate], "plate");

    bool emailExists = emailExistList != null && emailExistList.isNotEmpty;
    bool cpfExists = cpfExistList != null && cpfExistList.isNotEmpty;
    bool cnhExists = cnhExistList != null && cnhExistList.isNotEmpty;
    bool plateExists = plateExistList != null && plateExistList.isNotEmpty;

    if(!cpfExists && !emailExists && !cnhExists && !plateExists){
      await VehicleDb.insert(vehicle);
      await DriverDb.insert(driver);
      return true;
    }
    else{
      print("Email, CPF ou CNH já foi cadastrado");
      return false;
    }
  } catch (e) {
    print(e);
    return false;
  }

}

Future<dynamic> doLogin(String email, String password) async {
  Map<String, dynamic> result = {};

  try {
    await DriverDb.connect();
    
    dynamic userList = await DriverDb.getInfoByField([email], "email");

    if(userList != null && userList.isNotEmpty){

      userList.forEach((element) async { 
        if(element['password'] == password){

          result["userData"] = element;
          result["done"] = true;
        }
      });

      return result;
    }
    else{
      result["done"] = false;
      return result;
    }

  } catch (e) {
    print(e);
    result["done"] = false;
    return result;
  }

}