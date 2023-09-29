import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:moveout1/constants/main.dart';

Future<Map<String, dynamic>> getPrice(dynamic info) async {

  double distance =  info["distance"];
  String size =  info["size"];
  double plus =  info["plus"];
  bool helpers =  info["helpers"];
  bool wrapping =  info["wrapping"];

  double truck = 0;

  if (size == "P") {
    truck = 50;
  } else if (size == "M") {
    truck = 100;
  } else {
    truck = 170;
  }

  double km = 0;
  double obj = 5;
  int helper = helpers ? 120 : 0;
  int wrap = wrapping ? 50 : 0;

  if (distance * 2 <= 10) {
    km = 8.2;
  } else if (distance * 2 <= 60) {
    km = 3.3;
  } else if (distance * 2 <= 120) {
    km = 3;
  } else if (distance * 2 <= 300) {
    km = 2.7;
  } else if (distance * 2 <= 500) {
    km = 2;
  } else if (distance * 2 <= 800) {
    km = 1.9;
  } else if (distance * 2 <= 1000) {
    km = 1.8;
  } else if (distance * 2 >= 2400) {
    km = 1.6;
  } else {
    km = 1.5;
  }

  Map<String, dynamic> place = {};

  place["valuePerDistance"] = km*2;
  place["valueByLoad"] = obj*plus;
  place["valueByTruck"] = truck;
  place["valueByHelper"] = helper;
  place["wraping"] = wrap;
  place["finalPrice"] = km*2 + (obj*plus) + truck + helper + wrap;

  return place;

}

Future<Map<String, dynamic>> getQuote(dynamic fromPlace, dynamic toPlace, dynamic info) async {

  Map<String, dynamic> quote = {};
  
  const baseUrl = 'https://maps.googleapis.com/maps/api/distancematrix/json';
  final origins = Uri.encodeComponent(fromPlace["name"].toString());
  final destinations = Uri.encodeComponent(toPlace["name"].toString());
  const units = 'imperial';

  final url = '$baseUrl?origins=$origins&destinations=$destinations&units=$units&key=$API_KEY';

  try {

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {

      final data = json.decode(response.body);

      quote["price"] = await getPrice(info);

      quote["origin"] = data["origin_addresses"][0];
      // quote["originState"] = data["origin_addresses"][0];

      quote["destiny"] = data["destination_addresses"][0];
      // quote["destinyState"] = data["destination_addresses"][0];

      quote["distance"] = data["rows"][0]["elements"][0]["distance"]["value"]/1000;

      quote["travelDuration"] = data["rows"][0]["elements"][0]["duration"]["text"];

      quote["date"] = [info["date"][0], info["date"][1]];

      print(quote);

      return quote;

    } else {
      quote["error"] = 'Erro na requisição: ${response.statusCode}';
      print('Erro na requisição: ${response.statusCode}');

      return quote;
    }
  } catch (e) {
    quote["error"] = 'Erro na requisição: $e';
    print('Erro na requisição: $e');

    return quote;
  }
}