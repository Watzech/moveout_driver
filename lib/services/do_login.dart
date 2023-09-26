import 'package:moveout1/classes/client.dart';
import 'package:moveout1/database/client_db.dart';

Future<bool> doSignup(String name, String cpf, String phone, String email, String password, var photo, String address, DateTime createdAt, DateTime updatedAt) async {

  Client client = Client(name: name, cpf: cpf, phone: phone, email: email, password: password, photo: photo, address: address, createdAt: createdAt, updatedAt: updatedAt);

  try {
    await ClientDb.connect();
    
    var emailExistList = await ClientDb.getInfoByField([email], "email");
    var cpfExistList = await ClientDb.getInfoByField([cpf], "cpf");

    bool emailExists = emailExistList != null && emailExistList.isNotEmpty;
    bool cpfExists = cpfExistList != null && cpfExistList.isNotEmpty;

    if(!cpfExists && !emailExists){
      await ClientDb.insert(client);
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

Future<bool> doLogin(String email, String password) async {

  try {
    await ClientDb.connect();
    
    dynamic userList = await ClientDb.getInfoByField([email], "email");

    if(userList != null && userList.isNotEmpty){
      bool isEqual = false;

      userList.forEach((element) { 
        if(element['password'] == password){
          isEqual = true;
        }
      });

      return isEqual; 
    }
    else{
      return false;
    }

  } catch (e) {
    print(e);
    return false;
  }

}