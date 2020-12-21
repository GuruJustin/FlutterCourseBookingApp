import 'package:flutter/material.dart';

class ThemeButton extends StatelessWidget {
  final Function onTap;
  final String _text;
  final FocusNode focusNode;
  final Route rouname;
  const ThemeButton(this._text, this.rouname,
      {Key key, this.onTap, this.focusNode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var bodyText1 =
        TextStyle(color: theme.colorScheme.surface, fontFamily: 'Roboto-Bold');

    return RaisedButton(
      onPressed: () {
        Navigator.of(context).push(rouname);
      },
      focusNode: focusNode == null ? FocusNode() : focusNode,
      child: Text(
        '$_text',
        style: bodyText1,
      ),
    );
  }
}
