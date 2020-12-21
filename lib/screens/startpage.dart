import 'package:Juhuischool/screens/MainChat.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Juhuischool/screens/login2_screen.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:Juhuischool/screens/login_screen.dart';
import 'package:Juhuischool/screens/prizedetail.dart';
import 'package:Juhuischool/screens/dashboard.dart';
import 'package:Juhuischool/screens/profilepage.dart';
import 'package:Juhuischool/screens/invoice.dart';
import 'package:Juhuischool/screens/coupon.dart';
import 'package:Juhuischool/screens/coupontransfer.dart';
import 'package:Juhuischool/screens/affiliaterank.dart';
import 'package:Juhuischool/screens/affiliateqr.dart';
import 'package:Juhuischool/screens/affiliateregister.dart';
import 'package:Juhuischool/screens/resetpassword.dart';
import 'package:Juhuischool/screens/schdule.dart';
import 'package:Juhuischool/screens/views/chatrooms.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';

class userprofile {
  final String fullname;
  final DateTime birthdate;
  final bool sex;
  final String address;
  final String mobile;
  final String email;
  final String user_id;
  final String sponso;
  final String password;
  userprofile(
      {this.fullname,
      this.birthdate,
      this.sex,
      this.address,
      this.mobile,
      this.email,
      this.password,
      this.sponso,
      this.user_id});
}

//prizeinfo
class prizepageinfo {
  String firsttexttitle = '';
  String firsttext = '';
  List<String> secondtexttile = [];
  List<String> secondtext = [];
  prizepageinfo({
    this.firsttexttitle,
    this.firsttext,
  });
}

int testpos;

List<String> prizeimage = [
];

List<String> prizename = [
];

List<String> prizeslug = [];

List<String> prizecost = [];

List<String> prizepastcost = [];


_getImage(i) async {
  final response = await 'https://class.yixinacademy.com/assets/images/courses/${prizeimage[i]}';
}

getCourse() async {
  final uri = 'https://class.yixinacademy.com/api/user/getcourse';
  http.Response response = await http.get(uri);
  
  var responseObj = json.decode(response.body);
  prizeimage = responseObj["image"] != null ? List.from(responseObj["image"]) : null;
  prizecost = responseObj["now_price"] != null ? List.from(responseObj["now_price"]) : null;
  prizepastcost = responseObj["old_price"] != null ? List.from(responseObj["old_price"]) : null;
  prizename = responseObj["title"] != null ? List.from(responseObj["title"]) : null;
  prizeslug = responseObj["slug"] != null ? List.from(responseObj["slug"]) : null;
  for(int i = 0;i < prizeimage.length; i++)
    await _getImage(i);
}

getCatalog(pos) async {
  final uri = 'https://class.yixinacademy.com/api/user/course/${prizeslug[pos]}';
  http.Response response = await http.get(uri);

  var responseObj = json.decode(response.body);

  prizeinfolist.clear();

  prizeinfolist.add(prizepageinfo(
    firsttexttitle: responseObj["title"],
    firsttext: 'Last Updated : ${responseObj["clock"]}\n${responseObj["class"]} classes\n${responseObj["detail_short"]}',
  ));
  prizeinfolist[0].secondtexttile.add('What you will learn?');
  prizeinfolist[0].secondtext.add('${responseObj["detail_learn"]}');
  prizeinfolist[0].secondtexttile.add('Requirements');
  prizeinfolist[0].secondtext.add('${responseObj["requirement"]}');
}

int prizepos = 0;

List<prizepageinfo> prizeinfolist = [];
//

bool registered = false;

class Startpage extends StatefulWidget {
  @required
  _StartpageState createState() => _StartpageState();
}

