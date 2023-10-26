import 'package:moveout1/database/request_db.dart';
import 'package:moveout1/services/device_info.dart';

Future<void> removeRequestByDate(String date) async {
  
  try {
    await RequestDb.removeByField([DateTime.parse(date)], "createdAt");
    removeRequestsInfo(date);
  } catch (e) {
    print(e);
  }
}