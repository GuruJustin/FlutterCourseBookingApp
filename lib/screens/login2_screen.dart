import 'dart:async';
import 'dart:convert';
import 'package:Juhuischool/screens/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Juhuischool/screens/startpage.dart';
import 'package:Juhuischool/screens/forgetpassword.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:Juhuischool/screens/schdule.dart';
import 'package:local_auth/local_auth.dart';
import 'package:imei_plugin/imei_plugin.dart';
import 'package:Juhuischool/screens/helper/helperfunctions.dart';


var _timer;
bool place = false;
bool gettime = false;
int delaytimer;
String lastmeeting_name = '';
String lastmeeting_starttime = '';
String lastmeeting_endtime = '';
int user_id;
double user_affiliate_bonus;
double user_coin;
String user_email;
String user_name;
String user_phone_number;
String user_fax;
String user_city;
String user_country;
String user_zip;
String user_address;
List<String> country_name = [];
List<String> couponlist = [];
List<Map<String, String>> ranklist = [];

List<Map<String, String>> listitems = [
];
List<Map<String, String>> couponlistitems = [
];

List user_price = [];
List user_date = [];



class LoginScreenWidget extends StatefulWidget {
  @override
  _LoginScreenWidgetState createState() => _LoginScreenWidgetState();
}

Future<bool> _checkStatusLogin() async {
  bool isAuthenticate = false;
  var localAuth = LocalAuthentication();
  try {
    isAuthenticate = await localAuth.authenticateWithBiometrics(
        localizedReason: 'Please authenticate to login', stickyAuth: true);
    print('isAuthenticate: ' + isAuthenticate.toString());
  } on PlatformException catch (e) {
    print(e);
  }
  if(isAuthenticate) return true;
  else return false;
}

Future postTest(context, String fullname,String password) async {
  listitems.clear();
  couponlistitems.clear();
  couponlist.clear();
  country_name.clear();
  ranklist.clear();
  String imei = await ImeiPlugin.getImei();
  final uri = 'https://class.yixinacademy.com/api/user/login';
  var  requestBody = {
    'email' : fullname,
    'password' : password,
    'imei' : imei,
  };
  
  http.Response response = await http.post(uri,body: requestBody);

  var responseObj = json.decode(response.body);

  if(responseObj == false) {
    return false;
  } else if(responseObj == "imei") {
    return "imei";
  } else {
    user_id = responseObj["user"]["id"];
    user_email = responseObj["user"]["email"];
    user_name  = responseObj["user"]["name"];
    user_phone_number = responseObj["user"]["phone"];
    user_fax = responseObj["user"]["fax"];
    user_city = responseObj["user"]["city"];
    user_country = responseObj["user"]["country"];
    user_zip = responseObj["user"]["zip"];
    user_address = responseObj["user"]["address"];
    user_affiliate_bonus = responseObj["user"]["affilate_income"].toDouble();
    user_coin = responseObj["user"]["current_coin"].toDouble();
    country_name = responseObj["country_name"] != null ? List.from(responseObj["country_name"]) : null;
    country_name.add("Select Country");
    await getCourse();
    final getinvoiceuri = 'https://class.yixinacademy.com/api/user/apigetinvoice/${user_id}';
    http.Response response1 = await http.get(getinvoiceuri);
    var responseObj1 = json.decode(response1.body);
    print(responseObj1);
    for(int i = 0;i < responseObj1["title"].length; i++)
    {
      listitems.add({"invoice" : "${responseObj1["number"][i]}", "title" : "${responseObj1["title"][i]}","price" : "${responseObj1["price"][i]}","date" : "${responseObj1["date"][i]}"});
    }
    for(int i = 0;i < responseObj1["coupon_date"].length; i++)
    {
      couponlistitems.add({"date":"${responseObj1["coupon_date"][i]}","title":"${responseObj1["coupon_title"][i]}","code":"${responseObj1["coupon_code"][i]}","times":"${responseObj1["coupon_times"][i]}",});
      couponlist.add(responseObj1["coupon_code"][i]);
    }
    for(int i = 0;i < 10; i++)
    {
      int p = i + 1;
      ranklist.add({"number":"${p}","name":"${responseObj1["rank_name"][i]}","price":"${responseObj1["rank_price"][i]}"});
    }
    user_price = responseObj1["price"];
    user_date = responseObj1["date"];
    if(await _checkStatusLogin())
    {
      handleTimeout(context);
          QuerySnapshot userInfoSnapshot =
              await DatabaseMethods().getUserInfo(user_email);
          if(userInfoSnapshot.documents.length == 0)
          {
            DatabaseMethods databaseMethods = new DatabaseMethods();
            Map<String,String> userDataMap = {
              "userName" : user_name,
              "userEmail" : user_email
            };
            databaseMethods.addUserInfo(userDataMap);
            HelperFunctions.saveUserLoggedInSharedPreference(true);
            HelperFunctions.saveUserNameSharedPreference(user_name);
            HelperFunctions.saveUserEmailSharedPreference(user_email);
          }
          else {
            HelperFunctions.saveUserLoggedInSharedPreference(true);
            HelperFunctions.saveUserNameSharedPreference(userInfoSnapshot.documents[0].data["userName"]);
            HelperFunctions.saveUserEmailSharedPreference(userInfoSnapshot.documents[0].data["userEmail"]);
          }
//      _timer =  Timer(Duration(seconds:2),()=>handleTimeout(context));
      return true;
    }
  }
}

