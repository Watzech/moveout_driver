import 'package:moveout1/classes/request.dart';
import 'package:moveout1/database/request_db.dart';
import 'package:moveout1/services/device_info.dart';

Future<void> doRequest(dynamic requestData) async {
  
  try {
    Request request = Request(
      origin: requestData["origin"],
      destination: requestData["destination"],
      distance: requestData["distance"],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      cpfClient: requestData["cpf"],
      price: requestData["price"],
      helpers: requestData["helpers"],
      load: requestData["load"],
      date: requestData["date"],
      status: "EA"
    );
    await RequestDb.connect();
    await RequestDb.insert(request);

    addRequestInfo(request.toMap());
  } catch (e) {
    print(e);
  }
}