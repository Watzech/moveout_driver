import 'package:mongo_dart/mongo_dart.dart';
import 'package:moveout1/classes/request.dart';
import 'package:moveout1/database/request_db.dart';
import 'package:moveout1/services/device_info.dart';

Future<List<dynamic>?> getRequests(String state, String search, bool ascending, int limit, int offset) async {

  dynamic user = await getUserInfo();
  List<dynamic>? requestList = await saveTempRequest(state, search, ascending, user["cnh"], limit, offset);
  return requestList;

}

Future<bool> applyRequest(Request request) async {
  dynamic user = await getUserInfo();
  request.interesteds.add(user['cnh']);

  bool done = await RequestDb.update(request);

  return done;
}

Future<double> getRequestsIncome(List<ObjectId> ids) async {

  double income = 0;
  
  if(ids.isNotEmpty){
    List<Map<String, dynamic>>? requestList = await RequestDb.getInfoByField(ids, "_id");

    if(requestList!.isNotEmpty){
      for(var request in requestList){
        if(request["status"] == "CO"){
          income += request["price"]["finalPrice"];
        }
      }
    }
  }

  return income;
}