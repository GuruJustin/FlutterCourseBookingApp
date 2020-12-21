import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String _hint;
  final bool isObscureText;
  final IconData _iconData;

  const CustomTextField(this._hint, this._iconData,
      {Key key, this.isObscureText = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var colorSurface = theme.colorScheme.onSurface;
    TextStyle textStyle = TextStyle(
        color: colorSurface, fontFamily: 'Roboto-Regular', fontSize: 18);
    var size = MediaQuery.of(context).size;

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: size.width,
          height: 60 * size.height / 750,
          decoration: BoxDecoration(
              color: Colors.blue[50].withOpacity(0.4),
              border: Border.all(
                  width: 2,
                  style: BorderStyle.solid,
                  color: Colors.black.withOpacity(0.4))),
        ),
        TextField(
            obscureText: isObscureText,
            keyboardType: TextInputType.emailAddress,
            maxLines: 1,
            style: textStyle,
            decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                icon: Padding(
                  padding: EdgeInsets.only(left: 20 * size.width / 390),
                  child: Icon(_iconData, color: colorSurface),
                ),
                contentPadding: EdgeInsets.only(top: 3),
                hintStyle: textStyle,
                hintText: '$_hint')),
      ],
    );
  }
}
