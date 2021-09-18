import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:vocascan_mobile/constants/colors.dart';
import 'package:vocascan_mobile/pages/widgets/text_field_container.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final TextEditingController controller;
  final bool obscureText;
  final IconButton? suffixIconButton;


  const RoundedInputField({
    required this.hintText,
    required this.controller,
    this.icon = Icons.email,
    required this.onChanged,
    this.obscureText = false, this.suffixIconButton,
  });

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      decoration: BoxDecoration(
        color:Colors.white,
        borderRadius: BorderRadius.circular(29),
        border: Border.all(),),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        onChanged: onChanged,
        decoration: InputDecoration(
          suffixIcon: suffixIconButton,
          icon: Icon(icon, color: primary),
          hintText: hintText,
          border: InputBorder.none
        ),
      ),
    );
  }
}