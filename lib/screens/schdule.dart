import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:Juhuischool/screens/startpage.dart';
import 'package:Juhuischool/screens/login2_screen.dart';
import 'package:Juhuischool/screens/showschedule.dart';
import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

List<int> scheduleidlist = [];
List<String> schedulenamelist = [];
List<String> schdulestarttime = [];
List<String> schdulestartdate = [];
List<String> schduleposition = [];
List<int> scheduleshowidlist = [];
List<String> scheduleshownamelist = [];
List<String> schduleshowstarttime = [];
List<String> schduleshowstartdate = [];
List<String> schduleshowposition = [];
List<int> schduleshowpermission = [];
List<Color> colors = [Colors.yellow, 
  Colors.blue, 
  Colors.red];


class MySchedule extends StatefulWidget {
  @override
  _MyScheduleState createState() => _MyScheduleState();
}

class _MyScheduleState extends State<MySchedule> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: true,
      drawer: Menulist(),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 35, right: 35),
        child: Container(
          child:ListView.builder(
            itemCount: scheduleshowidlist.length,
            itemBuilder: (context, index) {
              final item = scheduleshowidlist[index];
              return Card(
                color: colors[schduleshowpermission[index]],
                child: ListTile(
                  title: Text("${scheduleshownamelist[index]}\n${schduleshowstartdate[index]} ${schduleshowstarttime[index]}\n${schduleshowposition[index]}", style: TextStyle(fontSize: 20, color:Colors.black),),
                  onTap: () async{
                    showcoursename = scheduleshownamelist[index];
                    showcoursedate = schduleshowstartdate[index] + " " + schduleshowstarttime[index];
                    showcourseposition = schduleshowposition[index];
                    $flg = false;
                    await getposition();
                    Navigator.of(context).push(_createRoutetoscheduledata());
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

getshowscheduledata() async {
  scheduleshowidlist.clear();
  scheduleshownamelist.clear();
  schduleshowstarttime.clear();
  schduleshowstartdate.clear();
  schduleshowposition.clear();
  schduleshowpermission.clear();
  final getinvoiceuri = 'https://class.yixinacademy.com/api/user/getshowschedule/${user_id}';
  http.Response response1 = await http.get(getinvoiceuri);
  var responseObj = jsonDecode(response1.body);
  for(int i = 0;i < responseObj["name"].length; i++) {
    scheduleshowidlist.add(responseObj["id"][i]);
    scheduleshownamelist.add(responseObj["name"][i]);
    schduleshowstarttime.add(responseObj["starttime"][i]);
    schduleshowposition.add(responseObj["position"][i]);
    schduleshowstartdate.add(responseObj["date"][i]);
    schduleshowpermission.add(responseObj["permission"][i]);
  }
  return true;
}

getscheduledata() async{
    schdulestarttime.clear();
    schedulenamelist.clear();
    schduleposition.clear();
    schdulestartdate.clear();
    scheduleidlist.clear();
    DateTime now_date = new DateTime.now();
    final getinvoiceuri = 'https://class.yixinacademy.com/api/user/getscheduletime';
    var  requestBody = {
        'user_id': user_id.toString(),
        'now_date': now_date.toString(),
    };
    http.Response response = await http.post(getinvoiceuri,body: requestBody);
    var responseObj = jsonDecode(response.body);
    for(int i = 0;i < responseObj["name"].length; i++) {
      scheduleidlist.add(responseObj["id"][i]);
      schedulenamelist.add(responseObj["name"][i]);
      schdulestarttime.add(responseObj["starttime"][i]);
      schduleposition.add(responseObj["position"][i]);
      schdulestartdate.add(responseObj["date"][i]);
    }
    print(responseObj);
    return true;
}

adduserscheduledata(int id,int permission) async {
//  final getinvoiceuri = 'https://class.yixinacademy.com/api';
    final getinvoiceuri = 'https://class.yixinacademy.com/api/user/adduserscheduletime';
    var  requestBody = {
        'user_id': user_id.toString(),
        'course_id': id.toString(),
        'permission': permission.toString(),
    };
    http.Response response = await http.post(getinvoiceuri,body: requestBody);
//    http.Response response = await http.get(getinvoiceuri);
    var responseObj = jsonDecode(response.body);
    print(responseObj);
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

Route _createRoutetoscheduledata() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => ShowSchedule(),
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