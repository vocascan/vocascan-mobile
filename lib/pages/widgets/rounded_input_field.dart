import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:vocascan_mobile/constants/colors.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final bool obscureText;
  const RoundedInputField({
    required this.hintText,
    this.icon = Icons.person,
    required this.onChanged,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color:Colors.white,
        borderRadius: BorderRadius.circular(29),
        border: Border.all(),),
      child: TextField(
        obscureText: true,
        onChanged: onChanged,
        decoration: InputDecoration(
          icon: Icon(icon, color: primary),
          hintText: hintText,
          border: InputBorder.none
        ),
      ),
    );
  }
}