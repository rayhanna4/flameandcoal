import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flameandcoal/Account%20Folder/my_address.dart';
import 'package:flameandcoal/Cart%20Pages/Confirm.dart';
import 'package:flameandcoal/Payment%20Method/Payment%20Method.dart';
import 'package:flutter/material.dart';
import 'package:flameandcoal/Constant%20Folder/Constant%20File.dart';

final database = FirebaseDatabase.instance.reference();
final FirebaseAuth _uth = FirebaseAuth.instance;

class FCProceedCheckout extends StatelessWidget {
  String method;

  FCProceedCheckout({@required this.method});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFFBD2F),
        title: Center(
            child: Text(
          'Order Summary',
          style: FCSummaryAppbarTitle,
        )),
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: FinalCheckout(
        method: method,
      ),
    );
  }
}

class FinalCheckout extends StatefulWidget {
  String method;

  FinalCheckout({@required this.method});

  @override
  _FinalCheckoutState createState() => _FinalCheckoutState();
}

class _FinalCheckoutState extends State<FinalCheckout> {
  int count = 0;
  int shipping = 150;
  int totalprice = 0;
  double width;
  double height;

  String method;

  void _card(String method) {
    this.method = method;
  }

  String address;

  String street;

  String block;

  String town;

  String place;

  bool isaddress = false;
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

