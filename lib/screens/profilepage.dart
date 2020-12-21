import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Juhuischool/screens/startpage.dart';
import 'package:Juhuischool/screens/login2_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

Future postProfile() async {
  final uri = 'https://class.yixinacademy.com/api/user/updateuser';
  var  requestBody = {
    'email' : emailtext,
    'name' : nametext,
    'phone' : phonetext,
    'fax' : faxtext,
    'city' : citytext,
    'country' : user_country,
    'zip' : ziptext,
    'address' : addresstext,
  };
  
  http.Response response = await http.post(uri,body: requestBody);

  var responseObj = json.decode(response.body);
  return responseObj;
}

String emailtext = user_email;
String nametext = user_name;
String phonetext = user_phone_number;
String faxtext = user_fax;
String citytext = user_city;
String countrytext = user_country;
String ziptext = user_zip;
String addresstext = user_address;

class _ProfilePageState extends State<ProfilePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    var size = MediaQuery.of(context).size;
    if(user_country == null) countrytext = 'Select Country';
    return new Scaffold(
        key: _scaffoldKey,
        drawer: Menulist(),
        resizeToAvoidBottomPadding: true,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: <Widget>[
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
              Padding(
                padding: const EdgeInsets.all(15),
                child: new TextFormField(
                  initialValue: user_name,
                  decoration: new InputDecoration(
                    labelText: "Enter Name",
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(5.0),
                      borderSide: new BorderSide(
                      ),
                    ),
                  ),
                  onChanged: (String tval) {
                    setState(() {
                      nametext = tval;
                    });
                  }
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: new TextFormField(
                  enabled: false,
                  initialValue: user_email,
                  decoration: new InputDecoration(
                    labelText: "Enter Email",
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(5.0),
                      borderSide: new BorderSide(
                      ),
                    ),
                  ),
                  onChanged: (String tval) {
                    setState(() {
                      emailtext = tval;
                    });
                  }
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: new TextFormField(
                  initialValue: user_phone_number,
                  decoration: new InputDecoration(
                    labelText: "Enter Phone Number",
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(5.0),
                      borderSide: new BorderSide(
                      ),
                    ),
                  ),
                  onChanged: (String tval) {
                    setState(() {
                      phonetext = tval;
                    });
                  }
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: new TextFormField(
                  initialValue: user_fax,
                  decoration: new InputDecoration(
                    labelText: "Enter Fax",
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(5.0),
                      borderSide: new BorderSide(
                      ),
                    ),
                  ),
                  onChanged: (String tval) {
                    setState(() {
                      faxtext = tval;
                    });
                  }
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: new TextFormField(
                  initialValue: user_city,
                  decoration: new InputDecoration(
                    labelText: "Enter City",
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(5.0),
                      borderSide: new BorderSide(
                      ),
                    ),
                  ),
                  onChanged: (String tval) {
                    setState(() {
                      citytext = tval;
                    });
                  }
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: DropdownButton(
                  hint: Text('Select Country'),
                  value: user_country,
                  onChanged: (newValue) {
                    setState(() {
                      user_country = newValue;
                      this.setState(() {});
                    });
                  },
                  items: country_name.map((location) {
                    return DropdownMenuItem(
                      value: location,
                      child: Text(location),
                    );
                  }).toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: new TextFormField(
                  initialValue: user_zip,
                  decoration: new InputDecoration(
                    labelText: "Enter Zip",
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(5.0),
                      borderSide: new BorderSide(
                      ),
                    ),
                  ),
                  onChanged: (String tval) {
                    setState(() {
                      ziptext = tval;
                    });
                  }
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: new TextFormField(
                  initialValue: user_address,
                  decoration: new InputDecoration(
                    labelText: "Enter Address",
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(5.0),
                      borderSide: new BorderSide(
                      ),
                    ),
                  ),
                  onChanged: (String tval) {
                    setState(() {
                      addresstext = tval;
                    });
                  }
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: FlatButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  splashColor: Colors.blueAccent,
                  onPressed: () async{
                    if(await postProfile() == true)
                    {            
                      _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text('Your Update Saved')));
                    }
                  },
                  child: Text(
                    "Save",
                    style: TextStyle(fontSize: 30.0),
                  ),
                ),
              ),
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
