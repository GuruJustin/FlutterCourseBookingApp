import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Juhuischool/screens/startpage.dart';
import 'package:Juhuischool/screens/Coursedetail.dart';
import 'package:Juhuischool/screens/login2_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_html/flutter_html.dart';
//import 'package:simple_html_css/simple_html_css.dart';

List<String> classlist = [
];

var catalog_detail = "";

var purcahse;

List titlelist = [];

List everypur = [];

List videolist = [];

getCatalogInformation() async {
  classlist.clear();
  final uri = 'https://class.yixinacademy.com/api/user/content/${prizeslug[prizepos]}/${user_id}';
  http.Response response = await http.get(uri);
  
  var responseObj = json.decode(response.body);

  catalog_detail = responseObj["detail"];

  for(int i = 0;i < responseObj["catalog_title"].length; i++)
  {
    classlist.add("${responseObj["catalog_title"][i]}\n${responseObj["catalog_detail"][i]}\n${responseObj["catalog_price_amount"][i]}\n");
  }

  titlelist = responseObj["catalog_title"];
  purcahse = responseObj["purchase"];
  everypur = responseObj["every_purchase"];
  videolist = responseObj["catalog_video"];
}

class Prizedetail extends StatefulWidget {
  @override
  _PrizedetailState createState() => _PrizedetailState();
}

class _PrizedetailState extends State<Prizedetail> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    var size = MediaQuery.of(context).size;

    TextStyle maintextstyle = new TextStyle(
        color: Colors.black,
        fontSize: 17 * size.width / 390,
        fontWeight: FontWeight.bold);
    TextStyle subtextstyle =
        new TextStyle(color: Colors.black, fontSize: 17 * size.width / 390);
    return Scaffold(
      key: _scaffoldKey,
      drawer: Menulist(),
      resizeToAvoidBottomPadding: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              child: Container(
                padding: EdgeInsets.all(20 * size.height / 750),
                child: Image(
                  image: AssetImage('assets/logo.png'),
                  height: 80 * size.height / 750,
                ),
              ),
              onTap: () {
                Navigator.of(context).push(_createRoutetomain());
              },
            ),
            //firsttext
            Container(
              padding: EdgeInsets.all(20 * size.width / 390),
              width: size.width,
              decoration: BoxDecoration(color: Colors.black87),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(prizeinfolist[0].firsttexttitle,
                      style: TextStyle(
                          fontSize: 24 * size.width / 390,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 10 * size.height / 750,
                  ),
                  Text(prizeinfolist[0].firsttext,
                      style: TextStyle(
                          fontSize: 17 * size.width / 390,
                          color: Colors.white,
                          height: 2))
                ],
              ),
            ),
            //secondtext
            SizedBox(
              height: 30 * size.height / 750,
            ),
            Container(
              padding: EdgeInsets.all(20 * size.width / 390),
              width: size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Overview',
                    style: TextStyle(
                        fontSize: 30 * size.width / 390, color: Colors.black),
                  ),
                  SizedBox(
                    height: 30 * size.height / 750,
                  ),
                  for (int i = 0;
                      i < prizeinfolist[0].secondtexttile.length;
                      i++)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          prizeinfolist[0].secondtexttile[i],
                          style: maintextstyle,
                        ),
                        SizedBox(
                          height: 20 * size.height / 750,
                        ),
//                        RichText(text:HTML.toTextSpan(context, prizeinfolist[0].secondtext[i],defaultTextStyle: TextStyle(fontSize: 15,),)),
                        Html(data:prizeinfolist[0].secondtext[i]),
                        SizedBox(
                          height: 20 * size.height / 750,
                        ),
                      ],
                    ),
                ],
              ),
            ),

            Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Image.network(
                    'https://class.yixinacademy.com/assets/images/courses/${prizeimage[prizepos]}',
                    width: size.width,
                    height: 250 * size.height / 750,
                  ),
                  GestureDetector(
                    child: Text(
                      'Go To Course',
                      style: subtextstyle,
                    ),
                    onTap: () async{
                      await getCatalogInformation();
                      Navigator.of(context).push(_createRoutetocourse());
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}

Route _createRoutetomain() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => Startpage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(1.0, 0);
      var end = Offset.zero;
      var curve = Curves.easeInOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

Route _createRoutetocourse() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => Coursedetail(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(1.0, 0);
      var end = Offset.zero;
      var curve = Curves.easeInOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
