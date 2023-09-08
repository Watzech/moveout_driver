Future<double> getRequestPrice(double distance, String size, double plus) async {

  double truck = 0;

  if (size == "P") {
    truck = 50;
  } else if (size == "M") {
    truck = 100;
  } else {
    truck = 170;
  }

  double km = 0;
  double obj = 1.3;

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

  return ((distance * 2) * km + (obj * plus) + truck);
}