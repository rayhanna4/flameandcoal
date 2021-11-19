import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flameandcoal/Account%20Folder/EditAddress.dart';
import 'package:flameandcoal/Drawer%20Files/Drawer%20Page.dart';
import 'package:flutter/material.dart';
import '../Constant Folder/Constant File.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

final database = FirebaseDatabase.instance.reference();

final FirebaseAuth _auth = FirebaseAuth.instance;

class FCEditAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
      ),
      body: EditAccount(),
    );
  }
}

class EditAccount extends StatefulWidget {
  @override
  _EditAccountState createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  double height;
  double width;

  final nameController = TextEditingController();
  final aboutController = TextEditingController();
  final emailController = TextEditingController();
  final numberController = TextEditingController();

  String url = "";
  var _image;

  String phoneNumber;

  String userid;

  var number = "userphonenumber";

  List data;

  void getPhoneNumber() {
    User user = _auth.currentUser;
    String id = user.uid;
    database.child(number).child(id).once().then((DataSnapshot snapshot) {
      var data = snapshot.value;

      setState(() {
        phoneNumber = data['userphonenumber'].toString();
        userid = data['userid'].toString();
      });
    });
  }

  //getting image from gallery

  Future getImage() async {
    var image1 = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image1;
    });
  }

//uploading user info in database
  Future uploadUserInfo() async {
    String uName = nameController.text;
    String uAbout = aboutController.text;
    String uEmail = emailController.text;

    String fileName = basename(_image.path);
    firebase_storage.Reference firebaseStorageRef = firebase_storage
        .FirebaseStorage.instance
        .ref('profilePic')
        .child(fileName);
    firebase_storage.UploadTask uploadTask = firebaseStorageRef.putFile(_image);

    uploadTask.then((res) async {
      url = await res.ref.getDownloadURL();
      User user = _auth.currentUser;
      String id = user.uid;

      if (uName != '' && uAbout != '' && uEmail != '') {
        database.child('UserInfo').child(id).update({
          'Name': uName,
          'About': uAbout,
          'Email': uEmail,
          'uid': id,
          'ProfilePic': url,
        });
        if (database != null) {
          Navigator.of(this.context)
              .push(MaterialPageRoute(builder: (context) => DrawerFile()));
        } else {
          Scaffold.of(this.context).showSnackBar(SnackBar(
              content: Center(
                  child: Text(
            'Data Not Enter SuccessFully',
            style: TextStyle(fontFamily: 'PoppinRegular', fontSize: 18),
          ))));
        }
      }
      Scaffold.of(this.context).showSnackBar(SnackBar(
          content: Center(
              child: Text(
        'Your cannot Enter Valid Data',
        style: TextStyle(fontFamily: 'PoppinRegular', fontSize: 20),
      ))));
    });
  }


  bool datauser = false;
  var uInfo = "UserInfo";
  String email;

  String userNam;
  String userAbout;

  void _getCurrentUserInfo() {
    User user = _auth.currentUser;
    String id = user.uid;
    database.child(uInfo).child(id).once().then((DataSnapshot snapshot) {
      var data = snapshot.value;

      setState(() {
        datauser = true;
        email = data['Email'].toString();
        userNam = data['Name'].toString();
        userAbout = data['About'].toString();
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPhoneNumber();
    _getCurrentUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: height * 0.2,
                child: Center(
                  child: Column(
                    children: [
                      Container(
                        child: ClipOval(
                            child: _image != null
                                ? Image.file(
                                    File(_image.path),
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      getImage();
                                    },
                                    child: Container(
                                      child: Stack(
                                        children: [
                                          Center(
                                            child: CircleAvatar(
                                              radius: height * 0.08,
                                              backgroundColor: Colors.black,
                                              backgroundImage:
                                                  AssetImage('assets/man.png'),
                                            ),
                                          ),
                                          Center(
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  top: height * 0.045),
                                              child: IconButton(
                                                color: Color(0xFFFFBD2F),
                                                onPressed: () {
                                                  getImage();
                                                },
                                                icon: Icon(
                                                    Icons.camera_alt_sharp),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: width * 1.0,
                height: height * 0.75,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Container(
                            width: width * 0.8,
                            child: TextFormField(
                              style: TextStyle(fontFamily: 'PoppinRegular'),
                              controller: nameController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                               hintText: datauser==false ?
                                   'Name'
                                   :
                                userNam
                                ,
                                hintStyle: FCEditAccounttext,
                                labelText: 'User Name',
                                labelStyle: FCEditAccountStyle,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                suffixIcon: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.edit,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: width * 0.8,
                            child: TextFormField(
                              style: TextStyle(fontFamily: 'PoppinRegular'),
                              controller: aboutController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                hintText: datauser==false ?
                                'About'
                                    :
                                userAbout
                                ,
                                hintStyle: FCEditAccounttext,
                                labelText: 'About',
                                labelStyle: FCEditAccountStyle,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                suffixIcon: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.edit,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: width * 0.8,
                            child: TextFormField(
                              style: TextStyle(fontFamily: 'PoppinRegular'),
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: datauser==false ?
                                'Email'
                                    :
                                email
                                ,
                                hintStyle: FCEditAccounttext,
                                labelText: 'Email',
                                labelStyle: FCEditAccountStyle,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                suffixIcon: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.edit,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: width * 0.8,
                            child: TextFormField(
                              //controller: numberController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                enabled: false,
                                hintText: phoneNumber,
                                hintStyle: FCEditAccounttext,
                                labelText: 'Mobile Number',
                                labelStyle: FCEditAccountStyle,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height*0.02,
                          ),
                          Container(
                            width: width * 0.8,
                            height: height * 0.06,
                            child: RaisedButton(
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              onPressed: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) =>FCEditAddress()));
                              },
                              child: Text('Edit Address', style: FCMyAccountBtn1),
                              color: Color(0xFFFFBD2F),
                              textColor: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: width * 0.8,
                      height: height * 0.06,
                      child: RaisedButton(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        onPressed: () {
                          setState(() {
                            if (_image != null) {
                              uploadUserInfo();
                            } else {
                              Scaffold.of(this.context).showSnackBar(SnackBar(
                                  content: Center(
                                      child: Text('Upload Picture First',
                                        style: TextStyle(fontFamily: 'PoppinRegular',fontSize: 15),
                                      ))));
                            }
                          });
                        },
                        child: Text('SAVE', style: FCMyAccountBtn1),
                        color: Color(0xFFFFBD2F),
                        textColor: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
