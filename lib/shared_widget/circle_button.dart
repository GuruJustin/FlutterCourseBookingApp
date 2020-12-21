import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final GestureTapCallback onTap;
  final IconData iconData;
  final bool a;

  const CircleButton(this.a, {Key key, this.onTap, this.iconData})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    double size = 10.0;

    return new InkResponse(
      onTap: onTap,
      child: new Container(
        width: size,
        height: size,
        decoration: new BoxDecoration(
            color: (a ? Color(0xdd2279a3) : Colors.grey[400]),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: const Color(0xaa000000),
                offset: Offset(0, 0.3),
                blurRadius: 3,
              ),
            ]),
      ),
    );
  }
}
