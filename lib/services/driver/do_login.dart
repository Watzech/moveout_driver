import 'package:moveout1/classes/driver.dart';
import 'package:moveout1/database/driver_db.dart';

Future<bool> doSignup(String name, String cpf, String phone, String email, String password, var photo, var cnh, String address, DateTime createdAt, DateTime updatedAt) async {

  Driver driver = Driver(name: name, cpf: cpf, phone: phone, cnh: cnh, email: email, password: password, photo: photo, address: address, createdAt: createdAt, updatedAt: updatedAt);

  try {
    await DriverDb.connect();
    
    var emailExistList = await DriverDb.getInfoByField([email], "email");
    var cpfExistList = await DriverDb.getInfoByField([cpf], "cpf");
    var cnhxistList = await DriverDb.getInfoByField([cnh], "cnh");

    bool emailExists = emailExistList != null && emailExistList.isNotEmpty;
    bool cpfExists = cpfExistList != null && cpfExistList.isNotEmpty;
    bool cnhExists = cnhxistList != null && cnhxistList.isNotEmpty;

    if(!cpfExists && !emailExists && !cnhExists){
      await DriverDb.insert(driver);
      return true;
    }
    else{
      print("Email ou CPF já existe");
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