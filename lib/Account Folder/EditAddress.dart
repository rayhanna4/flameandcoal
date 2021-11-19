import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../Constant Folder/Constant File.dart';

final database = FirebaseDatabase.instance.reference();
final FirebaseAuth _uth = FirebaseAuth.instance;

class FCEditAddress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFFFFBD2F),
        title: Center(
            child: Text(
          'Edit Address',
          style: FCMyAddressTittle,
        )),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios_sharp,
            color: Colors.black,
          ),
        ),
      ),
      body: EditAddress(),
    );
  }
}

class EditAddress extends StatefulWidget {
  @override
  _EditAddressState createState() => _EditAddressState();
}

class _EditAddressState extends State<EditAddress> {
  TextEditingController _address = TextEditingController();
  TextEditingController _street = TextEditingController();
  TextEditingController _block = TextEditingController();
  TextEditingController _town = TextEditingController();

  double height;
  double width;
  String place;

  Future _updateUserAddress() {
    String address = _address.text;
    String street = _street.text;
    String block = _block.text;
    String town = _town.text;
    User user = _uth.currentUser;
    String id = user.uid;

    if (address != '' && street != '' && block != '' && town != '') {
      database.child("UserAddress").child(id).update({
        'useraddress': address,
        'userstreet': street,
        'userblock': block,
        'usertown': town,
        'userid': id,
        'HomeorWork': place,
      }).then((_) {
        Scaffold.of(context).showSnackBar(
            SnackBar(content: Center(child: Text("Address Updated ",
              style: TextStyle(
                  fontFamily: 'PoppinRegular',
                  fontSize: 15),
            ))));
        _address.clear();
        _street.clear();
        _block.clear();
        _town.clear();
      }).catchError((onError) {});
    } else {
      Scaffold.of(this.context)
          .showSnackBar(SnackBar(content: Text('Input Valid Data')));
    }
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          height: height * 0.85,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin:
                        EdgeInsets.only(top: height * 0.05, left: width * 0.05),
                        width: width * 0.85,
                        child: TextField(
                          controller: _address, style: TextStyle(fontFamily: 'PoppinRegular'),

                          keyboardType: TextInputType.streetAddress,
                          decoration: InputDecoration(
                            hintText: '',
                            hintStyle: FCEditAccounttext,
                            labelText: 'Address:',
                            labelStyle: FCMyAddressTittle,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                        ),
                      ),
                      Container(
                        margin:
                        EdgeInsets.only(top: height * 0.05, left: width * 0.05),
                        child: Row(
                          children: [
                            Container(
                              width: width * 0.4,
                              child: TextField(
                                controller: _street,
                                style: TextStyle(fontFamily: 'PoppinRegular'),
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: '',
                                  hintStyle: FCEditAccounttext,
                                  labelText: 'Street No:',
                                  labelStyle: FCMyAddressTittle,
                                  floatingLabelBehavior: FloatingLabelBehavior.always,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width * 0.05,
                            ),
                            Container(
                              width: width * 0.4,
                              child: TextField(
                                controller: _block,
                                style: TextStyle(fontFamily: 'PoppinRegular'),
                                keyboardType: TextInputType.streetAddress,
                                decoration: InputDecoration(
                                  hintText: '',
                                  hintStyle: FCEditAccounttext,
                                  labelText: 'Block:',
                                  labelStyle: FCMyAddressTittle,
                                  floatingLabelBehavior: FloatingLabelBehavior.always,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin:
                        EdgeInsets.only(top: height * 0.05, left: width * 0.05),
                        width: width * 0.85,
                        child: TextField(
                          controller: _town,
                          style: TextStyle(fontFamily: 'PoppinRegular'),
                          keyboardType: TextInputType.streetAddress,
                          decoration: InputDecoration(
                            hintText: '',
                            hintStyle: FCEditAccounttext,
                            labelText: 'Town:*',
                            labelStyle: FCMyAddressTittle,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                        ),
                      ),
                      Container(
                        margin:
                        EdgeInsets.only(top: height * 0.05, left: width * 0.05),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text('Label As:',
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Circularstd-Med',
                                  )),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: height * 0.02),
                              child: Row(
                                children: [
                                  Container(
                                    width: width * 0.25,
                                    height: height * 0.06,
                                    child: FlatButton(
                                      child: Text(
                                        'HOME',
                                        style: FCMyAddressSubTitle,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          place = 'Home';
                                        });
                                      },
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(25)),
                                      color: Color(0xFFFFBD2F),
                                    ),
                                  ),
                                  SizedBox(
                                    width: width * 0.05,
                                  ),
                                  Container(
                                    width: width * 0.25,
                                    height: height * 0.06,
                                    child: FlatButton(
                                      child: Text(
                                        'WORK',
                                        style: FCMyAddressSubTitle,
                                      ),
                                      onPressed: () {
                                        place = 'Work';
                                      },
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(25)),
                                      color: Color(0xFFFFBD2F),
                                    ),
                                  ),
                                  SizedBox(
                                    width: width * 0.05,
                                  ),
                                  Container(
                                    width: width * 0.25,
                                    height: height * 0.06,
                                    child: FlatButton(
                                      child: Text(
                                        'OTHER',
                                        style: FCMyAddressSubTitle,
                                      ),
                                      onPressed: () {
                                        place = 'Other';
                                      },
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(25)),
                                      color: Color(0xFFFFBD2F),
                                    ),
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
                Container(
                  margin: EdgeInsets.only(top: height * 0.05,),
                    width: width * 0.8,
                    height: height * 0.06,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    onPressed: () {
                      setState(() {
                        _updateUserAddress();
                      });
                    },
                    child: Text(
                      'Save Location',

                      style: FCSaveButton,
                    ),
                    color: Color(0xFFFFBD2F),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
