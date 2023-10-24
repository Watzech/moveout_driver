import 'package:moveout1/database/request_db.dart';

Future<List<Map<String, dynamic>>?> getRequests(String state, String search, bool ascending) async {

  RequestDb.connect();
  List<Map<String, dynamic>>? requestList = await RequestDb.getFilteredInfo(state, search, ascending);

  return requestList;

}