import '../constants/main.dart' as constants;
import 'package:mongo_dart/mongo_dart.dart';
import './client.dart';

String url = constants.URL_CONNECTION;
String clientCollectionURL = constants.CLIENT_COLLECTION;

class Database{

  static Db? db;
  static DbCollection? clientCollection;

  static connect() async {
    if(db == null){
      db = await Db.create(url);
      await db?.open();
      clientCollection = db?.collection(clientCollectionURL);
    }
  }
  
  static Future<List<Map<String, dynamic>>?> getInfo() async {
    try {
      final users = await clientCollection?.find().toList();
      return users;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static insert(Client client) async {
    await clientCollection?.insertAll([client.toMap()]);
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