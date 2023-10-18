import 'package:geocoding/geocoding.dart';
import 'package:moveout1/constants/main.dart';

Future<List<dynamic>> getAddresses(String address) async {
  List<dynamic> places = [];
  
  try {

    List<Location> locations = await locationFromAddress(address);

    if (locations.isNotEmpty) {
      for (var location in locations) {
        List<Placemark> placemarks = await placemarkFromCoordinates(
            location.latitude, location.longitude);

        int maxPlacemarks = 5;

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
    // place["name"] = "Endereço não encontrado";
    places.add(place);
    return places;
  }
}

String getState(String address) {
  String siglaEncontrada = '';

  for (final sigla in STATES) {
    final regex = RegExp(r'\b' + sigla + r'\b');
    if (regex.hasMatch(address)) {
      siglaEncontrada = sigla;
      break;
    }
  }

  return siglaEncontrada;
}
