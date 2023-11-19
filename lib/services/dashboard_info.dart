import 'package:mongo_dart/mongo_dart.dart';
import 'package:moveout1/services/device_info.dart';
import 'package:moveout1/services/requests.dart';

Future<double> getCurrentRating() async {
  
  double rating = 0;
  var transportList = await getTransportsInfo();

  if(transportList.isEmpty){
    return 0.0;
  }

  for(var transport in transportList){
    rating += transport?["rating"];
  }
  
  return (rating / transportList.length);
}

Future<double> getIncome(bool monthly) async {

  var transportList = await getTransportsInfo();
  late double income;
  List<ObjectId> requestIds = [];

  for(var transport in transportList){
    requestIds.add(transport?["request"]);
  }

  income = await getRequestsIncome(requestIds);
  
  return income;
}

Future<int> getTotalTransports() async {
  
  var transportList = await getTransportsInfo();
  
  return transportList.length;
}

Future<Map<dynamic, String>> getCurrentSubscription() async {

  return {"name": "Bronze", "color": "#B5A642"};
  // return {"name": "Prata", "color": "#AAAAAA"};
  // return {"name": "Ouro", "color": "#FFD700"};
  // return {"name": "Diamante", "color": "#0ABAB5"};
}