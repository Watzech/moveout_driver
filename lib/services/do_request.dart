import 'package:moveout1/classes/request.dart';
import 'package:moveout1/database/request_db.dart';

Future<void> doRequest(dynamic requestData) async {

  Request request = Request(
    origin: requestData["origin"],
    destination: requestData["destination"],
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    cpfClient: requestData["data"],
    price: requestData["price"],
    helpers: requestData["helpers"],
    load: requestData["load"],
    date: requestData["date"],
    status: "AG"
  );

  try {
    await RequestDb.connect();
    await RequestDb.insert(request);
  } catch (e) {
    print(e);
  }
}