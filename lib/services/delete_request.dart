import 'package:moveout1/classes/request.dart';
import 'package:moveout1/database/request_db.dart';
import 'package:moveout1/services/device_info.dart';

Future<void> cancelRequest(Request request) async {
  
  try {
    await RequestDb.update(request);
    await changeRequestSituation(request.id, "CA");
  } catch (e) {
    print(e);
  }
}