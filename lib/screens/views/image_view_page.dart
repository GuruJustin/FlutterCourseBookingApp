import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:Juhuischool/screens/views/colors.dart';
import 'package:Juhuischool/screens/views/appbar_with_backbutton.dart';

class ImageViewPage extends StatefulWidget {
  final String url;

  ImageViewPage({Key key, @required this.url}) : super(key: key);

  @override
  ImageViewPageState createState() => ImageViewPageState();
}

class ImageViewPageState extends State<ImageViewPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(true),
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              child: PhotoView(
                imageProvider: NetworkImage(widget.url),
              )
            ),
            Positioned(
              left: 0,
              top: 0,
              right: 0,
              child: AppBarWithBackButton(
                backgroundColor: Colors.transparent,
                brightness: Brightness.dark,
                buttonColor: whiteColor
              )
            )
          ]
        )
      )
    );
  }
}