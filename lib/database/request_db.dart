import 'package:moveout1/database/request.dart';

import '../constants/main.dart' as constants;
import 'package:mongo_dart/mongo_dart.dart';

String url = constants.URL_CONNECTION;
String requestCollectionURL = constants.REQUEST_COLLECTION;

class RequestDb{

  static Db? db;
  static DbCollection? requestCollection;

  static connect() async {

    try{
      db?.close();
    } catch (e){
      print(e);
    }

    try {
      
      db = await Db.create(url);
      await db?.open();

      db?.databaseName = "MoveOut";

      requestCollection = db?.collection(requestCollectionURL);

    } catch (e) {
      print(e);
    }
  }
  
  static Future<List<Map<String, dynamic>>?> getInfo() async {
    try {
      final request = await requestCollection?.find(where.sortBy('_id')).toList();
      return request;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static insert(Request request) async {
    await connect();
    await requestCollection?.insertAll([request.toMap()]);
  }

  static update(Request request) async {
    var u = await requestCollection?.findOne({"id": request.id});

    u?["cpfClient"] = request.cpfClient;
    u?["price"] = request.price;
    u?["originAddress"] = request.originAddress;
    u?["destinyAddress"] = request.destinyAddress;
    u?["helpers"] = request.helpers;
    u?["load"] = request.load;
    u?["interesteds"] = request.interesteds;
    u?["updatedAt"] = request.updatedAt;

    await requestCollection?.replaceOne({"id": request.id}, u!);
  }

}