import 'package:flutter/material.dart';
import 'package:moveout1/classes/request.dart';
import 'package:moveout1/screens/request_detail.dart';
import 'package:moveout1/services/device_info.dart';
import 'package:moveout1/widgets/sliding_panel_widgets/custom_divider.dart';
import 'package:moveout1/widgets/request_card.dart';

class RequestsScreen extends StatefulWidget {
  RequestsScreen({super.key});

  @override
  State<RequestsScreen> createState() => _RequestsScreenState();
}

class _RequestsScreenState extends State<RequestsScreen> {
  List<Request> _requests = [];

  Route _createRoute(Request item) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => RequestDetailScreen(request: item),
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var requestsByUser = await getRequestsInfo();

      List<Request> req = [];
      requestsByUser?.forEach((element) {
        req.add(Request(
            cpfClient: element['cpfClient'],
            price: element['price'],
            origin: element['origin'],
            destination: element['destination'],
            distance: element['distance'],
            date: element['date'],
            helpers: element['helpers'],
            load: element['load'],
            createdAt: DateTime.parse(element['createdAt']),
            updatedAt: DateTime.parse(element['updatedAt']),
            status: element['status']));
      });
      setState(() {
        _requests = req;
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
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(0),
        itemCount: _requests.length,
        itemBuilder: (context, index) {
          final item = _requests[index];
          return Column(
            children: [
              InkWell(
                  onTap: () {
                    Navigator.of(context).push(_createRoute(item));
                  },
                  child: RequestCard(request: item)),
              const CustomDivider(),
            ],
          );
        },
      ),
    );
  }
}
