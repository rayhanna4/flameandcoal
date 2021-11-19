import 'package:flameandcoal/Constant%20Folder/Constant%20File.dart';
import 'package:flameandcoal/Menu/singal%20Menu.dart';
import 'package:flutter/material.dart';

class FCMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFBD2F),
      body: MainMenu(),
    );
  }
}

class MainMenu extends StatefulWidget {
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  List<String> menuImg = <String>[
    'assets/images/menu/breakfast.jpg',
    'assets/images/menu/lunch.jpg',
    'assets/images/menu/dinner.jpg',
    'assets/images/menu/bbq.jpg',
    'assets/images/menu/ff.jpg',
    'assets/images/menu/naan.jpg',
    'assets/images/menu/dessert.jpg',
    'assets/images/menu/drink.jpg',
  ];

  List<String> menuName = <String>[
    'Breakfast',
    'Lunch',
    'Dinner',
    'BBQ',
    'FastFood',
    'Naan',
    'Desserts',
    'Drinks',
  ];

  double height;
  double width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(
              top: height * 0.05,
              left: width * 0.04,
              right: width * 0.04,
              bottom: height * 0.05),
          child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: menuImg.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: .95,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => FCsignalMenu(
                              name: menuName[index],
                            )));
                  },
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          image: DecorationImage(
                            image: AssetImage(menuImg[index]),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.5),
                                BlendMode.dstATop),
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(),
                          child: Text(
                            '${menuName[index]}',
                            style: FCMenuSubTitle,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
