import 'dart:convert';
import 'package:moveout1/database/request_db.dart';
import 'package:shared_preferences/shared_preferences.dart';

void loginSave(userInfo) async {

  try {

    userInfo["userData"]["createdAt"] = userInfo["userData"]["createdAt"].toString();
    userInfo["userData"]["updatedAt"] = userInfo["userData"]["updatedAt"].toString();
    var prefs = await SharedPreferences.getInstance();
    var requests = await RequestDb.getInfoByField([userInfo["userData"]["cpf"]], "cpfClient");

    requests?.forEach((element) {
      element["createdAt"] = element["createdAt"].toString();
      element["updatedAt"] = element["updatedAt"].toString();
    });

    await prefs.setString('userData', json.encode(userInfo["userData"]));
    await prefs.setString('requestData', json.encode(requests));

  } catch (e) {
    print(e);
  }

}

Future<dynamic> getUserInfo() async {

  var prefs = await SharedPreferences.getInstance();
  final user = prefs.getString("userData") ?? "{}";

  return jsonDecode(user);

}

Future<dynamic> getRequestsInfo() async {

  var prefs = await SharedPreferences.getInstance();
  final requests = prefs.getString("requestData") ?? "{}";

  return jsonDecode(requests);

}