class _StartpageState extends State<Startpage> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool passvisible = false;
  List<String> image = [];
  @override
  void initState() {
    super.initState();
    prizeinfolist.clear();
    image.clear();
    image.add('assets/image.png');
    image.add('assets/image (1).png');
    image.add('assets/image (2).png');
    image.add('assets/image (3).png');
  }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: true,
      drawer: registered == true ? Menulist() : Container(),
      appBar: AppBar(
        title: Text("JuHui School"),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
          SizedBox(
            height: 50 * size.height / 750,
          ),
          SizedBox(
            width: size.width,
            height: 370 / 610 * size.width,
            child: Swiper(
              itemCount: 4,
              itemBuilder: (context, index) {
                return Container(
                  width: size.width,
                  height: 370 / 610 * size.width,
                  child: Image(
                    image: AssetImage(image[index]),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 60 * size.height / 750,
          ),
          Text(" MEMBER'S ACCESS",
              style: TextStyle(
                  fontSize: 24 * size.width / 390, color: Colors.black)),
          Container(
            margin: EdgeInsets.only(top: 10 * size.height / 750),
            width: size.width,
            height: 4 * size.height / 750,
            decoration: BoxDecoration(color: Colors.black.withOpacity(0.8)),
          ),
          SizedBox(height: 60 * size.height / 750),
          //sign in
          if (!registered)
            Container(
              margin: EdgeInsets.only(top: 7, left: 40, right: 40, bottom: 7),
              child: RaisedButton(
                  color: Colors.white,
                  child: Container(
                    alignment: Alignment.center,
                    width: 200 * size.width / 390,
                    padding: EdgeInsets.all(7),
                    child: Text(
                      'Sign in',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(_createRoutetosignin());
                  }),
            ),
          //register
          if (!registered)
            Container(
              margin: EdgeInsets.only(top: 7, left: 40, right: 40, bottom: 7),
              child: RaisedButton(
                  color: Colors.white,
                  child: Container(
                    alignment: Alignment.center,
                    width: 200 * size.width / 390,
                    padding: EdgeInsets.all(7),
                    child: Text(
                      'Register',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(_createRoutetoregister());
                  }),
            ),

          //shop
          if (registered)
            SizedBox(
              width: size.width,
              height: 390 / 750 * size.height,
              child: Swiper(
                itemCount: 7,
                itemBuilder: (context, index) {
                  return card(index, context);
                },
              ),
            ),
          SizedBox(height: 40 * size.height / 750),
          if (registered)
            Text(" VIP'S LIBRARY",
                style: TextStyle(
                    fontSize: 24 * size.width / 390, color: Colors.black)),
          Container(
            margin: EdgeInsets.only(top: 10 * size.height / 750),
            width: size.width,
            height: 4 * size.height / 750,
            decoration: BoxDecoration(color: Colors.black.withOpacity(0.8)),
          ),
          SizedBox(height: 40 * size.height / 750),
        ]),
      ),
    );
  }


  Widget card(int pos, BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.all(10),
      width: size.width,
      height: 370 / 750 * size.height,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(color: Colors.grey, blurRadius: 4, spreadRadius: 2)
      ]),
      child: Column(
        children: [
          GestureDetector(
            child: Image.network(
              'https://class.yixinacademy.com/assets/images/courses/${prizeimage[pos]}',
              width: size.width,
              height: 250 * size.height / 750,
              fit: BoxFit.fill,
            ),
            onTap: () async {
              prizepos = pos;
              await getCatalog(pos);
              Navigator.of(context).push(_createRoutetoprizepage());
            },
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            prizename[pos],
            style:
                TextStyle(fontSize: 18 * size.width / 390, color: Colors.black),
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < prizecost.length; i++)
                Container(
                  width: (size.width - 30) / prizecost.length,
                  height: 5,
                  decoration: BoxDecoration(
                      color: i == pos ? Colors.yellow : Colors.grey),
                ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: size.width,
            height: 40 * size.height / 750,
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (prizepastcost[pos] != "0")
                  Positioned(
                      left: 20,
                      child: Text(
                        'c\u{24}' + prizepastcost[pos],
                        style: TextStyle(
                            fontSize: 20 * size.width / 390,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough),
                      )),
                Positioned(
                    right: 20,
                    child: Text(
                      'c\u{24}' + prizecost[pos],
                      style: TextStyle(
                          color: Colors.black, fontSize: 20 * size.width / 390),
                    ))
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

Route _createRoutetosignin() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        LoginScreenWidget(),
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

Route _createRoutetoregister() {
  testpos = Random().nextInt(5);
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => Register(),
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
Route _createRoutetoprofile() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => ProfilePage(),
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
Route _createRoutetorank() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => AffiliateRank(),
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

Route _createRoutetoprizepage() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => Prizedetail(),
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
  //gotodashboard
}

Route _createRoutetodashboard() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => Dashboard(),
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

Route _createRoutetoinvoice() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => Invoice(),
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

Route _createRoutetocoupon() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => Coupon(),
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


Route _createRoutetocoupontransfer() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => Coupontransfer(),
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

Route _createRoutetoinformation() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => AffiliateQr(),
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


Route _createRoutetoaffiliateregister() {
  testpos = Random().nextInt(5);
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => AffiliateRegister(),
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

Route _createRoutetoresetpassword() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => RestPassword(),
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



Route _createRoutetoresetschedule() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => MySchedule(),
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

Route _createRoutetoresetchat() {
  chat_first_load = 0;
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => MainChat(),
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


class Menulist extends StatelessWidget {
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    TextStyle substyle = TextStyle(
        fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black);
    return Drawer(
        child: ListView(children: [
      Container(
        decoration: BoxDecoration(color: Colors.white),
        width: size.width * 2 / 3,
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(
              height: 60 * size.height / 750,
            ),
            SizedBox(
              height: 10 * size.height / 750,
            ),
            Menuitem(
              icon: Icons.home,
              text: ' Home',
              route: _createRoutetomain(),
            ),
            SizedBox(
              height: 7 * size.height / 750,
            ),
            SizedBox(
              height: 7 * size.height / 750,
            ),
            Menuitem(
              icon: Icons.person,
              text: ' Account Details',
              route: _createRoutetoprofile(),
            ),
            SizedBox(
              height: 7 * size.height / 750,
            ),
            
            SizedBox(
              height: 7 * size.height / 750,
            ),
            Menuitem(
              icon: Icons.airplay_outlined ,
              text: ' DashBoard',
              route: _createRoutetodashboard(),
            ),
            SizedBox(
              height: 7 * size.height / 750,
            ),

            
            SizedBox(
              height: 7 * size.height / 750,
            ),
            Menuitem(
              icon: Icons.attach_money ,
              text: ' Invoice List',
              route: _createRoutetoinvoice(),
            ),
            SizedBox(
              height: 7 * size.height / 750,
            ),
            
            SizedBox(
              height: 7 * size.height / 750,
            ),
            Menuitem(
              icon: Icons.card_giftcard ,
              text: ' Coupon List',
              route: _createRoutetocoupon(),
            ),
            SizedBox(
              height: 7 * size.height / 750,
            ),
            
            SizedBox(
              height: 7 * size.height / 750,
            ),
            Menuitem(
              icon: Icons.send_to_mobile ,
              text: ' Coupon Transfer',
              route: _createRoutetocoupontransfer(),
            ),
            SizedBox(
              height: 7 * size.height / 750,
            ),
            SizedBox(
              height: 7 * size.height / 750,
            ),
            Menuitem(
              icon: Icons.supervised_user_circle ,
              text: ' Affiliate Rank',
              route: _createRoutetorank(),
            ),
            SizedBox(
              height: 7 * size.height / 750,
            ),
            SizedBox(
              height: 7 * size.height / 750,
            ),
            Menuitem(
              icon: Icons.ad_units_sharp ,
              text: ' Affiliate Information',
              route: _createRoutetoinformation(),
            ),
            SizedBox(
              height: 7 * size.height / 750,
            ),
            SizedBox(
              height: 7 * size.height / 750,
            ),
            Menuitem(
              icon: Icons.app_registration ,
              text: ' Affiliate Register',
              route: _createRoutetoaffiliateregister(),
            ),
            SizedBox(
              height: 7 * size.height / 750,
            ),
            SizedBox(
              height: 7 * size.height / 750,
            ),
            Menuitem(
              icon: Icons.construction ,
              text: ' Reset Password',
              route: _createRoutetoresetpassword(),
            ),
            SizedBox(
              height: 7 * size.height / 750,
            ),
            SizedBox(
              height: 7 * size.height / 750,
            ),
            Menuitem(
              icon: Icons.chat ,
              text: 'Chat',
              route: _createRoutetoresetchat(),
            ),
            SizedBox(
              height: 7 * size.height / 750,
            ),
            SizedBox(
              height: 7 * size.height / 750,
            ),
            Menuitem(
              icon: Icons.calendar_today ,
              text: 'Schedule',
              route: _createRoutetoresetschedule(),
            ),
            SizedBox(
              height: 7 * size.height / 750,
            ),
            SizedBox(
              height: 50 * size.height / 750,
            ),
            GestureDetector(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 5,
                    child: Row(children: [
                      Icon(Icons.save_alt),
                      Text(
                        ' Log Out',
                        style: substyle,
                      ),
                    ]),
                  ),
                ],
              ),
              onTap: () {
                registered = false;
                Navigator.of(context).push(_createRoutetomain());
              },
            )
          ],
        ),
      )
    ]));
  }
}

class Menuitem extends StatelessWidget {
  String text;
  IconData icon;
  Function ontap;
  Route route;
  Menuitem({this.text, this.icon, this.ontap, this.route});
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    TextStyle substyle = TextStyle(
        fontSize: 19 * size.width / 390,
        fontWeight: FontWeight.bold,
        color: Colors.black);
    return Container(
      child: GestureDetector(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 5,
              child: Row(children: [
                Icon(icon),
                Text(
                  text,
                  style: substyle,
                ),
              ]),
            ),
            Expanded(
              child: IconButton(
                  icon: Icon(Icons.arrow_forward_ios), onPressed: () {}),
            )
          ],
        ),
        onTap: () {
          if (route != null) Navigator.of(context).push(route);
        },
      ),
    );
  }
}
