import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Juhuischool/screens/startpage.dart';
import 'package:Juhuischool/screens/login2_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class Coupontransfer extends StatefulWidget {
  @override
  _CoupontransferState createState() => _CoupontransferState();
}

Future postCourse() async{
  final uri = 'https://class.yixinacademy.com/api/user/courseupper';
  var  requestBody = {
    'username' : couponusername,
    'coupon' : couponcode,
    'id' : user_id.toString(),
  };
  http.Response response = await http.post(uri,body: requestBody);

  var responseObj = json.decode(response.body);
  return responseObj;
}


String couponusername = '';
String couponcode = couponlist[0];


class _CoupontransferState extends State<Coupontransfer> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//data
  double bonus = user_affiliate_bonus;
  double coin = user_coin;
//data

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    
    var size = MediaQuery.of(context).size;
    return Scaffold(
        key: _scaffoldKey,
        drawer: Menulist(),
        resizeToAvoidBottomPadding: true,
        body: Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Center(
              child: SingleChildScrollView(
              child: Column(
                children: [
                  //logo
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
                    height: 20 * size.height / 750,
                  ),
                  
                  Container(
                    margin: EdgeInsets.only(top: 5 * size.height / 750),
                    width: size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                            Radius.circular(10 * size.height / 750)),
                        border: Border.all(width: 2, color: Colors.grey[300])),
                    child: DataTable(
                      columns: const <DataColumn>[
                        DataColumn(
                          label: Text(
                            'Course Name',
                            style: TextStyle(fontSize: 20,fontStyle: FontStyle.italic),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Code',
                            style: TextStyle(fontSize: 20,fontStyle: FontStyle.italic),
                          ),
                        ),
                      ],
                      rows: couponlistitems.map(
                        ((element) => DataRow(
                          cells: <DataCell> [
                            DataCell(
                              Text(element["title"]),
                                onTap: () {
                                  _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text("Date:${element["date"]} times:${element["times"]}")));
                                },
                              ), //Extracting from Map element the value
                            DataCell(Text(element["code"]),
                              onTap: () {
                                  _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text("Date:${element["date"]} times:${element["times"]}")));
                                },
                            ),
                          ],
                        )),
                      ).toList(),
                    ),
                  ),
                  
                  SizedBox(
                    height: 20 * size.height / 750,
                  ),

                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: new TextFormField(
                      initialValue: couponusername,
                      decoration: new InputDecoration(
                        labelText: "User Name",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0),
                          borderSide: new BorderSide(
                          ),
                        ),
                      ),
                      onChanged: (String tval) {
                        setState(() {
                          couponusername = tval;
                        });
                      }
                    ),
                  ),
                  
                  
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: DropdownButton(
                      hint: Text('CouponCode'),
                      value: couponcode,
                      onChanged: (newValue) {
                        setState(() {
                          couponcode = newValue;
                          this.setState(() {});
                        });
                      },
                      items: couponlist.map((location) {
                        return DropdownMenuItem(
                          value: location,
                          child: Text(location),
                        );
                      }).toList(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: FlatButton(
                      color: Colors.blue,
                      textColor: Colors.white,
                      splashColor: Colors.blueAccent,
                      onPressed: () async{
                          _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text(await postCourse())));
                      },
                      child: Text(
                        "OFFER COURSE",
                        style: TextStyle(fontSize: 30.0),
                      ),
                    ),
                  ),
                ],
              ),
            ))));
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

