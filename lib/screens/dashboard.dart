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

List<Datastruct> invoicedata = [];
void getinvoicedata() {
  invoicedata.add(Datastruct());
  invoicedata[0].data.add('yei61600055855');
  invoicedata[0].data.add('	易行天下（线下课）');
  invoicedata[0].data.add('14 Sep 2020');
  invoicedata[0].dataid = 0;
  invoicedata.add(Datastruct());
  invoicedata[1].data.add('FTwT1597810314');
  invoicedata[1].data.add('时空奇门（入门班）');
  invoicedata[1].data.add(' 19 Aug 2020');
  invoicedata[1].dataid = 1;
  invoicedata.add(Datastruct());
  invoicedata[2].data.add('wSVC1596993404');
  invoicedata[2].data.add('易行天下（线下课）');
  invoicedata[2].data.add(' 09 Aug 2020');
  invoicedata[2].dataid = 2;
  invoicedata.add(Datastruct());
  invoicedata[3].data.add('0Q0P1596909577');
  invoicedata[3].data.add('	易行天下（线下课）');
  invoicedata[3].data.add('08 Aug 2020');
  invoicedata[3].dataid = 3;
}

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
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
                  //bonus
                  Container(
                    width: size.width,
                    height: 360 * size.height / 750,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                            Radius.circular(10 * size.height / 750)),
                        border: Border.all(width: 2, color: Colors.grey[300])),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 55 * size.height / 750,
                        ),
                        GestureDetector(
                          child: Stack(
                              alignment: AlignmentDirectional.center,
                              children: [
                                Text(
                                  bonus.toString(),
                                  style: TextStyle(
                                    fontSize: 30 * size.width / 390,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  child: CircularProgressIndicator(
                                    value: 1,
                                    // _progress - _progress.floor(),
                                    strokeWidth: 22,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.lightBlue),
                                  ),
                                  width: 200 * size.width / 390,
                                  height: 200 * size.width / 390,
                                ),
                              ]),
                        ),
                        SizedBox(
                          height: 30 * size.height / 750,
                        ),
                        Text(
                          'Affiliate Bonus',
                          style: TextStyle(
                            fontSize: 22 * size.width / 390,
                          ),
                        )
                      ],
                    ),
                  ),
                  //coin
                  Container(
                    margin: EdgeInsets.only(top: 5 * size.height / 750),
                    width: size.width,
                    height: 360 * size.height / 750,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                            Radius.circular(10 * size.height / 750)),
                        border: Border.all(width: 2, color: Colors.grey[300])),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 55 * size.height / 750,
                        ),
                        GestureDetector(
                          child: Stack(
                              alignment: AlignmentDirectional.center,
                              children: [
                                Text(
                                  coin.toString(),
                                  style: TextStyle(
                                    fontSize: 30 * size.width / 390,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  child: CircularProgressIndicator(
                                    value: 1,
                                    // _progress - _progress.floor(),
                                    strokeWidth: 22,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.yellow[800]),
                                  ),
                                  width: 200 * size.width / 390,
                                  height: 200 * size.width / 390,
                                ),
                              ]),
                        ),
                        SizedBox(
                          height: 30 * size.height / 750,
                        ),
                        Text(
                          'Coin',
                          style: TextStyle(
                            fontSize: 22 * size.width / 390,
                          ),
                        )
                      ],
                    ),
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
