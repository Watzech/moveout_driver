import 'package:moveout1/classes/request.dart';
import 'package:moveout1/database/request_db.dart';
import 'package:moveout1/services/device_info.dart';

Future<List<Map<String, dynamic>>?> getRequests(String state, String search, bool ascending, int limit, int offset) async {

  dynamic user = await getUserInfo();
  List<Map<String, dynamic>>? requestList = await saveTempRequest(state, search, ascending, user["_id"], limit, offset);

  return requestList;

}

Future<bool> applyRequest(Request request) async {
  dynamic user = await getUserInfo();
  request.interesteds.add(user["_id"]);

  bool done = await RequestDb.update(request);

  return done;
}