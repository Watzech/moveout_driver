import 'package:moveout1/classes/request.dart';
import 'package:moveout1/constants/main.dart' as constants;
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

  static Future<List<Map<String, dynamic>>?> getInfoByField(List<dynamic> values, String fieldName) async {
    try {
      await RequestDb.connect();
      final request = await requestCollection?.find(where.oneFrom(fieldName, values)).toList();
      return request;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<bool> removeByField(List<dynamic> values, String fieldName) async {
    try {
      await RequestDb.connect();
      await requestCollection?.deleteOne(where.oneFrom(fieldName, values));
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static insert(Request request) async {
    await connect();
    await requestCollection?.insertAll([request.toMap()]);
  }

  static Future<bool> update(Request request) async {
    try {
      await RequestDb.connect();
      var u = await requestCollection?.findOne({"_id": request.id});

      u?["cpfClient"] = request.cpfClient;
      u?["price"] = request.price;
      u?["origin"] = request.origin;
      u?["destination"] = request.destination;
      u?["helpers"] = request.helpers;
      u?["load"] = request.load;
      u?["interesteds"] = request.interesteds;
      u?["updatedAt"] = DateTime.now();
      u?["status"] = request.status;

      await requestCollection?.replaceOne({"_id": request.id}, u!);

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<List<Map<String, dynamic>>?> getFilteredInfo(String state, String search, bool ascending, ObjectId id, int limit, int offset) async {
    try {
      await RequestDb.connect();
      final request = await requestCollection?.find(
        where.match("location.origin.address", state).and(
          (
            where.match("location.origin.address", search)
          ).or(
            where.match("location.destination.address", search)
          )
        ).and(
          where.nin("interesteds", [id.toString()])
        ).sortBy("price.finalPrice", descending: !ascending ).skip(offset).limit(limit)
      ).toList();
      return request;
    } catch (e) {
      print(e);
      return null;
    }
  }

}