import 'package:flutter/material.dart';
import 'package:Juhuischool/screens/views/colors.dart';

class AppBarWithBackButton extends StatelessWidget with PreferredSizeWidget {
  final double elementHeight = 50;
  final Color backgroundColor;
  final Brightness brightness;
  final Color buttonColor;

  AppBarWithBackButton({
    this.backgroundColor,
    this.brightness,
    this.buttonColor
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: AppBar(
        backgroundColor: backgroundColor ?? whiteColor,
        brightness: brightness ?? Brightness.light,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: false,
        titleSpacing: 0,
        title: RawMaterialButton(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          constraints: BoxConstraints(minWidth: 0, minHeight: elementHeight),
          splashColor: Colors.transparent,
          padding: EdgeInsets.symmetric(horizontal: 28),
          child: Icon(
            Icons.arrow_back,
            color: buttonColor ?? blackColor,
            size: 30
          ),
          onPressed: () => Navigator.pop(context)
        )
      )
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(elementHeight);
}