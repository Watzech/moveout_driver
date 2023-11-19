// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mongo_dart/mongo_dart.dart' show ObjectId;
import 'package:moveout1/classes/request.dart';
import 'package:moveout1/screens/request_detail.dart';
import 'package:moveout1/services/dashboard_info.dart';
import 'package:moveout1/services/device_info.dart';
import 'package:moveout1/widgets/custom_drawer.dart';
import 'package:moveout1/widgets/profile_image_container.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:moveout1/widgets/request_card.dart';

import '../widgets/profile_screen_widgets/driver_summary_container.dart';
import '../widgets/profile_screen_widgets/driver_summary_element.dart';

const String emptyValidationFail = 'Este campo é obrigatório.';
const String submitValidationFail = 'Erro de validação, verifique os campos';
void main() {
  runApp(const DashboardScreen(
    userData: null,
  ));
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key, required this.userData});
  final dynamic userData;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  var subscriptionInfo;
  double rating = 0;
  double monthlyIncome = 0;
  double totalIncome = 0;
  List<Request> transports = [];

  // Future<void> getDashboardInfo() async {
  //   final String patientPhone = await

  //   setState(() => _patientPhone = patientPhone);
  // }

  Route _createRoute(Request item) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          RequestDetailScreen(request: item),
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
      double ratingHelper = await getCurrentRating();
      var requestsByUser = await getTransportsInfo();
      var subscribe = await getCurrentSubscription();
      var monthlyIncomeValue = await getIncome(true);
      var totalIncomeValue = await getIncome(false);
      for (var element in requestsByUser) {
        transports.add(Request(
          id: ObjectId.parse(element['_id']),
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
          status: element['status'])
        );
      }

      setState(() {
        rating = ratingHelper;
        subscriptionInfo = subscribe;
        monthlyIncome = monthlyIncomeValue;
        totalIncome = totalIncomeValue;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarContrastEnforced: true,
      ),
    );
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double summaryTitleSize = screenHeight * 0.013;
    final double summaryContentSize = screenHeight * 0.016;
    final reaisFormatter = NumberFormat("'R\$:' #,##0.00", Intl.defaultLocale);
    final containerWidth = screenWidth * 0.85;
    final GlobalKey<ScaffoldState> key = GlobalKey();

    return Stack(children: [
      Image.asset(
        "assets/images/backgrounds/mbl_bg_1.png",
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
      Scaffold(
        key: key,
        drawer: CustomDrawer(
          userData: widget.userData,
          context: context,
        ),
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: InkWell(
              // onTap: () {
              //   Navigator.pop(context);
              // },
              // child: Icon(
              //   Icons.arrow_back_rounded,
              //   color: Theme.of(context).colorScheme.secondary,
              //   size: 30,
              // )),
              onTap: () {
                key.currentState!.openDrawer();
              },
              child: Icon(
                Icons.format_list_bulleted,
                color: Theme.of(context).colorScheme.secondary,
                size: 30,
              )),
          backgroundColor: Colors.transparent,
        ),
        body: SafeArea(
          //minimum: const EdgeInsets.all(15.0),
          child: Stack(children: [
            Column(
              children: [
                SizedBox(
                  height: screenHeight * 0.22,
                ),
                Expanded(
                  child: Container(
                    width: screenWidth,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(65),
                      ),
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 5, 15, 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ImageContainer(
                        photoString: widget.userData['photo'],
                        imageSize: screenHeight * 0.115,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.userData != null
                                  ? widget.userData['name']
                                  : 'Carregando...',
                              textAlign: TextAlign.left,
                              maxLines: 1,
                              style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            RatingBar.builder(
                              // initialRating: rating,
                              initialRating: rating,
                              allowHalfRating: true,
                              minRating: 0,
                              direction: Axis.horizontal,
                              ignoreGestures: true,
                              itemSize: screenWidth * 0.05,
                              itemCount: 5,
                              itemPadding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                size: 1,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                              onRatingUpdate: (value) {},
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                DriverSummaryContainer(
                    containerWidth: containerWidth,
                    containerHeight: screenHeight * 0.2,
                    childrenWidgets: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IntrinsicHeight(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: DriverSummaryElement(
                                    title: 'Lucro Mensal',
                                    // content: getMonthlyIncome(),
                                    content: reaisFormatter.format(monthlyIncome)),
                              ),
                              const VerticalDivider(
                                width: 10,
                                thickness: 1,
                                indent: 15,
                                endIndent: 0,
                                color: Colors.grey,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: DriverSummaryElement(
                                  title: 'Assinatura',
                                  content: subscriptionInfo ?? 'Carregando'
                                ),
                              )
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  DriverSummaryElement(
                                      title: 'Lucro Total',
                                      titleSize: summaryTitleSize,
                                      content: reaisFormatter.format(totalIncome),
                                      contentSize: summaryContentSize),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  DriverSummaryElement(
                                      title: 'Transportes Feitos',
                                      titleSize: summaryTitleSize,
                                      content: transports.length.toString(),
                                      contentSize: summaryContentSize),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  DriverSummaryElement(
                                      title: 'Créditos',
                                      titleSize: summaryTitleSize,
                                      content: '7',
                                      contentSize: summaryContentSize),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
                const Spacer(
                  flex: 1,
                ),
                Center(
                  child: Text(
                    'Pedidos em Andamento:',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                DriverSummaryContainer(
                  containerWidth: containerWidth,
                  containerHeight: screenHeight * 0.45,
                  childrenWidgets: Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(0),
                      itemCount: transports.length,
                      itemBuilder: (context, index) {
                        final item = transports[index];
                        return Column(
                          children: [
                            InkWell(
                                onTap: () {
                                  Navigator.of(context)
                                      .push(_createRoute(item));
                                },
                                child: RequestCard(request: item)),
                            Divider(
                              height: 0.25,
                              color: Colors.grey[200],
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                const Spacer(
                  flex: 1,
                ),
              ],
            ),
          ]),
        ),
      ),
    ]);
  }
}
