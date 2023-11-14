// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:moveout1/classes/request.dart';
import 'package:moveout1/widgets/profile_image_container.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:moveout1/widgets/request_card.dart';

import '../widgets/profile_screen_widgets/driver_summary_container.dart';
import '../widgets/profile_screen_widgets/driver_summary_element.dart';

const String emptyValidationFail = 'Este campo é obrigatório.';
const String submitValidationFail = 'Erro de validação, verifique os campos';
void main() {
  runApp(const ProfileScreen(userData: null,));
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.userData});
  final dynamic userData;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    //   var requestsByUser = await getRequestsInfo();

    //   List<Request> req = [];
    //   requestsByUser?.forEach((element) {
    //     req.add(Request(
    //         id: ObjectId.parse(element['_id']),
    //         cpfClient: element['cpfClient'],
    //         price: element['price'],
    //         origin: element['origin'],
    //         destination: element['destination'],
    //         distance: element['distance'],
    //         date: element['date'],
    //         helpers: element['helpers'],
    //         load: element['load'],
    //         createdAt: DateTime.parse(element['createdAt']),
    //         updatedAt: DateTime.parse(element['updatedAt']),
    //         status: element['status']));
    //   });
    //   setState(() {
    //     _rawRequests = req;
    //     _filteredRequests = req;
    //   });
    // });
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
    final reaisFormatter = NumberFormat("'R\$:' #,##0.00", Intl.defaultLocale);
    final containerWidth = screenWidth * 0.85;

    return Stack(children: [
      Image.asset(
        "assets/images/backgrounds/mbl_bg_1.png",
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_rounded,
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
                    // height: screenHeight*0.2,
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
                                  : 'Carregando...', //erro de overflow caso o texto seja grande
                              textAlign: TextAlign.left,
                              maxLines: 1,
                              style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            RatingBar.builder(
                              initialRating: 2.5,
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
                    containerHeight: screenHeight * 0.16,
                    childrenWidgets: [
                      IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: DriverSummaryElement(
                                  title: 'Lucro Mensal',
                                  content: reaisFormatter.format(1200)),
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
                                  content: reaisFormatter.format(1200)),
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
                                    titleSize: screenHeight * 0.013,
                                    content: reaisFormatter.format(3300),
                                    contentSize: screenHeight * 0.016),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                DriverSummaryElement(
                                    title: 'Transportes Feitos',
                                    titleSize: screenHeight * 0.013,
                                    content: 12.toString(),
                                    contentSize: screenHeight * 0.016),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                DriverSummaryElement(
                                    title: 'Lucro Total',
                                    titleSize: screenHeight * 0.013,
                                    content: reaisFormatter.format(3300),
                                    contentSize: screenHeight * 0.016),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ]),
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
                    containerHeight: screenHeight * 0.25,
                    childrenWidgets: [
                      // Expanded(
                      //   child: ListView.builder(
                      //     padding: const EdgeInsets.all(0),
                      //     itemCount: _filteredRequests.length,
                      //     itemBuilder: (context, index) {
                      //       final item = _filteredRequests[index];
                      //       return Column(
                      //         children: [
                      //           InkWell(
                      //               onTap: () {
                      //                 Navigator.of(context)
                      //                     .push(_createRoute(item));
                      //               },
                      //               child: RequestCard(request: item)),
                      //           Divider(
                      //             height: 0.25,
                      //             color: Colors.grey[200],
                      //           ),
                      //         ],
                      //       );
                      //     },
                      //   ),
                      // ),
                    ]),
                const Spacer(
                  flex: 1,
                ),
                // DriverSummaryContainer(
                //     containerWidth: containerWidth,
                //     containerHeight: screenHeight * 0.25,
                //     childrenWidgets: [
                //       const Row(
                //         children: [],
                //       )
                //     ]),
                // const Spacer(
                //   flex: 1,
                // ),
              ],
            ),
          ]),
        ),
      ),
    ]);
  }
}
