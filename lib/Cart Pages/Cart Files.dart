import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flameandcoal/Account%20Folder/EditAccount.dart';
import 'package:flameandcoal/Cart%20Pages/proceedcheckout.dart';
import 'package:flameandcoal/Constant%20Folder/Constant%20File.dart';
import 'package:flameandcoal/Drawer%20Files/Drawer%20Page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

final database = FirebaseDatabase.instance.reference();
final FirebaseAuth _uth = FirebaseAuth.instance;

class FCCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(child: CartPage()),
    );
  }
}

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int count = 0;

  double height;
  double width;

  List data;
  bool isLoading = false;

  void _cartitem() {
    User user = _uth.currentUser;
    String id = user.uid;
    database
        .child('additemincart')
        .child(id)
        .once()
        .then((DataSnapshot snapshot) {
      setState(() {
        isLoading = true;
        Map<dynamic, dynamic> map = snapshot.value;
        data = map.values.toList();
      });
    });
  }

  void _delitemincart(String pname, int i) {
    User user = _uth.currentUser;
    String id = user.uid;

    database.child('additemincart').child(id).child(pname).remove();

    setState(() {
      data.removeAt(i);
      if (data != null) {
        Fluttertoast.showToast(
            msg: "Item Delete From Cart SuccessFully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: btn_Color,
            textColor: Colors.black,
            fontSize: 16.0
        );
      } else {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => DrawerFile()));
      }
    });
  }

  Future _pushFavorite(String img, pname, pprice) {
    User user = _uth.currentUser;
    String id = user.uid;



    database.child('favorite').child(id).child(pname).update({
      'productname': pname,
      'productimg': img,
      'productprice': pprice,
    });
    Fluttertoast.showToast(
        msg: "Add Item in Favorite",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: btn_Color,
        textColor: Colors.black,
        fontSize: 16.0
    );
  }

  var uInfo = "UserInfo";
  String userNam;
  String userAddress;

  void _getCurrentUserInfo() {
    User user = _uth.currentUser;
    String id = user.uid;
    database.child(uInfo).child(id).once().then((DataSnapshot snapshot) {
      var data = snapshot.value;

      setState(() {
        userNam = data['Name'].toString();
      });
    });
  }

  void _getUserAddress() {
    User user = _uth.currentUser;
    String id = user.uid;
    database
        .child('UserAddress')
        .child(id)
        .once()
        .then((DataSnapshot snapshot) {
      var data = snapshot.value;

      setState(() {
        userAddress = data['useraddress'];
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cartitem();
    _getCurrentUserInfo();
    _getUserAddress();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return data != null
        ? Container(
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
                : SafeArea(
                    child: Container(
                      padding: EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              top: height * 0.05,
                              bottom: height * 0.02,
                            ),
                            child: Text(
                              'Cart',
                              style: FCCartTitle,
                            ),
                          ),
                          Container(
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: data == null ? 0 : data.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  width: width * 1.0,
                                  height: height * 0.2,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    elevation: 3,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: width * 0.3,
                                          height: height * 0.2,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.network(
                                              data[index]['productimg']
                                                  .toString(),
                                              loadingBuilder:
                                                  (BuildContext context,
                                                      Widget child,
                                                      ImageChunkEvent
                                                          loadingProgress) {
                                                if (loadingProgress == null)
                                                  return child;
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(
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
                                          height: height * 0.2,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.only(
                                                    left: width * 0.04),
                                                child: Text(
                                                  data[index]['productname'],
                                                  style: FCSummaryOrderName,
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.only(
                                                    left: width * 0.04),
                                                child: Text(
                                                  'Delivery Time: ' +
                                                      data[index]
                                                          ['deliverytime'] +
                                                      'min',
                                                  style: FCSummaryOrderPrice,
                                                ),
                                              ),
                                              Container(
                                                width: width * 0.6,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                          left: width * 0.04),
                                                      child: Text(
                                                        'Rs ' +
                                                            data[index][
                                                                'producttotalprice'] +
                                                            '/-',
                                                        style:
                                                            FCSummaryOrderPrice,
                                                      ),
                                                    ),
                                                    Container(
                                                      // padding: EdgeInsets.only(left: width * 0.1),
                                                      child: Text(
                                                        'Item Select :' +
                                                            data[index][
                                                                'totalproductselect'],
                                                        style:
                                                            FCSummaryOrderPrice,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: width * 0.6,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                        margin: EdgeInsets.only(
                                                            left: width * 0.02),
                                                        child: IconButton(
                                                          icon: Icon(
                                                            Icons
                                                                .favorite_border,
                                                            color: Color(
                                                                0xFFFFBD2F),
                                                          ),
                                                          onPressed: () {
                                                            _pushFavorite(
                                                                data[index][
                                                                        'productimg']
                                                                    .toString(),
                                                                data[index][
                                                                        'productname']
                                                                    .toString(),
                                                                data[index][
                                                                        'porignalprice']
                                                                    .toString());
                                                          },
                                                        )),
                                                    Container(
                                                        margin: EdgeInsets.only(
                                                            right:
                                                                width * 0.02),
                                                        child: IconButton(
                                                          icon: Icon(
                                                            Icons
                                                                .delete_outlined,
                                                            color: Color(
                                                                0xFFFFBD2F),
                                                          ),
                                                          onPressed: () {
                                                            _delitemincart(
                                                                data[index][
                                                                    'productname'],
                                                                index);
                                                          },
                                                        )),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: height * 0.03),
                            width: width * 0.95,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DrawerFile()));
                                  },
                                  child: Container(
                                    width: width * 0.35,
                                    height: height * 0.06,
                                    margin: EdgeInsets.only(left: width * 0.05),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: Icon(
                                            Icons.arrow_back_ios_sharp,
                                            size: 18,
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            "Add More Item",
                                            style: TextStyle(
                                              fontSize: width * 0.04,
                                              fontFamily: 'Circularstd-Med',
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  width: width * 0.35,
                                  height: height * 0.06,
                                  child: RaisedButton(
                                    elevation: 3,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                    onPressed: () {
                                      if (data != null) {
                                        if (userNam != null &&
                                            userAddress != null) {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      FCProceedCheckout(
                                                        method: 'Select Method',
                                                      )));
                                        } else {
                                          Fluttertoast.showToast(
                                              msg: "Please Add Name & Address",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 3,
                                              backgroundColor: btn_Color,
                                              textColor: Colors.black,
                                              fontSize: 16.0
                                          );

                                        }
                                      } else {
                                        Fluttertoast.showToast(
                                            msg: "Select Item First",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 3,
                                            backgroundColor: btn_Color,
                                            textColor: Colors.black,
                                            fontSize: 16.0
                                        );
                                      }
                                    },
                                    child: Text(
                                      'Checkout',
                                      style: FCCartCheckOut,
                                    ),
                                    color: Color(0xFFFFBD2F),
                                    textColor: Colors.black,
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height * 0.05,
                          ),
                          Center(
                            child: Container(
                              width: width * 0.6,
                              height: height * 0.06,
                              child: RaisedButton(
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => FCEditAccount()));
                                },
                                child: Text(
                                  'Add Name & Address',
                                  style: FCCartCheckOut,
                                ),
                                color: Color(0xFFFFBD2F),
                                textColor: Colors.black,
                              ),
                            ),
                          )
                        ],
                      ),
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
                  'assets/images/gifs/cart.gif',
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
              ),
              Container(
                width: width * 0.5,
                height: height * 0.09,
                alignment: Alignment.center,
                child: OutlineButton(
                  highlightedBorderColor: Color(0xFFFFBD2F),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => DrawerFile()));
                  },
                  borderSide: BorderSide(color: Color(0xFFFFBD2F), width: 2),
                  child: Text(
                    'BACK',
                    style: FCSignInButtonTitle,
                  ),
                ),
              ),
            ],
          );
  }
}
