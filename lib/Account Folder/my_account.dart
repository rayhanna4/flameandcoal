import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flameandcoal/Fav%20Food/Fav%20Food%20File.dart';
import 'package:flameandcoal/LogoutFolder/LogoutFile.dart';
import 'package:flameandcoal/Tracker%20Folder/Tracker%20File.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flameandcoal/Account Folder/my_address.dart';
import 'package:flameandcoal/Account Folder/EditAccount.dart';
import '../Constant Folder/Constant File.dart';

final database = FirebaseDatabase.instance.reference();
final FirebaseAuth _auth = FirebaseAuth.instance;

class FCAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: MyAccount(),
    );
  }
}

class MyAccount extends StatefulWidget {
  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  double height;
  double width;

  bool isimage = false;
  var uInfo = "UserInfo";
  String userImg;

  String userNam;
  String userAbout;

  List data;

  void getCurrentUserInfo() {
    User user = _auth.currentUser;
    String id = user.uid;
    database.child(uInfo).child(id).once().then((DataSnapshot snapshot) {
      var data = snapshot.value;

      setState(() {
        isimage = true;
        userImg = data['ProfilePic'].toString();
        userNam = data['Name'].toString();
        userAbout = data['About'].toString();
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return isimage == false
        ? SafeArea(
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(top: height * 0.03),
                child: Column(
                  children: [
                    Container(
                      width: width * 1.0,
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xfffebd31).withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                  offset: Offset(
                                      1, 2), // changes position of shadow
                                ),
                              ],
                            ),
                            child: CircleAvatar(
                                radius: height * 0.06,
                                backgroundColor: Colors.black,
                                backgroundImage: AssetImage('assets/man.png')),
                          ),
                          SizedBox(
                            width: width * 0.08,
                          ),
                          Container(
                            child: Column(
                              children: [
                                Container(
                                  child: Text("Name", style: FCAccountTitle),
                                ),
                                Container(
                                  margin: EdgeInsets.only(),
                                  child: Text("About",
                                      style: FCAccountsubheadingText),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    Container(
                      width: width * 1.0,
                      height: height * 0.25,
                      padding: EdgeInsets.only(
                          left: width * 0.02, right: width * 0.02),
                      margin: EdgeInsets.only(
                          left: width * 0.02, right: width * 0.02),
                      child: Card(
                        elevation: 20,
                        shadowColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => FCEditAccount()));
                                },
                                child: ListTile(
                                  leading: Container(
                                    width: width * 0.1,
                                    height: height * 0.1,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    child: Icon(
                                      Icons.person,
                                      color: Color(0xfffebd31),
                                    ),
                                  ),
                                  title: Text('Personal Info',
                                      style: FCAccountheadingText),
                                  trailing: IconButton(
                                      icon: Icon(
                                        Icons.arrow_forward_ios,
                                        size: 15,
                                      ),
                                      color: Colors.black54,
                                      onPressed: () {}),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => FCAddress()));
                                },
                                child: ListTile(
                                  leading: Container(
                                    width: width * 0.1,
                                    height: height * 0.1,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    child: Icon(
                                      Icons.add_location,
                                      color: Color(0xfffebd31),
                                    ),
                                  ),
                                  title: Text('Addresses',
                                      style: FCAccountheadingText),
                                  trailing: IconButton(
                                      icon: Icon(
                                        Icons.arrow_forward_ios,
                                        size: 15,
                                      ),
                                      color: Colors.black54,
                                      onPressed: () {}),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    Container(
                      width: width * 1.0,
                      height: height * 0.24,
                      margin: EdgeInsets.only(
                          left: width * 0.02, right: width * 0.02),
                      padding: EdgeInsets.only(
                          left: width * 0.02, right: width * 0.02),
                      child: Card(
                        elevation: 20,
                        shadowColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => FCFavorite()));
                                },
                                child: ListTile(
                                  leading: Container(
                                    width: width * 0.1,
                                    height: height * 0.1,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    child: Icon(
                                      Icons.favorite,
                                      color: Color(0xfffebd31),
                                    ),
                                  ),
                                  title: Text('Favourite',
                                      style: FCAccountheadingText),
                                  trailing: IconButton(
                                      icon: Icon(
                                        Icons.arrow_forward_ios,
                                        size: 15,
                                      ),
                                      color: Colors.black54,
                                      onPressed: () {}),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => TrackerTimer()));
                                },
                                child: ListTile(
                                  leading: Container(
                                    width: width * 0.1,
                                    height: height * 0.1,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    child: Icon(
                                      Icons.payment,
                                      color: Color(0xfffebd31),
                                    ),
                                  ),
                                  title: Text('Tracker',
                                      style: FCAccountheadingText),
                                  trailing: IconButton(
                                      icon: Icon(
                                        Icons.arrow_forward_ios,
                                        size: 15,
                                      ),
                                      color: Colors.black54,
                                      onPressed: () {}),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    Container(
                      width: width * 1.0,
                      height: height * 0.13,
                      margin: EdgeInsets.only(
                          left: width * 0.02, right: width * 0.02),
                      padding: EdgeInsets.only(
                          left: width * 0.02, right: width * 0.02),
                      child: Card(
                        elevation: 20,
                        shadowColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => Logout()));
                                },
                                child: ListTile(
                                  leading: Container(
                                    width: width * 0.1,
                                    height: height * 0.1,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    child: Icon(
                                      Icons.logout,
                                      color: Color(0xfffebd31),
                                    ),
                                  ),
                                  title: Text('Sign Out',
                                      style: FCAccountheadingText),
                                  trailing: IconButton(
                                      icon: Icon(
                                        Icons.arrow_forward_ios,
                                        size: 15,
                                      ),
                                      color: Colors.black54,
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Logout()));
                                      }),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                  ],
                ),
              ),
            ),
          )
        : SafeArea(
            child: SingleChildScrollView(
              child: Container(
                // padding: EdgeInsets.all(20),
                margin: EdgeInsets.only(top: height * 0.03),
                child: Column(
                  children: [
                    Container(
                      width: width * 1.0,
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xfffebd31).withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                  offset: Offset(
                                      1, 2), // changes position of shadow
                                ),
                              ],
                            ),
                            child: CircleAvatar(
                                radius: height * 0.06,
                                backgroundColor: Colors.black,
                                backgroundImage: isimage == false
                                    ? AssetImage('assets/man.png')
                                    : NetworkImage(userImg)),
                          ),
                          SizedBox(
                            width: width * 0.08,
                          ),
                          Container(
                            child: Column(
                              children: [
                                Container(
                                  child: Text(userNam, style: FCAccountTitle),
                                ),
                                Container(
                                  margin: EdgeInsets.only(),
                                  child: Text(userAbout,
                                      style: FCAccountsubheadingText),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    Container(
                      width: width * 1.0,
                      height: height * 0.25,
                      padding: EdgeInsets.only(
                          left: width * 0.02, right: width * 0.02),
                      margin: EdgeInsets.only(
                          left: width * 0.02, right: width * 0.02),
                      child: Card(
                        elevation: 20,
                        shadowColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => FCEditAccount()));
                                },
                                child: ListTile(
                                  leading: Container(
                                    width: width * 0.1,
                                    height: height * 0.1,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    child: Icon(
                                      Icons.person,
                                      color: Color(0xfffebd31),
                                    ),
                                  ),
                                  title: Text('Personal Info',
                                      style: FCAccountheadingText),
                                  trailing: IconButton(
                                      icon: Icon(
                                        Icons.arrow_forward_ios,
                                        size: 15,
                                      ),
                                      color: Colors.black54,
                                      onPressed: () {}),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => FCAddress()));
                                },
                                child: ListTile(
                                  leading: Container(
                                    width: width * 0.1,
                                    height: height * 0.1,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    child: Icon(
                                      Icons.add_location,
                                      color: Color(0xfffebd31),
                                    ),
                                  ),
                                  title: Text('Addresses',
                                      style: FCAccountheadingText),
                                  trailing: IconButton(
                                      icon: Icon(
                                        Icons.arrow_forward_ios,
                                        size: 15,
                                      ),
                                      color: Colors.black54,
                                      onPressed: () {}),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    Container(
                      width: width * 1.0,
                      height: height * 0.24,
                      margin: EdgeInsets.only(
                          left: width * 0.02, right: width * 0.02),
                      padding: EdgeInsets.only(
                          left: width * 0.02, right: width * 0.02),
                      child: Card(
                        elevation: 20,
                        shadowColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => FCFavorite()));
                                },
                                child: ListTile(
                                  leading: Container(
                                    width: width * 0.1,
                                    height: height * 0.1,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    child: Icon(
                                      Icons.favorite,
                                      color: Color(0xfffebd31),
                                    ),
                                  ),
                                  title: Text('Favourite',
                                      style: FCAccountheadingText),
                                  trailing: IconButton(
                                      icon: Icon(
                                        Icons.arrow_forward_ios,
                                        size: 15,
                                      ),
                                      color: Colors.black54,
                                      onPressed: () {}),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => TrackerTimer()));
                                },
                                child: ListTile(
                                  leading: Container(
                                    width: width * 0.1,
                                    height: height * 0.1,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    child: Icon(
                                      Icons.payment,
                                      color: Color(0xfffebd31),
                                    ),
                                  ),
                                  title: Text('Tracker',
                                      style: FCAccountheadingText),
                                  trailing: IconButton(
                                      icon: Icon(
                                        Icons.arrow_forward_ios,
                                        size: 15,
                                      ),
                                      color: Colors.black54,
                                      onPressed: () {}),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    Container(
                      width: width * 1.0,
                      height: height * 0.13,
                      margin: EdgeInsets.only(
                          left: width * 0.02, right: width * 0.02),
                      padding: EdgeInsets.only(
                          left: width * 0.02, right: width * 0.02),
                      child: Card(
                        elevation: 20,
                        shadowColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => Logout()));
                                },
                                child: ListTile(
                                  leading: Container(
                                    width: width * 0.1,
                                    height: height * 0.1,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    child: Icon(
                                      Icons.logout,
                                      color: Color(0xfffebd31),
                                    ),
                                  ),
                                  title: Text('Sign Out',
                                      style: FCAccountheadingText),
                                  trailing: IconButton(
                                      icon: Icon(
                                        Icons.arrow_forward_ios,
                                        size: 15,
                                      ),
                                      color: Colors.black54,
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Logout()));
                                      }),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
