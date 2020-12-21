import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Juhuischool/screens/startpage.dart';

class Buydetail extends StatefulWidget {
  @override
  _BuydetailState createState() => _BuydetailState();
}

class _BuydetailState extends State<Buydetail> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  //data
  int radiovalue = 0;
  String paylah = '';
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    var size = MediaQuery.of(context).size;

    TextStyle maintextstyle = new TextStyle(
        color: Colors.black,
        fontSize: 18 * size.width / 390,
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
              height: 30 * size.height / 750,
            ),
            //payment info
            Container(
              padding: EdgeInsets.all(20 * size.width / 390),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    width: size.width,
                    height: 2,
                    color: Colors.grey[400],
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image(
                          width: 100 * size.width / 390,
                          image: AssetImage(
                            prizeimage[prizepos],
                          ),
                          fit: BoxFit.fill,
                        ),
                        Text(
                          prizeinfolist[prizepos].firsttexttitle,
                          style: TextStyle(
                            fontSize: 15 * size.width / 390,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'c\u{24}' + prizecost[prizepos],
                          style: TextStyle(
                            fontSize: 15 * size.width / 390,
                            color: Colors.black,
                          ),
                        ),
                      ]),
                  SizedBox(
                    height: 60 * size.height / 750,
                  ),
                  Text(
                    'Payment Info',
                    style: maintextstyle,
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 20),
                    width: size.width,
                    height: 2,
                    color: Colors.grey[400],
                  ),
                  Row(
                    children: [
                      Radio<int>(
                        value: 0,
                        activeColor: Colors.grey[900],
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        groupValue: radiovalue,
                        onChanged: (value) {
                          setState(() {
                            radiovalue = value;
                          });
                        },
                      ),
                      Text(
                        ' Paynow',
                        style: subtextstyle,
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Radio<int>(
                        value: 1,
                        activeColor: Colors.grey[900],
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        groupValue: radiovalue,
                        onChanged: (value) {
                          setState(() {
                            radiovalue = value;
                          });
                        },
                      ),
                      Text(
                        ' Stripe/Visa? 付款方式',
                        style: subtextstyle,
                      )
                    ],
                  ),
                  if (radiovalue == 1)
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          3 * size.width / 390,
                          10 * size.width / 390,
                          3 * size.width / 390,
                          10 * size.width / 390),
                      width: size.width,
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(5 * size.width / 390),
                          border: Border.all(width: 2, color: Colors.grey)),
                      child: TextField(
                        decoration: InputDecoration(border: InputBorder.none),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          paylah = value;
                        },
                      ),
                    ),
                  GestureDetector(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      padding: EdgeInsets.fromLTRB(
                          20 * size.width / 390, 6, 20 * size.width / 390, 6),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius:
                            BorderRadius.circular(40 * size.width / 390),
                      ),
                      child: Text(
                        'CONTINUE',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17 * size.height / 750,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    onTap: () {},
                  )
                ],
              ),
            ),

            Container(
              margin: EdgeInsets.fromLTRB(0, 10, 0, 20),
              width: size.width,
              height: 2,
              color: Colors.grey[400],
            ),
            //price detail
            Container(
              padding: EdgeInsets.all(30 * size.height / 750),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'PRICE DETAILS',
                    style: maintextstyle,
                  ),
                  SizedBox(
                    height: 15 * size.height / 750,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Price',
                        style: subtextstyle,
                      ),
                      Text(
                        'c\u{24}' + prizecost[prizepos],
                        style: subtextstyle,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15 * size.height / 750,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Discount (If Any)',
                        style: subtextstyle,
                      ),
                      Text(
                        '',
                        style: subtextstyle,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15 * size.height / 750,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tax',
                        style: subtextstyle,
                      ),
                      Text(
                        '0%',
                        style: subtextstyle,
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 20),
                    width: size.width,
                    height: 2,
                    color: Colors.grey[400],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: subtextstyle,
                      ),
                      Text(
                        'c\u{24}' + prizecost[prizepos],
                        style: subtextstyle,
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.all(10 * size.width / 390),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100 * size.width / 390),
                    border: Border.all(color: Colors.grey, width: 2)),
                child: GestureDetector(
                  child: Text(
                    'Enter Promo Code Here',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17 * size.width / 390,
                    ),
                  ),
                  onTap: () {},
                )),
            SizedBox(
              height: 60,
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
