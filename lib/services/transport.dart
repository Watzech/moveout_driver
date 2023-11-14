import 'package:moveout1/database/transport_db.dart';
import 'package:moveout1/services/device_info.dart';

Future<List<Map<String, dynamic>>?> getTransports() async {

  try {
    
    var driver = await getUserInfo();
    var cnhDriver = driver["cnh"];
    var transportList = await TransportDb.getInfoByField([cnhDriver], "driver");

    await saveTransports(transportList);

    return transportList;

  } catch (e) {
    print(e);
    return null;
  }

}