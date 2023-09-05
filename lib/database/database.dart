import '../constants/main.dart' as constants;
import 'package:mongo_dart/mongo_dart.dart';
import './client.dart';

String url = constants.URL_CONNECTION;
String clientCollectionURL = constants.CLIENT_COLLECTION;

class Database{

  static Db? db;
  static DbCollection? clientCollection;

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

      clientCollection = db?.collection(clientCollectionURL);

    } catch (e) {
      print(e);
    }
  }
  
  static Future<List<Map<String, dynamic>>?> getInfo() async {
    try {
      final users = await clientCollection?.find(where.sortBy('_id')).toList();
      return users;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static insert(Client client) async {
    await connect();
    await clientCollection?.insertAll([client.toMap()]);

    // var ret = await collection.insertMany(<Map<String, dynamic>>[
    //   {'_id': 1, 'name': 'Tom', 'state': 'active', 'rating': 100, 'score': 5},
    //   {'_id': 2, 'name': 'William', 'state': 'busy', 'rating': 80, 'score': 4},
    //   {'_id': 3, 'name': 'Liz', 'state': 'on hold', 'rating': 70, 'score': 8},
    //   {'_id': 4, 'name': 'George', 'state': 'active', 'rating': 95, 'score': 8},
    //   {'_id': 5, 'name': 'Jim', 'state': 'idle', 'rating': 40, 'score': 3},
    //   {'_id': 6, 'name': 'Laureen', 'state': 'busy', 'rating': 87, 'score': 8},
    //   {'_id': 7, 'name': 'John', 'state': 'idle', 'rating': 72, 'score': 7}
    // ]);

    // if (!ret.isSuccess) {
    //   print('Error detected in record insertion');
    // }
  }

  static update(Client client) async {
    var u = await clientCollection?.findOne({"cpf": client.cpf});

    u?["name"] = client.name;
    u?["phone"] = client.phone;
    u?["email"] = client.email;
    u?["password"] = client.password;
    u?["photo"] = client.photo;
    u?["address"] = client.address;
    u?["updatedAt"] = client.updatedAt;

    await clientCollection?.replaceOne({"cpf": client.cpf}, u!);
  }

}