        for (int i = 0; i < data.length; i++) {
          var productrs = int.parse(data[i]['producttotalprice']);
          count += productrs;
          totalprice = count + shipping;
        }
      });
    });
  }

  void _delcartitem() {
    User user = _uth.currentUser;
    String id = user.uid;
    database.child('additemincart').child(id).remove();
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
        isaddress = true;
        address = data['useraddress'];
        street = data['userstreet'];
        block = data['userblock'];
        town = data['usertown'];
        place = data['HomeorWork'];
      });
    });
  }

  var uInfo = "UserInfo";
  String userNam;

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

  var number = "userphonenumber";
  var phoneNumber;

  void _getPhoneNumber() {
    User user = _uth.currentUser;
    String id = user.uid;
    database.child(number).child(id).once().then((DataSnapshot snapshot) {
      var data1 = snapshot.value;

      setState(() {
        phoneNumber = data1['userphonenumber'].toString();
      });
    });
  }

  Future _order() {
    User user = _uth.currentUser;
    String id = user.uid;

    database.child("orderData").child(id).push().set({
      'userid': id,
      'order': data,
      'status': 'pending',
      'userName': userNam,
      'userPhoneNumber': phoneNumber.toString(),
      'address': 'Home ' +
          address +
          ' Street ' +
          street.toString() +
          ' Block ' +
          block.toString() +
          ' Town ' +
          town +
          ' Place ' +
          place,
      'totalPrice': totalprice.toString(),
    });
    if (database != null) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => FCConfirm()));
    } else {
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Center(child: Text("Please Enter All Data"))));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _card(widget.method);
    _getUserAddress();
    _getPhoneNumber();
    _cartitem();
    _getCurrentUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.only(
          left: width * 0.04, right: width * 0.03, top: height * 0.02),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin:
                  EdgeInsets.only(top: height * 0.04, bottom: height * 0.01),
              child: Text(
                'Delivering To ',
                style: FCSummaryHeading,
              ),
            ),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 0.7),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  isaddress == false
                      ? Container(
                          margin: EdgeInsets.only(top: height * 0.01),
                          child: Text(
                            'Town, City',
                            style: FCSummaryAddressHead,
                          ),
                        )
                      : Container(
                          margin: EdgeInsets.only(top: height * 0.01),
                          child: Text(
                            town + ', Lahore',
                            style: FCSummaryAddressHead,
                          ),
                        ),
                  isaddress == false
                      ? Container(
                          margin: EdgeInsets.only(top: height * 0.02),
                          child: Text(
                            '4/3,Street no 10, sector 43, Johar Town, Lahore, Punjab ',
                            style: FCSummaryAddress,
                          ),
                        )
                      : Container(
                          child: Text(
                            'House ' +
                                address +
                                ',Street ' +
                                street +
                                ' Block ' +
                                block +
                                ' Town ' +
                                town,
                            style: FCSummaryAddress,
                          ),
                        ),
                  Container(
                      margin: EdgeInsets.only(
                          top: height * 0.02,
                          left: width * 0.05,
                          right: width * 0.05,
                          bottom: height * 0.01),
                      width: width * 0.9,
                      height: height * 0.05,
                      child: RaisedButton(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => FCAddress()));
                        },
                        child: Text(
                          'Change Address',
                          style: FCSummaryAddressChange,
                        ),
                        color: Color(0xFFFFBD2F),
                      ))
                ],
              ),
            ),
            Container(
              margin:
                  EdgeInsets.only(top: height * 0.04, bottom: height * 0.02),
              child: Text(
                'Your Items',
                style: FCSummaryItems,
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
                    margin: EdgeInsets.only(bottom: height * 0.02),
                    width: width * 1.0,
                    height: height * 0.15,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      elevation: 12,
                      shadowColor: Colors.white,
                      child: Row(
                        children: [
                          Container(
                            width: width * 0.3,
                            height: height * 0.15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                data[index]['productimg'].toString(),
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(
                                      //  backgroundColor: Colors.black,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Color(0xFFFFBD2F)),
                                      value: loadingProgress
                                                  .expectedTotalBytes !=
                                              null
                                          ? loadingProgress
                                                  .cumulativeBytesLoaded /
                                              loadingProgress.expectedTotalBytes
                                          : null,
                                    ),
                                  );
                                },
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            height: height * 0.18,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: width * 0.04),
                                  child: Text(
                                    data[index]['productname'],
                                    style: FCSummaryOrderName,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: width * 0.04),
                                  child: Text(
                                    'Delivery Time: ' +
                                        data[index]['deliverytime'] +
                                        'min',
                                    style: FCSummaryOrderPrice,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      padding:
                                          EdgeInsets.only(left: width * 0.04),
                                      child: Text(
                                        'Rs ' +
                                            data[index]['producttotalprice'] +
                                            '/-',
                                        style: FCSummaryOrderPrice,
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.only(left: width * 0.06),
                                      child: Text(
                                        'Item Select :' +
                                            data[index]['totalproductselect'],
                                        style: FCSummaryOrderPrice,
                                      ),
                                    ),
                                  ],
                                ),
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
              margin: EdgeInsets.only(top: height * 0.02),
              width: width * 0.9,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: height * 0.02),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            'Total Price',
                            style: FCSummaryTotalPriceHead,
                          ),
                        ),
                        Container(
                          child: Text(
                            'Rs: ' + count.toString() + '/-',
                            style: FCSummaryTotalPriceVal,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: height * 0.01),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            'Shipping Charges',
                            style: FCSummaryShippingHead,
                          ),
                        ),
                        Container(
                          child: Text(
                            'Rs: ' + shipping.toString() + '/-',
                            style: FCSummaryShippingVal,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: height * 0.01),
                    child: Divider(
                      color: Colors.grey[300],
                      thickness: 1,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: height * 0.08),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            'Amount Payable',
                            style: FCSummaryPayableHead,
                          ),
                        ),
                        Container(
                          child: Text(
                            'Rs: ' + totalprice.toString() + '/-',
                            style: FCSummaryPayableVal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: height * 0.02),
              child: Text(
                'Mode of Payment',
                style: FCSummaryPaymentHead,
              ),
            ),
            Container(
              width: width * 0.92,
              height: height * 0.15,
              margin: EdgeInsets.only(bottom: height * 0.05),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 0.7),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      alignment: Alignment.center,
                      child: Text(
                        method,
                        style: FCSummaryOrderPrice,
                      )),
                  Container(
                      margin: EdgeInsets.only(
                        left: width * 0.05,
                        right: width * 0.05,
                      ),
                      width: width * 0.9,
                      height: height * 0.05,
                      child: RaisedButton(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        onPressed: () {
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (context) => PaymentMethod(
                          //           price: totalprice.toString(),
                          //         )));
                        },
                        child: Text(
                          'Payment Mode',
                          style: FCSummaryAddressChange,
                        ),
                        color: Color(0xFFFFBD2F),
                      ))
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  left: width * 0.2, right: width * 0.2, bottom: height * 0.01),
              width: width * 0.5,
              height: height * 0.07,
              child: RaisedButton(
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                onPressed: () {
                  _order();
                  _delcartitem();
                },
                child: Text(
                  'Confirm',
                  style: FCSummaryConfirm,
                ),
                color: Color(0xFFFFBD2F),
              ),
            )
          ],
        ),
      ),
    );
  }
}
