import 'package:moveout1/classes/request.dart';
import 'package:moveout1/database/request_db.dart';

var cpf = 'xxx';

Future<void> doRequest(dynamic requestData) async {
  Request request = Request(
    originAddress: requestData["origin"],
    destinyAddress: requestData["destiny"],
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    cpfClient: cpf,
    price: requestData["price"],
    helpers: requestData["helpers"],
    load: requestData["load"],
    date: requestData["date"]
  );

  try {
    await RequestDb.connect();
    await RequestDb.insert(request);
  } catch (e) {
    print(e);
  }
}