import 'package:firebase_database/firebase_database.dart';
import 'package:flameandcoal/Constant%20Folder/Constant%20File.dart';
import 'package:flameandcoal/Menu/select%20menu.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

final database = FirebaseDatabase.instance.reference();

class FCDeals extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: Deals(),
    );
  }
}

class Deals extends StatefulWidget {
  @override
  _DealsState createState() => _DealsState();
}

class _DealsState extends State<Deals> {
  double height;
  double width;

  final List<String> image = <String>[
    'assets/images/category/cate1.jpg',
    'assets/images/category/cate2.jpg',
    'assets/images/category/cate2.jpg',
    'assets/images/category/cate2.jpg',
    'assets/images/category/cate2.jpg',
    'assets/images/category/cate2.jpg',
    'assets/images/category/cate2.jpg',
    'assets/images/category/cate2.jpg',
    'assets/images/category/cate2.jpg',
    'assets/images/category/cate2.jpg',
  ];

  var deal = 'dealofday';

  List data;
  bool isLoading = false;

  void _getdealsmenu() {
    database.child(deal).once().then((DataSnapshot snapshot) {
      setState(() {
        isLoading = true;
        Map<dynamic, dynamic> map = snapshot.value;
        data = map.values.toList();
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getdealsmenu();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: isLoading == false
          ? Container(
              child: Column(
                children: [
                  Center(
                    child: Container(
                        margin: EdgeInsets.only(top: height * 0.3),
                        child: Image.asset(
                          'assets/images/gifs/loading.gif',
                          height: height * 0.2,
                        )),
                  ),
                  Text("Loading...", style: LoadingText),
                ],
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    overflow: Overflow.visible,
                    children: [
                      Container(
                        width: width * 1.0,
                        height: height * 0.4,
                        decoration: BoxDecoration(
                          color: Color(0xFFFFBD2F),
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(200),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: height * 0.07, left: width * 0.05),
                        child: Text(
                          'Exclusive Deals & \nPromotion',
                          style: FCDealsTitle,
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(top: height * 0.20),
                          height: height * 0.3,
                          width: width * 1.0,
                          child: ListView(
                            children: [
                              CarouselSlider(
                                  items: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 5,
                                        ),
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/deals/deal1.jpg'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 5,
                                          ),
                                          image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/deals/deal2.jpg'),
                                            fit: BoxFit.cover,
                                          )),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 5,
                                          ),
                                          image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/deals/deal3.jpg'),
                                            fit: BoxFit.cover,
                                          )),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 5,
                                          ),
                                          image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/deals/deal4.jpg'),
                                            fit: BoxFit.cover,
                                          )),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 5,
                                          ),
                                          image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/deals/deal5.jpg'),
                                            fit: BoxFit.cover,
                                          )),
                                    ),
                                  ],
                                  options: CarouselOptions(
                                    height: height * 0.30,
                                    enlargeCenterPage: true,
                                    autoPlay: true,
                                    aspectRatio: 16 / 8,
                                    autoPlayCurve: Curves.easeInOutCubic,
                                    enableInfiniteScroll: true,
                                    autoPlayAnimationDuration:
                                        Duration(milliseconds: 1000),
                                    viewportFraction: 0.85,
                                  )),
                            ],
                          ))
                    ],
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: data == null ? 0 : data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          width: width * 0.9,
                          height: height * 0.28,
                          margin: EdgeInsets.only(bottom: height * 0.02),
                          child: Card(
                            elevation: 12,
                            shadowColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                        margin:
                                            EdgeInsets.only(left: width * 0.3),
                                        child: Text(
                                          data[index]['productname'],
                                          style: FCDealsheadingText,
                                        )),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(3),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xFFFFBD2F),
                                      ),
                                      child: CircleAvatar(
                                        radius: height * 0.05,
                                        backgroundImage: NetworkImage(
                                          data[index]['productimg'].toString(),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: width * 0.6,
                                      child: Text(
                                        data[index]['productdes'],
                                        textAlign: TextAlign.left,
                                        style: FCDealssubheadingText,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Container(
                                        child: Text(
                                            'Rs: ' +
                                                data[index]['productprice'] +
                                                '/-',
                                            style: FCDealsPriceText)),
                                    SizedBox(width: width * 0.05),
                                    Container(
                                        child: RaisedButton(
                                      elevation: 3,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(6.0),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    FCShowProduct(
                                                      productname: data[index]
                                                          ['productname'],
                                                      name: data[index]
                                                          ['productcat'],
                                                      menu: deal,
                                                    )));
                                      },
                                      color: Color(0xFFFFBD2F),
                                      child: Text(
                                        'Order',
                                        style: TextStyle(
                                            fontFamily: 'Circularstd-Med'),
                                      ),
                                    )),
                                    SizedBox(width: width * 0.05),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ],
              ),
            ),
    );
  }
}
