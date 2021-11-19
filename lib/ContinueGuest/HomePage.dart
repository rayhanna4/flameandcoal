import 'dart:ui';
import 'package:firebase_database/firebase_database.dart';
import 'package:flameandcoal/Constant%20Folder/Constant%20File.dart';
import 'package:flameandcoal/ContinueGuest/guestLogin.dart';
import 'package:flameandcoal/ContinueGuest/singal%20Menu.dart';
import 'package:flutter/material.dart';
import 'package:rotated_corner_decoration/rotated_corner_decoration.dart';

final database = FirebaseDatabase.instance.reference();

class GuestFCHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: app_bar_Color,
        elevation: 0,
        title: Center(
          child: Text(
            "Flame & Coal",
            style:
                TextStyle(color: Colors.black, fontFamily: 'Circularstd-Med'),
          ),
        ),
        actions: [
          Container(
            child: TextButton(
              child: Text(
                "Login",
                style: TextStyle(
                    color: Colors.black, fontFamily: 'Circularstd-Med'),
              ),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => GuestFCLogin()));
              },
            ),
          ),
        ],
        leading: Icon(
          Icons.arrow_back_sharp,
          color: app_bar_Color,
        ),
      ),
      body: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> dealaward = <String>[
    'Best Seller of the week',
    'Best Seller of the week',
    'Best Seller of the week',
    'Best Seller of the week',
  ];

  //Near You
  List<String> nearImg = <String>[
    'assets/images/menu/nearyou/nearyou1.jpg',
    'assets/images/menu/nearyou/nearyou2.jpg',
    'assets/images/menu/nearyou/nearyou3.jpg',
    'assets/images/menu/nearyou/nearyou4.jpg',
  ];
  List<String> nearName = <String>[
    'Chinese Rice',
    'Suji ka Halwa',
    'Palak Paneer',
    'Zinger Burger',
  ];
  List<String> nearTime = <String>[
    '20-30 min',
    '20-30 min',
    '20-30 min',
    '20-30 min',
  ];

  String time;

  String _greetingMessage(){

    var timeNow = DateTime.now().hour;

    if (timeNow <= 12) {
      return time='Good Morning';
    } else if ((timeNow > 12) && (timeNow <= 16)) {
      return time='Good Afternoon';
    } else if ((timeNow > 16) && (timeNow < 20)) {
      return time='Good Evening';
    } else {
      return time='Good Night';
    }
  }

  double height;
  double width;

  var deal = 'dealofday';
  var menu = 'menu';

  List data;
  List suggestionData;
  bool isLoading = false;
  String suggestionname;

  void _getdealsmenu() {
    database.child(deal).once().then((DataSnapshot snapshot) {
      setState(() {
        isLoading = true;
        Map<dynamic, dynamic> map = snapshot.value;
        data = map.values.toList();
      });
    });
  }

  void _suggestionmenu() {
    database.child('suggestion').once().then((DataSnapshot snapshot) {
      var data = snapshot.value;

      setState(() {
        isLoading = true;
        suggestionname = data['suggestioncate'];
      });
      database
          .child(menu)
          .child(suggestionname)
          .once()
          .then((DataSnapshot snapshot) {
        setState(() {
          isLoading = true;
          Map<dynamic, dynamic> map = snapshot.value;
          suggestionData = map.values.toList();
        });
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getdealsmenu();
    _suggestionmenu();
    _greetingMessage();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
              top: height * 0.01, left: width * 0.04, right: width * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: height * 0.01),
                child: Text(
                  time,
                  style: FcHomeGoodMoring,
                ),
              ),
              Container(
                margin:
                    EdgeInsets.only(right: width * 0.02, top: height * 0.01),
                child: TextField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle: FCHomeSearch,
                      fillColor: Color(0xfff8f8f8),
                      filled: true,
                      contentPadding: EdgeInsets.only(
                          left: width * 0.02, top: height * 0.02),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.search_sharp,
                        color: Colors.black,
                        size: 20,
                      )),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: height * 0.01),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: height * 0.01),
                      child: Text(
                        'Category',
                        style: FCHomeCategory,
                      ),
                    ),
                    Container(
                      width: width * 1.0,
                      height: height * 0.18,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => GuestFCsignalMenu(
                                        name: 'Breakfast',
                                      )));
                            },
                            child: Container(
                              child: Stack(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(),
                                    child: Column(
                                      children: [
                                        Card(
                                          child: Container(
                                              padding: EdgeInsets.all(3),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Color(0xFFFFBD2F),
                                              ),
                                              child: ClipOval(
                                                child: Image.asset(
                                                  FCListViewImg1,
                                                  height: 60,
                                                  width: 60,
                                                  fit: BoxFit.cover,
                                                ),
                                              )),
                                          elevation: 16,
                                          shadowColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(60)),
                                        ),
                                        SizedBox(
                                          height: height * 0.01,
                                        ),
                                        Container(
                                            child: Text(
                                          'Breakfast',
                                          style: FCHomeCategoryTitle,
                                        )),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => GuestFCsignalMenu(
                                        name: 'Lunch',
                                      )));
                            },
                            child: Container(
                              child: Stack(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: width * 0.05),
                                    child: Column(
                                      children: [
                                        Card(
                                          elevation: 16,
                                          shadowColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(60)),
                                          child: Container(
                                              padding: EdgeInsets.all(3),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Color(0xFFFFBD2F),
                                              ),
                                              child: ClipOval(
                                                child: Image.asset(
                                                  FCListViewImg2,
                                                  height: 60,
                                                  width: 60,
                                                  fit: BoxFit.cover,
                                                ),
                                              )),
                                        ),
                                        SizedBox(
                                          height: height * 0.01,
                                        ),
                                        Container(
                                            child: Text(
                                          'Lunch',
                                          style: FCHomeCategoryTitle,
                                        )),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => GuestFCsignalMenu(
                                        name: 'Dinner',
                                      )));
                            },
                            child: Container(
                              child: Stack(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: width * 0.05),
                                    child: Column(
                                      children: [
                                        Card(
                                          elevation: 16,
                                          shadowColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(60)),
                                          child: Container(
                                              padding: EdgeInsets.all(3),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Color(0xFFFFBD2F),
                                              ),
                                              child: ClipOval(
                                                child: Image.asset(
                                                  FCListViewImg6,
                                                  height: 60,
                                                  width: 60,
                                                  fit: BoxFit.cover,
                                                ),
                                              )),
                                        ),
                                        SizedBox(
                                          height: height * 0.01,
                                        ),
                                        Container(
                                            child: Text(
                                          'Dinner',
                                          style: FCHomeCategoryTitle,
                                        )),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => GuestFCsignalMenu(
                                        name: 'Desserts',
                                      )));
                            },
                            child: Container(
                              child: Stack(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: width * 0.05),
                                    child: Column(
                                      children: [
                                        Card(
                                          elevation: 16,
                                          shadowColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(60)),
                                          child: Container(
                                              padding: EdgeInsets.all(3),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Color(0xFFFFBD2F),
                                              ),
                                              child: ClipOval(
                                                child: Image.asset(
                                                  FCListViewImg3,
                                                  height: 60,
                                                  width: 60,
                                                  fit: BoxFit.cover,
                                                ),
                                              )),
                                        ),
                                        SizedBox(
                                          height: height * 0.01,
                                        ),
                                        Container(
                                            child: Text(
                                          'Desserts',
                                          style: FCHomeCategoryTitle,
                                        )),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => GuestFCsignalMenu(
                                        name: 'FastFood',
                                      )));
                            },
                            child: Container(
                              child: Stack(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: width * 0.05),
                                    child: Column(
                                      children: [
                                        Card(
                                          elevation: 16,
                                          shadowColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(60)),
                                          child: Container(
                                              padding: EdgeInsets.all(3),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Color(0xFFFFBD2F),
                                              ),
                                              child: ClipOval(
                                                child: Image.asset(
                                                  FCListViewImg4,
                                                  height: 60,
                                                  width: 60,
                                                  fit: BoxFit.cover,
                                                ),
                                              )),
                                        ),
                                        SizedBox(
                                          height: height * 0.01,
                                        ),
                                        Container(
                                            child: Text(
                                          'FastFood',
                                          style: FCHomeCategoryTitle,
                                        )),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => GuestFCsignalMenu(
                                        name: 'Drinks',
                                      )));
                            },
                            child: Container(
                              child: Stack(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: width * 0.05),
                                    child: Column(
                                      children: [
                                        Card(
                                          elevation: 16,
                                          shadowColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(60)),
                                          child: Container(
                                              padding: EdgeInsets.all(3),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Color(0xFFFFBD2F),
                                              ),
                                              child: ClipOval(
                                                child: Image.asset(
                                                  FCListViewImg5,
                                                  height: 60,
                                                  width: 60,
                                                  fit: BoxFit.cover,
                                                ),
                                              )),
                                        ),
                                        SizedBox(
                                          height: height * 0.01,
                                        ),
                                        Container(
                                            child: Text(
                                          'Drinks',
                                          style: FCHomeCategoryTitle,
                                        )),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: height * 0.01),
                      child: RichText(
                        text: TextSpan(
                            text: 'Suggestion for you ',
                            style: FCHomeSuggested,
                            children: <TextSpan>[]),
                      ),
                    ),
                    Container(
                      height: height * 0.45,
                      width: width * 1.0,
                      child: ListView.builder(
                        itemCount:
                            suggestionData == null ? 0 : suggestionData.length,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => GuestFCLogin()));
                            },
                            child: Container(
                              width: width * 0.75,
                              padding: EdgeInsets.only(bottom: height * 0.05),
                              margin: EdgeInsets.only(right: width * 0.05),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                              ),
                              child: Card(
                                elevation: 12,
                                shadowColor: Colors.white,
                                child: Column(
                                  children: [
                                    Container(
                                      height: height * 0.25,
                                      width: width * 0.75,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(7),
                                          topRight: Radius.circular(7),
                                        ),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(7),
                                          topRight: Radius.circular(7),
                                        ),
                                        child: Image.network(
                                          suggestionData[index]['productimg']
                                              .toString(),
                                          loadingBuilder: (BuildContext context,
                                              Widget child,
                                              ImageChunkEvent loadingProgress) {
                                            if (loadingProgress == null)
                                              return child;
                                            return Center(
                                              child: CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                            Color>(
                                                        Color(0xFFFFBD2F)),
                                                value: loadingProgress
                                                            .expectedTotalBytes !=
                                                        null
                                                    ? loadingProgress
                                                            .cumulativeBytesLoaded /
                                                        loadingProgress
                                                            .expectedTotalBytes
                                                    : null,
                                              ),
                                            );
                                          },
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: height * 0.12,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            alignment: Alignment.center,
                                            width: width * 0.6,
                                            child: Text(
                                              suggestionData[index]
                                                  ['productname'],
                                              style: TextStyle(
                                                  fontSize: width * 0.05,
                                                  fontFamily: 'Circularstd-Med',
                                                  color: Colors.black),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            width: width * 0.6,
                                            child: Text(
                                              suggestionData[index]
                                                  ['productdes'],
                                              style: TextStyle(
                                                  fontSize: width * 0.03,
                                                  color: Colors.black45,
                                                  fontFamily: 'PoppinRegular'),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            width: width * 0.6,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Container(
                                                  child: Icon(
                                                    Icons.access_time_sharp,
                                                    color: Color(0xFFFFBD2F),
                                                    size: 15,
                                                  ),
                                                ),
                                                Container(
                                                  child: Text(
                                                    suggestionData[index]
                                                            ['producttime'] +
                                                        'min'.toString(),
                                                    style: TextStyle(
                                                        fontSize: width * 0.03,
                                                        fontFamily:
                                                            'PoppinRegular',
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: width * 0.01,
                                                ),
                                                Container(
                                                  child: Icon(
                                                    Icons.star_half_sharp,
                                                    color: Color(0xFFFFBD2F),
                                                    size: 15,
                                                  ),
                                                ),
                                                Container(
                                                  child: Text(
                                                    suggestionData[index]
                                                            ['productrating']
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: width * 0.03,
                                                        fontFamily:
                                                            'PoppinRegular',
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: width * 0.01,
                                                ),
                                                Container(
                                                  child: Icon(
                                                    Icons.delivery_dining,
                                                    color: Color(0xFFFFBD2F),
                                                    size: 15,
                                                  ),
                                                ),
                                                Container(
                                                  child: Text(
                                                    'Free delivery',
                                                    style: TextStyle(
                                                        fontSize: width * 0.03,
                                                        fontFamily:
                                                            'PoppinRegular',
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              margin: EdgeInsets.only(bottom: height * 0.01),
                              child: Text(
                                'Deal of the day',
                                style: FCHomeDealDay,
                              )),
                          Container(
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: data == null ? 0 : data.length,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                GuestFCLogin()));
                                  },
                                  child: Container(
                                    height: height * 0.35,
                                    margin:
                                        EdgeInsets.only(bottom: height * 0.02),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(7),
                                        topRight: Radius.circular(7),
                                      ),
                                    ),
                                    child: Card(
                                      elevation: 12,
                                      shadowColor: Colors.white,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: Stack(
                                              children: [
                                                Container(
                                                  height: height * 0.24,
                                                  width: width * 0.92,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(7),
                                                      topRight:
                                                          Radius.circular(7),
                                                    ),
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(7),
                                                      topRight:
                                                          Radius.circular(7),
                                                    ),
                                                    child: Image.network(
                                                      data[index]['productimg']
                                                          .toString(),
                                                      loadingBuilder: (BuildContext
                                                              context,
                                                          Widget child,
                                                          ImageChunkEvent
                                                              loadingProgress) {
                                                        if (loadingProgress ==
                                                            null) return child;
                                                        return Center(
                                                          child:
                                                              CircularProgressIndicator(
                                                            valueColor:
                                                                AlwaysStoppedAnimation<
                                                                        Color>(
                                                                    Color(
                                                                        0xFFFFBD2F)),
                                                            value: loadingProgress
                                                                        .expectedTotalBytes !=
                                                                    null
                                                                ? loadingProgress
                                                                        .cumulativeBytesLoaded /
                                                                    loadingProgress
                                                                        .expectedTotalBytes
                                                                : null,
                                                          ),
                                                        );
                                                      },
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(40),
                                                  alignment: Alignment.topLeft,
                                                  foregroundDecoration:
                                                      RotatedCornerDecoration(
                                                    badgeShadow: BadgeShadow(
                                                        color: Colors.black,
                                                        elevation: 10),
                                                    color: Color(0xFFFFBD2F),
                                                    geometry: BadgeGeometry(
                                                        width: 80,
                                                        height: 80,
                                                        alignment:
                                                            BadgeAlignment
                                                                .topLeft),
                                                    textSpan: TextSpan(
                                                      text: data[index][
                                                              'productdiscount'] +
                                                          '%OFF'.toString(),
                                                      style: FcHomeDealDaybadge,
                                                    ),
                                                    labelInsets: LabelInsets(
                                                        baselineShift: 5),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: height * 0.08,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Container(
                                                  child: Text(
                                                    data[index]['productname'],
                                                    style: FCHomeDealDayName,
                                                  ),
                                                ),
                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            left: width * 0.05),
                                                        child: Row(
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .star_half_sharp,
                                                              color: Color(
                                                                  0xFFFFBD2F),
                                                              size: 15,
                                                            ),
                                                            Container(
                                                              child: Text(
                                                                data[index][
                                                                    'productrating'],
                                                                style:
                                                                    FCHomeSuggestedRating,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Container(
                                                              child:
                                                                  Image.asset(
                                                            'assets/images/menu/dealday/ribbon.png',
                                                            height:
                                                                height * 0.02,
                                                          )),
                                                          SizedBox(
                                                            width: width * 0.01,
                                                          ),
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    right: width *
                                                                        0.05),
                                                            child: Text(
                                                              dealaward[index],
                                                              style:
                                                                  FCHomeDealDayAward,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: height * 0.01),
                            child: Text(
                              'Near You',
                              style: FCHomeNear,
                            ),
                          ),
                          Container(
                            width: width * 0.99,
                            height: height * 0.5,
                            margin: EdgeInsets.only(bottom: height * 0.01),
                            child: ListView.builder(
                              itemCount: nearImg.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7)),
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                            right: width * 0.05),
                                        height: height * 0.5,
                                        width: width * 0.6,
                                        child: Stack(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(7),
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                        nearImg[index],
                                                      ),
                                                      fit: BoxFit.cover)),
                                            ),
                                            Center(
                                              child: Container(
                                                  margin: EdgeInsets.only(
                                                      top: height * 0.3),
                                                  width: width * 0.5,
                                                  height: height * 0.09,
                                                  decoration: BoxDecoration(
                                                      color: Color(0xFFFFBD2F),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              7)),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                        child: Text(
                                                          nearName[index],
                                                          style: FCHomeNearName,
                                                        ),
                                                      ),
                                                      Container(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      right: width *
                                                                          0.02),
                                                              child: Icon(
                                                                Icons
                                                                    .access_time_sharp,
                                                                color: Colors
                                                                    .black54,
                                                                size: 15,
                                                              ),
                                                            ),
                                                            Container(
                                                              child: Text(
                                                                nearTime[index],
                                                                style:
                                                                    FCHomeNearTime,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  )),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
