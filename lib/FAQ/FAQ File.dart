import 'package:flutter/material.dart';

class FCFAQFile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FCFAQFULL();
  }
}

class FCFAQFULL extends StatefulWidget {
  @override
  _FCFAQFULLState createState() => _FCFAQFULLState();
}

class _FCFAQFULLState extends State<FCFAQFULL> {
  double width;
  double height;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Card(
                    elevation: 3,
                    child: ExpansionTile(
                      title: Text(
                        "Why you should make an FAQ page",
                        style: TextStyle(
                            color: Color(0xFFe09500),
                            fontSize: 18,
                            fontFamily: 'Circularstd-Med'),
                      ),
                      children: [
                        Container(
                          width: width * 0.9,
                          decoration:
                              BoxDecoration(color: Colors.white, boxShadow: [
                            BoxShadow(
                                color: Colors.black54.withOpacity(0.2),
                                blurRadius: 2,
                                spreadRadius: 1,
                                offset: Offset(0, 2))
                          ]),
                          padding: EdgeInsets.all(15),
                          child: Text(
                            'Sure there are chatbots, support lines, and customer reviews'
                            ' to help shoppers on their path to purchase, but there’s one forgotten'
                            ' customer service tactic that is cost-effective and streamlined. That '
                            'tactic is an FAQ page. ',
                            textAlign: TextAlign.justify,
                            style: TextStyle(fontSize: 18,fontFamily: 'PoppinRegular'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Card(
                    elevation: 3,
                    child: ExpansionTile(
                      title: Text(
                        "Why you should make an FAQ page",
                        style: TextStyle(
                            color: Color(0xFFe09500),
                            fontSize: 18,
                            fontFamily: 'Circularstd-Med'),
                      ),
                      children: [
                        Container(
                          width: width * 0.9,
                          decoration:
                              BoxDecoration(color: Colors.white, boxShadow: [
                            BoxShadow(
                                color: Colors.black54.withOpacity(0.2),
                                blurRadius: 2,
                                spreadRadius: 1,
                                offset: Offset(0, 2))
                          ]),
                          padding: EdgeInsets.all(15),
                          child: Text(
                            'Sure there are chatbots, support lines, and customer reviews'
                            ' to help shoppers on their path to purchase, but there’s one forgotten'
                            ' customer service tactic that is cost-effective and streamlined. That '
                            'tactic is an FAQ page. ',
                            textAlign: TextAlign.justify,
                            style: TextStyle(fontSize: 18,fontFamily: 'PoppinRegular'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Card(
                    elevation: 3,
                    child: ExpansionTile(
                      title: Text(
                        "Why you should make an FAQ page",
                        style: TextStyle(
                            color: Color(0xFFe09500),
                            fontSize: 18,
                            fontFamily: 'Circularstd-Med'),
                      ),
                      children: [
                        Container(
                          width: width * 0.9,
                          decoration:
                              BoxDecoration(color: Colors.white, boxShadow: [
                            BoxShadow(
                                color: Colors.black54.withOpacity(0.2),
                                blurRadius: 2,
                                spreadRadius: 1,
                                offset: Offset(0, 2))
                          ]),
                          padding: EdgeInsets.all(15),
                          child: Text(
                            'Sure there are chatbots, support lines, and customer reviews'
                            ' to help shoppers on their path to purchase, but there’s one forgotten'
                            ' customer service tactic that is cost-effective and streamlined. That '
                            'tactic is an FAQ page. ',
                            textAlign: TextAlign.justify,
                            style: TextStyle(fontSize: 18,fontFamily: 'PoppinRegular'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Card(
                    elevation: 3,
                    child: ExpansionTile(
                      title: Text(
                        "Why you should make an FAQ page",
                        style: TextStyle(
                            color: Color(0xFFe09500),
                            fontSize: 18,
                            fontFamily: 'Circularstd-Med'),
                      ),
                      children: [
                        Container(
                          width: width * 0.9,
                          decoration:
                              BoxDecoration(color: Colors.white, boxShadow: [
                            BoxShadow(
                                color: Colors.black54.withOpacity(0.2),
                                blurRadius: 2,
                                spreadRadius: 1,
                                offset: Offset(0, 2))
                          ]),
                          padding: EdgeInsets.all(15),
                          child: Text(
                            'Sure there are chatbots, support lines, and customer reviews'
                            ' to help shoppers on their path to purchase, but there’s one forgotten'
                            ' customer service tactic that is cost-effective and streamlined. That '
                            'tactic is an FAQ page. ',
                            textAlign: TextAlign.justify,
                            style: TextStyle(fontSize: 20,fontFamily: 'PoppinRegular'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Card(
                    elevation: 3,
                    child: ExpansionTile(
                      title: Text(
                        "Why you should make an FAQ page",
                        style: TextStyle(
                            color: Color(0xFFe09500),
                            fontSize: 18,
                            fontFamily: 'Circularstd-Med'),
                      ),
                      children: [
                        Container(
                          width: width * 0.9,
                          decoration:
                              BoxDecoration(color: Colors.white, boxShadow: [
                            BoxShadow(
                                color: Colors.black54.withOpacity(0.2),
                                blurRadius: 2,
                                spreadRadius: 1,
                                offset: Offset(0, 2))
                          ]),
                          padding: EdgeInsets.all(15),
                          child: Text(
                            'Sure there are chatbots, support lines, and customer reviews'
                            ' to help shoppers on their path to purchase, but there’s one forgotten'
                            ' customer service tactic that is cost-effective and streamlined. That '
                            'tactic is an FAQ page. ',
                            textAlign: TextAlign.justify,
                            style: TextStyle(fontSize: 18,fontFamily: 'PoppinRegular'),
                          ),
                        ),
                      ],
                    ),
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
