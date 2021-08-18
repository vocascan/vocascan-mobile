import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:vocascan_mobile/constants/colors.dart';
import 'package:vocascan_mobile/pages/widgets/text_field_container.dart';

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
    return TextFieldContainer(
      decoration: BoxDecoration(
        color:Colors.white,
        borderRadius: BorderRadius.circular(29),
        border: Border.all(),),
      child: TextField(

        obscureText: obscureText,
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