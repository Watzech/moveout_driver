import 'package:geocoding/geocoding.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:moveout1/constants/main.dart';

Future<List<dynamic>> getAddresses(String address) async {
  List<dynamic> places = [];
  
  try {

    List<Location> locations = await locationFromAddress(address);

    if (locations.isNotEmpty) {
      for (var location in locations) {
        List<Placemark> placemarks = await placemarkFromCoordinates(
            location.latitude, location.longitude);

        int maxPlacemarks = 3;

        for (int i = 0; i < placemarks.length && i < maxPlacemarks; i++) {
          Placemark placemark = placemarks[i];
          String? street = placemark.street;
          String? number = placemark.subThoroughfare;
          String? district = placemark.subLocality;
          String? city = placemark.subAdministrativeArea;
          String? state = placemark.administrativeArea;

          Map<String, dynamic> place = {};

          place["name"] = "$street $number, $district - $city, $state";
          place["latitude"] = location.latitude;
          place["longitude"] = location.longitude;

          places.add(place);
        }

      }

      return places;
    } else {
      dynamic place;
      place["name"] = "Endereço não encontrado";
      places.add(place);
      return places;
    }
  } catch (e) {
    print("Erro ao geocodificar: $e");
    dynamic place;
    place["name"] = "Endereço não encontrado";
    places.add(place);
    return places;
  }
}

Future<void> getDistance(dynamic fromPlace, dynamic toPlace) async {

  // var x = await getAddresses('Rua Braz Cubas 28, Vila Santista - Franco da Rocha');
  // print(x);

  // var y = await getAddresses('Rua dos Flamboyans 524, Mairiporã');
  // print(y);

  // await getDistance(x[0], y[0]);

  const baseUrl = 'https://maps.googleapis.com/maps/api/distancematrix/json';
  final origins = Uri.encodeComponent(fromPlace["name"].toString());
  final destinations = Uri.encodeComponent(toPlace["name"].toString());
  const units = 'imperial';

  final url = '$baseUrl?origins=$origins&destinations=$destinations&units=$units&key=$API_KEY';

  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      // Faça algo com os dados de distância (data)
      print(data);
    } else {
      // Lida com erros de requisição aqui
      print('Erro na requisição: ${response.statusCode}');
    }
  } catch (e) {
    // Lida com exceções aqui
    print('Erro na requisição: $e');
  }
}