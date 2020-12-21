import 'dart:math';

import 'package:Juhuischool/screens/services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Juhuischool/screens/startpage.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:Juhuischool/screens/login2_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'helper/helperfunctions.dart';

_onBasicBotAlertPressed(context,fullname,password) {
  Alert(
    context: context,
    title: fullname,
    desc: password,
  ).show();
}
String fullname = '';
DateTime birthdate = new DateTime.now();
String sex = 'Male';
String address = '';
String phone = '';
String email = '';
String uerid = '';
String sponso = '';
String password = '';
String confirmpassword = '';
String testcode = '';

Future userregister() async {
  final uri = 'https://class.yixinacademy.com/api/user/register';
  var  requestBody = {
    'name' : fullname,
    'date' : birthdate.toString(),
    'address' : address,
    'phone' : phone,
    'email' : email,
    'affilate_code' : uerid,
    'Sponsor' : sponso,
    'password' : password,
  };
    http.Response response = await http.post(uri,body: requestBody);

  var responseObj = json.decode(response.body);
  return responseObj;
}

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<bool> sexselected = [true, false];
  List<String> capchacode = ["XWWCm0","UYkGpY","m6ENJh","kZx0vV","hhuccJ","xQYK0B"];
  TextEditingController _controller = TextEditingController();

  //testdata
  List<String> teststring = [];
  List<String> testimage = [
    'assets/testimage (1).png',
    'assets/testimage (2).png',
    'assets/testimage (3).png',
    'assets/testimage (4).png',
    'assets/testimage (5).png',
    'assets/testimage (6).png'
  ];

  void reset() {
    setState(() {});
  }

  void changename(value) {
    fullname = value;
    reset();
  }

  void changedate(value) {
    birthdate = value;
    reset();
  }

  void changesex(value) {
    reset();
  }

  void changeaddress(value) {
    address = value;
    reset();
  }

  void changephone(value) {
    phone = value;
    reset();
  }

  void changemail(value) {
    email = value;
    reset();
  }

  void changeuserid(value) {
    uerid = value;
    reset();
  }

  void changespomso(value) {
    sponso = value;
    reset();
  }

  void changepassword(value) {
    password = value;
    reset();
  }

  void changeconfirmpassword(value) {
    confirmpassword = value;
    reset();
  }

  void changetestcode(value) {
    testcode = value;
    reset();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    var size = MediaQuery.of(context).size;
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
                        'SIGNUP NOW',
                        style: TextStyle(
                            fontSize: 34 * size.width / 390,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                    SizedBox(height: 20 * size.height / 750),
                    CustomTextField(
                        'Full Name', Icons.person, context, changename,
                        ),
                    SizedBox(height: 20 * size.height / 750),
                    CustomTextField('Male', Icons.person, context, changesex,
                        readonly: true),
                    SizedBox(height: 20 * size.height / 750),
                    CustomTextFielddate(
                        'Full Birthday', Icons.cake, context, changedate),
                    SizedBox(height: 20 * size.height / 750),
                    CustomTextField(
                        'Address', Icons.place, context, changeaddress),
                    SizedBox(height: 20 * size.height / 750),
                    CustomTextField(
                        'Mobile', Icons.phone, context, changephone),
                    SizedBox(height: 20 * size.height / 750),
                    CustomTextField('Email', Icons.email, context, changemail),
                    SizedBox(height: 20 * size.height / 750),
                    CustomTextField('Preferred User ID', Icons.device_hub,
                        context, changeuserid),
                    SizedBox(height: 20 * size.height / 750),
                    CustomTextField('Email of International Sponso',
                        Icons.device_hub, context, changespomso),
                    SizedBox(height: 20 * size.height / 750),
                    CustomTextField(
                        'Password', Icons.vpn_key, context, changepassword,
                        isObscureText: true),
                    SizedBox(height: 20 * size.height / 750),
                    CustomTextField('Confirm Password', Icons.vpn_key, context,
                        changeconfirmpassword,
                        isObscureText: true),
                    SizedBox(height: 20 * size.height / 750),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            width: size.width / 2,
                            height: 60 * size.height / 750,
                            child: Image(
                              image: AssetImage(testimage[testpos]),
                              fit: BoxFit.fill,
                            )),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                    SizedBox(height: 20 * size.height / 750),
                    CustomTextField(
                        'Enter Code', Icons.autorenew, context, changetestcode),
                    SizedBox(height: 30 * size.height / 750),
                    FlatButton(
                        padding: EdgeInsets.all(0),
                        onPressed: () async{
                          if(testcode != capchacode[testpos]) _onBasicBotAlertPressed(context,"Try Again","You are a bot",);
                          else {
                            if(fullname == '') _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text("NameField is empty")));
                            else if(sex == '') _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text("SexField is empty")));
                            else if(address == '') _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text("AddressField is empty")));
                            else if(phone == '') _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text("PhoneField is empty")));
                            else if(email == '') _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text("EmailField is empty")));
                            else if(uerid == '') _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text("UserIdField is empty")));
                            else if(password == '') _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text("PasswordField is empty")));
                            else if(password != confirmpassword) _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text("Password Does Not Match")));
                            else {
                              var returnvalue = await userregister();
                              if(returnvalue == true)
                              {
                                DatabaseMethods databaseMethods = new DatabaseMethods();
                                Map<String,String> userDataMap = {
                                  "userName" : fullname,
                                  "userEmail" : email
                                };
                                databaseMethods.addUserInfo(userDataMap);
                                
                                Navigator.of(context).push(_createRoutetomain());
                              }
                              else _onBasicBotAlertPressed(context,"Try Again",returnvalue.toString(),);
                            }
                          }
                        },
                        child: Container(
                          color: Colors.black,
                          width: size.width,
                          height: 60 * size.height / 750,
                          alignment: Alignment.center,
                          child: Text(
                            'REGISTER',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        )),
                    SizedBox(height: 60 * size.height / 750),
                  ]),
            ),
          ),
        ));
  
  }

  //textfield
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
            controller: readonly ? _controller : null,
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
        if (readonly)
          Positioned(
            right: 10,
            child: ToggleButtons(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  width: 55 * size.height / 750,
                  height: 55 * size.height / 750,
                  child: Image(
                    image: AssetImage('assets/man.png'),
                    fit: BoxFit.fitHeight,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    border: Border.all(
                        style: BorderStyle.solid,
                        width: sexselected[0] ? 2 : 0),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  width: 55 * size.height / 750,
                  height: 55 * size.height / 750,
                  child: Image(
                    image: AssetImage('assets/woman.png'),
                    fit: BoxFit.fitHeight,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    border: Border.all(
                        style: BorderStyle.solid,
                        width: sexselected[1] ? 2 : 0),
                  ),
                ),
              ],
              isSelected: sexselected,
              onPressed: (index) {
                sexselected[index] = true;
                if (index == 0) {
                  sexselected[1] = false;
                  _controller.text = "Male";
                  sex = "Male";
                } else {
                  sexselected[0] = false;
                  _controller.text = "Female";
                  sex = "FeMale";
                }
                reset();
              },
            ),
          )
      ],
    );
  }

  Widget CustomTextFielddate(
      String _hint, IconData _iconData, BuildContext context, Function submit,
      {bool isObscureText = false}) {
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
        TextFormField(
            controller: new TextEditingController()
              ..text = birthdate.year.toString() +
                  "/" +
                  birthdate.month.toString() +
                  "/" +
                  birthdate.day.toString(),
            onTap: () async {
              DatePicker.showDatePicker(context,
                  showTitleActions: true,
                  theme: DatePickerTheme(
                      itemStyle: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
                      doneStyle: TextStyle(color: Colors.white, fontSize: 16)),
                  onChanged: (date) {
                    changedate(date);
                print('change ${date.day} in time zone ' + date.timeZoneOffset.inHours.toString());
              }, onConfirm: (date) {

                changedate(date);
                print('confirm $date');
              }, currentTime: birthdate, locale: LocaleType.en);
            },
            readOnly: true,
            obscureText: isObscureText,
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
