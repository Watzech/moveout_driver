import 'package:flutter/material.dart';
import 'package:moveout1/classes/request.dart';
import 'package:moveout1/screens/request_detail.dart';
import 'package:moveout1/services/requests.dart';
import 'package:moveout1/widgets/custom_divider.dart';
import 'package:moveout1/widgets/request_card.dart';

class RequestsScreen extends StatefulWidget {
  final dynamic userData;

  const RequestsScreen({super.key, required this.userData});

  @override
  State<RequestsScreen> createState() => _RequestsScreenState();
}

class CustomIcons {
  CustomIcons._();

  static const _kFontFam = 'CustomIcons';
  static const String? _kFontPkg = null;

  static const IconData truck =
      IconData(0xf0d1, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData truckMoving =
      IconData(0xf4df, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData truckPickup =
      IconData(0xf63c, fontFamily: _kFontFam, fontPackage: _kFontPkg);
}

class _RequestsScreenState extends State<RequestsScreen> {
  final TextEditingController _filterAddressTextController =
      TextEditingController();
  List<Request> _rawRequests = [];
  List<Request> _filteredRequests = [];
  bool isFiltered = false;
  bool ascending = false;
  bool descending = false;
  Color descendingIconColor = Colors.grey;
  Color ascendingIconColor = Colors.grey;
  String transportSize = ' ';
  Color sColor = Colors.grey;
  Color mColor = Colors.grey;
  Color lColor = Colors.grey;
  String dropdownValue = 'Distância';
  bool isLoading = false;

  Route _createRoute(Request item) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          RequestDetailScreen(request: item, userData: widget.userData),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  void toggleAscending() {
    if (ascending) {
      ascendingIconColor = Colors.grey;
      ascending = false;
    } else {
      ascendingIconColor = Theme.of(context).colorScheme.primary;
      ascending = true;
    }
    descendingIconColor = Colors.grey;
    descending = false;
  }

  void toggleDescending() {
    if (descending) {
      descendingIconColor = Colors.grey;
      descending = false;
    } else {
      descendingIconColor = Theme.of(context).colorScheme.primary;
      descending = true;
    }
    ascendingIconColor = Colors.grey;
    ascending = false;
  }

  void changeTruckSize(String value) {
    switch (value) {
      case 'S':
        if (transportSize == value) {
          setState(() {
            sColor = Colors.grey;
            transportSize = ' ';
          });
          break;
        }
        setState(() {
          sColor = Theme.of(context).colorScheme.primary;
          mColor = Colors.grey;
          lColor = Colors.grey;
        });
        transportSize = 'S';
        break;
      case 'M':
        if (transportSize == value) {
          setState(() {
            mColor = Colors.grey;
            transportSize = ' ';
          });
          break;
        }
        setState(() {
          sColor = Colors.grey;
          mColor = Theme.of(context).colorScheme.primary;
          lColor = Colors.grey;
        });
        transportSize = 'M';
        break;
      case 'L':
        if (transportSize == value) {
          setState(() {
            lColor = Colors.grey;
            transportSize = ' ';
          });
          break;
        }
        setState(() {
          sColor = Colors.grey;
          mColor = Colors.grey;
          lColor = Theme.of(context).colorScheme.primary;
        });
        transportSize = 'L';
        break;
    }
  }

  void resetFilters() {
    setState(() {
      isFiltered = false;
      _filteredRequests = List<Request>.from(_rawRequests);
      descendingIconColor = Colors.grey;
      descending = false;
      ascendingIconColor = Colors.grey;
      ascending = false;
      _filterAddressTextController.text = '';
      transportSize = ' ';
      sColor = Colors.grey;
      mColor = Colors.grey;
      lColor = Colors.grey;
    });
  }

  void setFilters(String field, String orderBy, String address) {
    List<Request> toFilter = List<Request>.from(_rawRequests);

    if (orderBy == 'None' &&
        (address.isEmpty || address == '') &&
        transportSize == ' ') {
      resetFilters();
      return;
    }

    if (orderBy != 'None') {
      if (field == 'Distância') {
        orderBy == 'Asc'
            ? toFilter.sort((a, b) => b.distance.compareTo(a.distance))
            : toFilter.sort((a, b) => a.distance.compareTo(b.distance));
      } else if (field == 'Valor') {
        orderBy == 'Asc'
            ? toFilter.sort((a, b) =>
                b.price["finalPrice"].compareTo(a.price["finalPrice"]))
            : toFilter.sort((a, b) =>
                a.price["finalPrice"].compareTo(b.price["finalPrice"]));
      }
    }

    if (!(address.isEmpty || address == '')) {
      address = address.toLowerCase();
      toFilter = toFilter.where((request) {
        final String destination =
            request.destination['address'].toString().toLowerCase();
        final String origin =
            request.origin['address'].toString().toLowerCase();
        return (origin.contains(address) || destination.contains(address));
      }).toList();
    }

    if (transportSize != ' ') {
      switch (transportSize) {
        case 'S':
          toFilter = toFilter.where((request) {
            return (request.price["truckSize"] == 'Small');
          }).toList();
          break;
        case 'M':
          toFilter = toFilter.where((request) {
            return (request.price["truckSize"] == 'Medium');
          }).toList();
          break;
        case 'L':
          toFilter = toFilter.where((request) {
            return (request.price["truckSize"] == 'Large');
          }).toList();
          break;
        default:
          transportSize = ' ';
          break;
      }
    }

    setState(() {
      isFiltered = true;
      _filteredRequests = List<Request>.from(toFilter);
    });
  }

  void showFilterDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          List<String> filterOptions = <String>['Distância', 'Valor'];
          double fontSize = MediaQuery.of(context).size.height * 0.018;
          double iconSize = MediaQuery.of(context).size.height * 0.03;

          return AlertDialog(
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            width: MediaQuery.sizeOf(context).width * 0.5,
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              border: Border.all(
                                  color: Theme.of(context).colorScheme.primary,
                                  width: 2),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: dropdownValue,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15)),
                              underline: Container(color: Colors.transparent),
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                color: Colors.white,
                              ),
                              selectedItemBuilder: (BuildContext context) {
                                return filterOptions.map((String value) {
                                  return Center(
                                    child: Text(
                                      dropdownValue,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: fontSize),
                                    ),
                                  );
                                }).toList();
                              },
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownValue = newValue!;
                                });
                              },
                              items: filterOptions
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontSize: fontSize),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                toggleDescending();
                              });
                            },
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              color: descendingIconColor,
                            )),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                toggleAscending();
                              });
                            },
                            icon: Icon(
                              Icons.keyboard_arrow_up,
                              color: ascendingIconColor,
                            )),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                            child: Container(
                              // width: MediaQuery.sizeOf(context).width * 0.5,
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              decoration: BoxDecoration(
                                // color: Theme.of(context).colorScheme.primary,
                                border: Border.all(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    width: 2),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: TextFormField(
                                controller: _filterAddressTextController,
                                style: TextStyle(
                                    fontSize: fontSize,
                                    color:
                                        Theme.of(context).colorScheme.primary),
                                decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.all(1),
                                    hintText: 'Pesquisar endereço...',
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                            onPressed: () {
                              setState(() {
                                changeTruckSize('S');
                              });
                            },
                            icon: Icon(
                              CustomIcons.truckPickup,
                              color: sColor,
                              size: iconSize,
                            )),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                changeTruckSize('M');
                              });
                            },
                            icon: Icon(
                              CustomIcons.truck,
                              color: mColor,
                              size: iconSize,
                            )),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                changeTruckSize('L');
                              });
                            },
                            icon: Icon(
                              CustomIcons.truckMoving,
                              color: lColor,
                              size: iconSize,
                            )),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {
                              setState(() {
                                resetFilters();
                              });
                              Navigator.pop(context);
                            },
                            child: const Text('Cancelar'),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                String orderBy = 'None';
                                String address = '';
                                if (ascending) orderBy = 'Asc';
                                if (descending) orderBy = 'Desc';
                                if (_filterAddressTextController
                                    .text.isNotEmpty) {
                                  address = _filterAddressTextController.text;
                                }
                                setFilters(dropdownValue, orderBy, address);
                              });
                              Navigator.pop(context);
                            },
                            child: const Text('Aplicar Filtros'),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {

      setState(() {
        isLoading = true;
      });

      var requestsByUser = await getRequests("SP", "", true, 20, 0);

      List<Request> req = [];

      requestsByUser?.forEach((element) {
        req.add(Request.fromMap(element));
      });

      setState(() {
        _rawRequests = req;
        _filteredRequests = req;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: const Text(
            'Pedidos',
            style: TextStyle(
                fontFamily: 'BebasKai', fontSize: 30, color: Colors.white),
          ),
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_rounded,
                color: Theme.of(context).colorScheme.secondary,
                size: 30,
              )),
          actions: [
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                child: !isFiltered
                    ? IconButton(
                        onPressed: () => showFilterDialog(context),
                        icon: Icon(Icons.filter_alt,
                            color: Theme.of(context).colorScheme.secondary,
                            size: 30))
                    : IconButton(
                        onPressed: () => resetFilters(),
                        icon: Icon(Icons.filter_alt_off,
                            color: Theme.of(context).colorScheme.secondary,
                            size: 30)))
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isLoading 
            ? Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ) 
            : _rawRequests.isEmpty
                ? const Center(
                    child: Text(
                      'Nenhum pedido encontrado!',
                      style: TextStyle(fontSize: 20, color: Colors.grey),
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(0),
                      itemCount: _filteredRequests.length,
                      itemBuilder: (context, index) {
                        final item = _filteredRequests[index];
                        return Column(
                          children: [
                            InkWell(
                                onTap: () {
                                  Navigator.of(context)
                                      .push(_createRoute(item));
                                },
                                child: RequestCard(request: item)),
                            const CustomDivider(),
                          ],
                        );
                      },
                    ),
                  ),
          ],
        ));
  }
}
