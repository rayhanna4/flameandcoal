import 'package:firebase_auth/firebase_auth.dart';
import 'package:flameandcoal/Drawer%20Files/Drawer%20Page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flameandcoal/Constant%20Folder/Constant%20File.dart';

final database = FirebaseDatabase.instance.reference();
final FirebaseAuth _auth = FirebaseAuth.instance;

class FCFavorite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FavoritePage(),
    );
  }
}

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  var favorite = 'favorite';
  String productname;

  List favData;

  void getFavItem() {
    User user = _auth.currentUser;
    String id = user.uid;
    database.child(favorite).child(id).once().then((DataSnapshot snapshot) {
      setState(() {
        Map<dynamic, dynamic> map = snapshot.value;
        favData = map.values.toList();
      });
    });
  }

  void _delitemincart(String pname, int i) {
    User user = _auth.currentUser;
    String id = user.uid;

    database.child(favorite).child(id).child(pname).remove();
    setState(() {
      favData.removeAt(i);
      if (favData != null) {
        Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(
          "Item Delete From Favorite",
          style: TextStyle(fontFamily: 'PoppinRegular', fontSize: 16),
        )));
      } else {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => DrawerFile()));
      }
    });
  }

  double height;
  double width;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFavItem();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return favData != null
        ? SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            margin: EdgeInsets.only(
                              top: height * 0.03,
                              bottom: height * 0.01,
                              left: width * 0.05,
                            ),
                            child: Text(
                              'Favourite',
                              style: FCHomeDealDay,
                            )),
                        Container(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: favData == null ? 0 : favData.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {},
                                child: Container(
                                  padding: EdgeInsets.only(
                                      left: width * 0.05, right: width * 0.05),
                                  height: height * 0.35,
                                  width: width * 0.92,
                                  margin:
                                      EdgeInsets.only(bottom: height * 0.02),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(7),
                                      topRight: Radius.circular(7),
                                    ),
                                  ),
                                  child: Card(
                                    elevation: 15,
                                    shadowColor: Colors.white,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: Stack(
                                            children: [
                                              Container(
                                                height: height * 0.28,
                                                width: width * 0.92,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft: Radius.circular(7),
                                                    topRight:
                                                        Radius.circular(7),
                                                  ),
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft: Radius.circular(7),
                                                    topRight:
                                                        Radius.circular(7),
                                                  ),
                                                  child: Image.network(
                                                    favData[index]['productimg']
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
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      _delitemincart(
                                                          favData[index][
                                                                  'productname']
                                                              .toString(),
                                                          index);
                                                    },
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                          right: width * 0.04),
                                                      width: width * 0.10,
                                                      height: height * 0.10,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color:
                                                            Color(0xFFFFBD2F),
                                                      ),
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          _delitemincart(
                                                              favData[index][
                                                                      'productname']
                                                                  .toString(),
                                                              index);
                                                        },
                                                        child: Icon(
                                                          Icons.delete_outlined,
                                                          color: Colors.white,
                                                          size: 25,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: height * 0.02),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                child: Text(
                                                  favData[index]['productname']
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: width * 0.05,
                                                      fontFamily:
                                                          'Circularstd-Med'),
                                                ),
                                              ),
                                              Container(
                                                child: Text(
                                                    'Rs: ' +
                                                        favData[index]
                                                            ["productprice"] +
                                                        '/-',
                                                    style: TextStyle(
                                                        fontSize: width * 0.045,
                                                        fontFamily:
                                                            'Circularstd-Med',
                                                        color:
                                                            Color(0xFFFFBD2F))),
                                              ),
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
                        SizedBox(
                          height: height * 0.05,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => DrawerFile()));
                          },
                          child: Container(
                            // width: 20,
                            // height: 20,
                            padding: EdgeInsets.only(
                                left: width * 0.05, right: width * 0.05),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.arrow_back_ios_sharp,
                                  size: 18,
                                ),
                                Text(
                                  'BACK',
                                  style:
                                      TextStyle(fontFamily: 'Circularstd-Med'),
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
          )
        : Column(
            children: [
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(
                  top: height * 0.3,
                ),
                child: Image.asset(
                  'assets/images/gifs/fav.gif',
                  height: height * 0.2,
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: height * 0.05),
                child: Text(
                  'Nothing to show',
                  style: FCFavoriteTitle,
                ),
              )
            ],
          );
  }
}
