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

void addRequestInfo(dynamic newRequest) async {

  var prefs = await SharedPreferences.getInstance();
  final requestsData = prefs.getString("requestData") ?? "[]";

  List<dynamic> requests = jsonDecode(requestsData);

  newRequest["createdAt"] = newRequest["createdAt"].toString();
  newRequest["updatedAt"] = newRequest["updatedAt"].toString();

  requests.add(newRequest);

  await prefs.setString('requestData', json.encode(requests));

}

void removeRequestsInfo(String createdAt) async {

  var prefs = await SharedPreferences.getInstance();
  final requestsData = prefs.getString("requestData") ?? "[]";

  List<dynamic> requests = jsonDecode(requestsData);

  requests.removeWhere((element) => element["createdAt"] == createdAt);

  await prefs.setString('requestData', json.encode(requests));

}