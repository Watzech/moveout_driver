import 'dart:convert';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:moveout1/database/request_db.dart';
import 'package:moveout1/services/transport.dart';
import 'package:moveout1/services/vehicle.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Save
Future<void> saveNotificationToken(String? token) async{
  
  try {
    var prefs = await SharedPreferences.getInstance();
    var currentToken = await getNotificationToken();

    if(token != null && token != currentToken){
      await prefs.setString('token', token);
      await removeUserInfo();
    }

  } catch (e) {
    print(e);
  }
}

Future<void> loginSave(userInfo) async {

  userInfo["userData"]["createdAt"] = userInfo["userData"]["createdAt"].toString();
  userInfo["userData"]["updatedAt"] = userInfo["userData"]["updatedAt"].toString();
  var prefs = await SharedPreferences.getInstance();

  await prefs.setString('userData', json.encode(userInfo["userData"]));
  await getTransports();
  await getVehicleList();

}

Future<void> saveVehicle(vehicle) async {

  try {

    vehicle?.forEach((element) {
      element["createdAt"] = element["createdAt"].toString();
      element["updatedAt"] = element["updatedAt"].toString();
    });

    var prefs = await SharedPreferences.getInstance();

    await prefs.setString('vehicleData', json.encode(vehicle));

  } catch (e) {
    print(e);
  }

}

Future<void> saveTransports(transports) async {

  try {

    transports?.forEach((element) {
      element["createdAt"] = element["createdAt"].toString();
      element["updatedAt"] = element["updatedAt"].toString();
      element["scheduledAt"] = element["scheduledAt"].toString();
      element["finishedAt"] = element["finishedAt"]?.toString();
    });

    var prefs = await SharedPreferences.getInstance();

    await prefs.setString('transportsData', json.encode(transports));

  } catch (e) {
    print(e);
  }

}

Future<dynamic> saveTempRequest(String state, String search, bool ascending, String cnh, int limit, int offset) async {
  
  var prefs = await SharedPreferences.getInstance();
  dynamic expiration = prefs.containsKey("requestExpiration");
  dynamic requests = prefs.containsKey("requestData");

  if(expiration){
    expiration = prefs.getString("requestExpiration");
    expiration = DateTime.now().difference(DateTime.parse(expiration)).inMinutes >= 0;
  }
  else{
    expiration = true;
  }
  
  if(expiration || offset != 0){
    requests = await RequestDb.getFilteredInfo(state, search, ascending, cnh, limit, offset);
    expiration = DateTime.now().add(const Duration(minutes: 2)).toIso8601String();
  
    requests?.forEach((element) {
      element["createdAt"] = element["createdAt"].toString();
      element["updatedAt"] = element["updatedAt"].toString();
    });

    await prefs.setString('requestData', json.encode(requests));
    await prefs.setString('requestExpiration', expiration);
  }else{
    requests = prefs.getString("requestData");
    requests = json.decode(requests);
  }

  return requests;
}
// Save

// Get
Future<String?> getNotificationToken() async{
  
  try {

    var prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');

  } catch (e) {
    print(e);
    return null;
  }

}

Future<dynamic> getUserInfo() async {

  var prefs = await SharedPreferences.getInstance();
  final user = prefs.getString("userData") ?? "{}";

  return jsonDecode(user);

}

Future<dynamic> getVehicleInfo() async {

  var prefs = await SharedPreferences.getInstance();
  final vehicle = prefs.getString("vehicleData") ?? "[]";

  return jsonDecode(vehicle);

}

Future<List<dynamic>> getTransportsInfo() async {

  var prefs = await SharedPreferences.getInstance();
  final transports = prefs.getString("transportsData") ?? "[]";

  return jsonDecode(transports);
}

Future<dynamic> getRequest(ObjectId id) async {
  List<dynamic>? requestList = await RequestDb.getInfoByField([id], "_id");

  return requestList![0];
}
// Get

// Remove
Future<void> removeUserInfo() async {

  var prefs = await SharedPreferences.getInstance();
  prefs.setString("userData", "{}");
  prefs.remove("requestData");

}
// Remove