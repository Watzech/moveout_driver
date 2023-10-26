import 'package:moveout1/classes/request.dart';
import 'package:moveout1/database/request_db.dart';
import 'package:moveout1/services/device_info.dart';

Future<void> doRequest(dynamic requestData) async {
  
  try {
    Request request = Request(
      origin: requestData["origin"],
      destination: requestData["destination"],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      cpfClient: requestData["cpf"],
      price: requestData["price"],
      helpers: requestData["helpers"],
      load: requestData["load"],
      date: requestData["date"],
      status: "AG"
    );
    await RequestDb.connect();
    await RequestDb.insert(request);
    saveRequestsInfo(request.toMap());
  } catch (e) {
    print(e);
  }
}