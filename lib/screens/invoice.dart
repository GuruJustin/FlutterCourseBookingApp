import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Juhuischool/screens/startpage.dart';
import 'package:Juhuischool/screens/login2_screen.dart';

class structPageinfo {
  String pagetitle;
  int pageid;
  List<String> datadetail;
}


class Datastruct {
  List<String> data;
  int dataid;
}


class Invoice extends StatefulWidget {
  @override
  _InvoiceState createState() => _InvoiceState();
}

class _InvoiceState extends State<Invoice> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//data
  double bonus = user_affiliate_bonus;
  double coin = user_coin;
//data
  @override
  void initState() {
    super.initState();
//     getinvoicedata();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    var size = MediaQuery.of(context).size;
    var index = 0;
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
                            'Invoice Id',
                            style: TextStyle(fontSize: 20,fontStyle: FontStyle.italic),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Title',
                            style: TextStyle(fontSize: 20,fontStyle: FontStyle.italic),
                          ),
                        ),
                      ],
                      rows: listitems.map(
                        ((element) => DataRow(
                          cells: <DataCell> [
                            DataCell(
                              Text(element["invoice"]),
                                onTap: () {
                                  _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text("Date:${element["date"]} Price:${element["price"]}")));
                                },
                              ), //Extracting from Map element the value
                            DataCell(Text(element["title"]),
                              onTap: () {
                                  _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text("Date:${element["date"]} Price:${element["price"]}")));
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

                  SizedBox(
                    height: 60 * size.height / 750,
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
/*
class searchwidget extends StatefulWidget {
  //pagedata
  pageinfostruct pageinfo;
  List<Datastruct> pagedata;

  searchwidget({this.pageinfo, this.pagedata});
  @override
  _searchwidgetState createState() =>
      _searchwidgetState(pagedata: pagedata, pageinfo: pageinfo);
}

class _searchwidgetState extends State<searchwidget> {
  pageinfostruct pageinfo;
  List<Datastruct> pagedata;

  //show data
  int shownum = 0;

  //searchdata
  _searchwidgetState({this.pageinfo, this.pagedata});
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.all(Radius.circular(10 * size.height / 750)),
          border: Border.all(width: 2, color: Colors.grey[300])),
      child: Column(
        children: [
          Text(
            pageinfo.pagetitle + '               ',
            style: TextStyle(fontSize: 30 * size.height / 750),
          ),
          Container(
            height: 2,
            margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
          ),
          Row(
            children: [
              Text('Show'),
              Container(
                margin: EdgeInsets.fromLTRB(
                    3 * size.width / 390,
                    10 * size.width / 390,
                    3 * size.width / 390,
                    10 * size.width / 390),
                width: 100 * size.width / 390,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5 * size.width / 390),
                    border: Border.all(width: 2, color: Colors.grey)),
                child: TextField(
                  decoration: InputDecoration(border: InputBorder.none),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    shownum = int.parse(value);
                  },
                ),
              ),
              Text('entries')
            ],
          ),
          Row(
            children: [Text('Search')],
          ),
        ],
      ),
    );
  }
}
*/