_onBasicAlertPressed(context,fullname,password) {
  Alert(
    context: context,
    title: fullname,
    desc: password,
  ).show();
}


showAlertDialog(BuildContext context,int id, String name, String date, String time, String position) {

  // set up the buttons
  Widget remindButton = FlatButton(
    child: Text("Yes"),
    onPressed:  () async{
      await adduserscheduledata(id,1);
      Navigator.of(context).pop();
    },
  );
  Widget cancelButton = FlatButton(
    child: Text("No"),
    onPressed:  () async{
      await adduserscheduledata(id,0);
      Navigator.of(context).pop();
    },
  );
  Widget launchButton = FlatButton(
    child: Text("Maybe"),
    onPressed:  () {
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(name),
    content: Text("StartTime : ${date} ${time}\nPosition : ${position}"),
    actions: [
      remindButton,
      cancelButton,
      launchButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

handleTimeout(context) async {  // callback function
  await getshowscheduledata();
  await getscheduledata();
  if(schedulenamelist.length != 0) {
    for(int i = 0;i < schedulenamelist.length; i++)
    {
      showAlertDialog(context, scheduleidlist[i], schedulenamelist[i], schdulestartdate[i] , schdulestarttime[i], schduleposition[i]);
    }
  }
  _timer =  Timer(Duration(seconds:600),()=>handleTimeout(context));
}

class _LoginScreenWidgetState extends State<LoginScreenWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool checkboxvalue = true;
  void reset() {
    setState(() {});
  }

  String fullname = '';

  String password = '';

  void changename(value) {
    fullname = value;
    reset();
  }

  void changepassword(value) {
    password = value;
    reset();
  }

  @override
  Widget build(BuildContext context) {


    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    var size = MediaQuery.of(context).size;
    TextStyle textStyle = new TextStyle(color: Colors.black, fontSize: 17);

    return Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomPadding: true,
        body: Padding(
          padding: const EdgeInsets.only(top: 20, left: 35, right: 35),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                    Container(
                      padding: EdgeInsets.all(30),
                      child: Text(
                        'Account Login',
                        style: TextStyle(
                            fontSize: 34 * size.width / 390,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                    SizedBox(height: 40 * size.height / 750),
                    CustomTextField('Type Email Address', Icons.person, context,
                        changename),
                    SizedBox(height: 20 * size.height / 750),
                    CustomTextField(
                        'Type Password', Icons.vpn_key, context, changepassword,
                        isObscureText: true),

                    SizedBox(height: 30 * size.height / 750),
                    Container(
                      height: 40,
                      width: size.width,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Positioned(
                            left: -15,
                            child: Container(
                              child: Checkbox(
                                checkColor: Colors.white,
                                activeColor: Colors.black,
                                onChanged: (bool value) {
                                  checkboxvalue = value;
                                  reset();
                                },
                                value: checkboxvalue,
                              ),
                            ),
                          ),
                          Positioned(
                              left: 30 * size.width / 390,
                              child: Container(
                                width: 100 * size.width / 390,
                                child: Text(
                                  'Remember Password',
                                  style: textStyle,
                                ),
                              )),
                          Positioned(
                            left: 230 * size.width / 390,
                            child: Container(
                                width: 100 * size.width / 390,
                                child: GestureDetector(
                                  child: Text(
                                    'Forgot Password?',
                                    style: textStyle,
                                  ),
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(_createRoutetoforgot());
                                  },
                                )),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40 * size.height / 750),
                    //login button
                    FlatButton(
                        padding: EdgeInsets.all(0),
                        onPressed: () async {
                          var _getlogindata;
                          _getlogindata = await postTest(context, fullname, password);
//                          _getlogindata = await _checkStatusLogin();
                          setState(() {
//                            _onBasicAlertPressed(context,fullname,password);
                          });
                          if(_getlogindata == true) {
                            Navigator.of(context).push(_createRoutetomain());
                            registered = true;
                          }
                          else if(_getlogindata == false){
                            _onBasicAlertPressed(context,"Try Again","Email or Password is not match\n or Please take your fingerprint",);
                          } else {
                            _onBasicAlertPressed(context,"Warning","You are using other device.\n Please use your device",);
                          }
                        },
                        child: Container(
                          color: Colors.black,
                          width: size.width,
                          height: 60 * size.height / 750,
                          alignment: Alignment.center,
                          child: Text(
                            'LOG IN',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        )),
                    SizedBox(height: 10 * size.height / 750),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          color: Colors.black.withOpacity(0.2),
                          width: size.width * 1 / 5,
                          height: 3,
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          child: Text(
                            'OR',
                            style: TextStyle(color: Colors.black, fontSize: 24),
                          ),
                        ),
                        Container(
                          color: Colors.black.withOpacity(0.2),
                          width: size.width * 1 / 5,
                          height: 3,
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.all(20 * size.width / 390),
                      child: Text(
                        'Sign In with social media',
                        style: TextStyle(
                            fontSize: 24 * size.width / 395,
                            fontWeight: FontWeight.w200,
                            color: Colors.blueGrey[800]),
                      ),
                    ),
                    //floating buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FloatingActionButton(
                          heroTag: null,
                          backgroundColor: Colors.blue[900],
                          onPressed: () {},
                          child: Text(
                            'f',
                            style: TextStyle(
                                fontSize: 23,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          width: 10 * size.width / 390,
                        ),
                        FloatingActionButton(
                          heroTag: null,
                          backgroundColor: Color.fromRGBO(180, 0, 0, 1),
                          onPressed: () {},
                          child: Text(
                            'G+',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ]),
            ),
          ),
        ));
  }

  Widget CustomTextField(
      String _hint, IconData _iconData, BuildContext context, Function submit,
      {bool isObscureText = false, bool readonly = false}) {
    var theme = Theme.of(context);
    var colorSurface = theme.colorScheme.onSurface;
    TextStyle textStyle = TextStyle(
        color: colorSurface, fontFamily: 'Roboto-Regular', fontSize: 18);
    var size = MediaQuery.of(context).size;

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: size.width,
          height: 60 * size.height / 750,
          decoration: BoxDecoration(
              color: Colors.blue[50].withOpacity(0.4),
              border: Border.all(
                  width: 2,
                  style: BorderStyle.solid,
                  color: Colors.black.withOpacity(0.4))),
        ),
        TextField(
            onChanged: (value) {
              setState(() {
                submit(value);
              });
            },
            readOnly: readonly,
            obscureText: isObscureText,
            keyboardType: TextInputType.emailAddress,
            maxLines: 1,
            style: textStyle,
            decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                icon: Padding(
                  padding: EdgeInsets.only(left: 20 * size.width / 390),
                  child: Icon(_iconData, color: colorSurface),
                ),
                contentPadding: EdgeInsets.only(top: 3),
                hintStyle: textStyle,
                hintText: '$_hint')),
      ],
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

Route _createRoutetoforgot() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => Forgetpassword(),
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
