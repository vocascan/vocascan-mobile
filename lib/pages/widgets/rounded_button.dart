import 'package:flutter/material.dart';
import 'package:vocascan_mobile/constants/colors.dart';


class RoundedButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textColor;
  final bool disabled;

  const RoundedButton({
    required this.text,
    required this.press,
    this.color = primary,
    this.textColor = Colors.white,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Opacity(opacity: disabled?0.2:1, child: Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: TextButton(
          onPressed: () =>  press(),
          style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              backgroundColor: color),
          child: Text(
            text,
            style: TextStyle(color: textColor),
          ),
        ),
      ),)
    );
  }
}