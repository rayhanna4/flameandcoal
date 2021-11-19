import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flameandcoal/Account Folder/EditAddress.dart';
import '../Constant Folder/Constant File.dart';

final database = FirebaseDatabase.instance.reference();
final FirebaseAuth _uth = FirebaseAuth.instance;

class FCAddress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFBD2F),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFFFFBD2F),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios_sharp,
            color: Colors.black,
          ),
        ),
        title: Center(
            child: Text(
              'My Address',
              style: FCMyAddress,
            )),
      ),
      body: MyAdress(),
    );
  }
}

class MyAdress extends StatefulWidget {
  @override
  _MyAdressState createState() => _MyAdressState();
}

class _MyAdressState extends State<MyAdress> {
  double height;
  double width;
  String address;

  String street;

  String block;

  String town;

  String place;

  bool isaddress = false;

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

  void _delUserAddress() {
    User user = _uth.currentUser;
    String id = user.uid;
    database.child('UserAddress').child(id).remove();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUserAddress();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          height: height * 0.85,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(
                child: Container(
                  width: width * 0.95,
                  height: height * 0.22,
                  child: Card(
                    elevation: 16,
                    shadowColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        isaddress == false
                            ? Container(
                          child: Text("Enter Your Address ",
                          style: TextStyle(fontFamily: 'PoppinRegular'),
                          ),
                        )
                            : ListTile(
                          leading: Icon(
                            Icons.home_outlined,
                            color: Color(0xFFFFBD2F),
                            size: 30,
                          ),
                          title: Text(
                            place,
                            style: FCMyAddressTittle,
                          ),
                          subtitle: Text(
                            'House ' +
                                address +
                                ',Street ' +
                                street +
                                ' Block ' +
                                block +
                                ' Town ' +
                                town,
                            style: FCMyAddressSubTitle,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              child: Icon(
                                Icons.edit,
                                color: Color(0xFFFFBD2F),
                              ),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => FCEditAddress()));
                              },
                            ),
                            SizedBox(width: 8),
                            TextButton(
                              child: Icon(
                                Icons.delete_outlined,
                                color: Color(0xFFFFBD2F),
                              ),
                              onPressed: () {
                                setState(() {
                                  _delUserAddress();
                                });
                              },
                            ),
                            SizedBox(width: 8),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: width * 0.95,
                height: height * 0.06,
                child: RaisedButton(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => FCEditAddress()));
                  },
                  child: Text(
                    'Add New Address',
                    style: FCMyAddressBtn1,
                  ),
                  color: Colors.white,
                  textColor: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
