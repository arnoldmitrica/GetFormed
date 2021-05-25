import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textColor;
  final double height;
  final TextStyle textStyle;
  final Icon icon;
  const RoundedButton(
      {Key key,
      this.text,
      this.press,
      this.color,
      this.textColor = Colors.white,
      this.height = 10,
      this.textStyle,
      this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: height),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(color),
            padding: MaterialStateProperty.all(
                EdgeInsets.symmetric(vertical: 20, horizontal: 40)),
          ),
          onPressed: press,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              text,
              style:
                  textStyle == null ? TextStyle(color: textColor) : textStyle,
            ),
            icon != null
                ? icon
                : Container(
                    width: 0,
                    height: 0,
                  )
          ]),
        ),
      ),
    );
  }
}
