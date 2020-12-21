import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Juhuischool/screens/startpage.dart';
import 'package:Juhuischool/screens/login2_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoder/geocoder.dart';
String showcoursename;
String showcoursedate;
String showcourseposition;
bool $flg = false;
final Set<Marker> _markers = {};
LatLng _center;

void getposition() async {
  final query = showcourseposition+",SG";
  var addresses = await Geocoder.local.findAddressesFromQuery(query);
  var first = addresses.first;
  
  print("${first.featureName} : ${first.coordinates}");

      _center = LatLng(first.coordinates.latitude,first.coordinates.longitude);
      print(_center);
      _markers.add(Marker(
        markerId: MarkerId("aaa"),
        position: LatLng(first.coordinates.latitude,first.coordinates.longitude),
        infoWindow: InfoWindow(
          title: showcoursename,
          snippet: "${showcoursedate}\n${showcourseposition}",
        ),
        icon:BitmapDescriptor.defaultMarker,
      ));
}
class ShowSchedule extends StatefulWidget {
  @override
  _ShowScheduleState createState() => _ShowScheduleState();
}

class _ShowScheduleState extends State<ShowSchedule> {
  GoogleMapController mapController;

//  LatLng _center = const LatLng(1.2948829,103.85447909999999);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    var size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("ScheduleName : "+showcoursename+"\nStartTime : "+showcoursedate+"\nPosition : "+showcourseposition),
          titleSpacing: 5.0,
          centerTitle: true,
          toolbarHeight: 100.2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 0.00,
          backgroundColor: Colors.green[700],
        ),
        body: Stack(
          alignment: AlignmentDirectional.bottomStart,
          children:<Widget> [
            showSchedulePlan(),
            GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 18.0,
              ),
              markers: _markers,
            ),
          ],
        ),
      ),
    );
  }
}

class showSchedulePlan extends StatefulWidget {
  @override
  _showSchedulePlanState createState() => _showSchedulePlanState();
}

class _showSchedulePlanState extends State<showSchedulePlan> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      child: Text("asdffdasfdas"),
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