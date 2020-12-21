
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Juhuischool/screens/startpage.dart';
import 'package:Juhuischool/main.dart';

const Color COLOR_PRIMARY = Color(0xFF0A4F70);
const Color COLOR_SECONDARY = Color(0xFF6C63FF);
const Color COLOR_PRIMARY_VARIANT = Color(0xFF338AB4);
const Color COLOR_SECONDARY_VARIANT = Color(0xFF8783CE);
const Color COLOR_SURFACE = Color(0xFFF7F5F6);
const Color COLOR_BACKGROUND = Color(0xFFF7F5F6);
const Color COLOR_ERROR = Color(0xFFd50000);
const Color COLOR_ON_PRIMARY = Color(0xFFF7F5F6);
const Color COLOR_ON_SECONDARY = Color(0xFF535461);
const Color COLOR_ON_SURFACE = Color(0xFF707070);
const Color COLOR_ON_BACKGROUND = Color(0xFF707070);
const Color COLOR_ON_ERROR = Color(0xFFF7F5F6);
const Color STATUS_BAR_COLOR = Color(0xFF338AB4);
const Color NAVIGATION_BAR_COLOR = Color(0x40000000);

final mySystemTheme = SystemUiOverlayStyle.light.copyWith(
    statusBarColor: STATUS_BAR_COLOR,
    systemNavigationBarColor: NAVIGATION_BAR_COLOR);

const COLOR_SCHEME = ColorScheme(
    primary: COLOR_PRIMARY,
    primaryVariant: COLOR_PRIMARY_VARIANT,
    secondary: COLOR_SECONDARY,
    secondaryVariant: COLOR_SECONDARY_VARIANT,
    surface: COLOR_SURFACE,
    background: COLOR_BACKGROUND,
    error: COLOR_ERROR,
    onPrimary: COLOR_ON_PRIMARY,
    onSecondary: COLOR_ON_SECONDARY,
    onSurface: COLOR_ON_SURFACE,
    onBackground: COLOR_ON_BACKGROUND,
    onError: COLOR_ON_ERROR,
    brightness: Brightness.light);

TextTheme _primaryTextTheme() {
  return TextTheme(
      bodyText1: TextStyle(
        fontSize: 17.0,
        color: COLOR_SURFACE,
        fontFamily: 'Roboto-Medium',
      ),
      bodyText2: TextStyle(
          fontSize: 15.0, fontFamily: 'Roboto-Regular', color: COLOR_PRIMARY),
      overline: TextStyle(
          color: COLOR_PRIMARY, fontFamily: 'Roboto-Medium', fontSize: 13.0),
      caption: TextStyle(
          fontSize: 12.0,
          color: COLOR_PRIMARY_VARIANT,
          fontFamily: 'Roboto-Medium'),
      headline6: TextStyle(
          fontFamily: 'Roboto-Bold',
          color: COLOR_PRIMARY_VARIANT,
          fontSize: 18.0),
      subtitle1: TextStyle(
          fontSize: 16.0,
          fontFamily: 'Roboto-Medium',
          color: COLOR_PRIMARY_VARIANT),
      subtitle2: TextStyle(
          fontSize: 15.0,
          fontFamily: 'Roboto-Light',
          color: COLOR_PRIMARY_VARIANT),
      headline5: TextStyle(
          height: 22.0,
          color: COLOR_SURFACE,
          fontSize: 21.0,
          fontFamily: 'Roboto-Bold'));
}

IconThemeData _customIconThemeData(IconThemeData base) {
  return base.copyWith(color: COLOR_PRIMARY);
}

ThemeData _buildAppTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
      colorScheme: COLOR_SCHEME,
      scaffoldBackgroundColor: COLOR_SURFACE,
      errorColor: COLOR_ERROR,
      accentColor: COLOR_SECONDARY,
      primaryColor: COLOR_PRIMARY,
      textTheme: _primaryTextTheme(),
      iconTheme: _customIconThemeData(base.iconTheme),
      buttonTheme: ButtonThemeData(
        buttonColor: COLOR_PRIMARY,
        highlightColor: COLOR_PRIMARY_VARIANT,
        padding: EdgeInsets.fromLTRB(40, 8, 40, 8),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12))),
      ));
}

class StartPageForChat extends StatefulWidget {
  @override
  _StartPageForChatState createState() => _StartPageForChatState();
}

class _StartPageForChatState extends State<StartPageForChat> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: _buildAppTheme(),
        title: '聚汇学堂',
        debugShowCheckedModeBanner: false,
        home: Startpage(),
      );
  }
}