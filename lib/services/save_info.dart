import 'dart:convert';
import 'package:moveout1/database/request_db.dart';
import 'package:shared_preferences/shared_preferences.dart';

void saveInfo(userInfo) async {

  try {

    userInfo["userData"]["createdAt"] = userInfo["userData"]["createdAt"].toString();
    userInfo["userData"]["updatedAt"] = userInfo["userData"]["updatedAt"].toString();
    var prefs = await SharedPreferences.getInstance();
    var requests = await RequestDb.getInfoByField([userInfo["userData"]["cpf"]], "cpfClient");

    await prefs.setString('userData', json.encode(userInfo["userData"]));
    await prefs.setString('requestData', json.encode(requests));

  } catch (e) {
    print(e);
  }

}