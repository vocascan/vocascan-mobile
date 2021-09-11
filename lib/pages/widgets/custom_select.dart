import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vocascan_mobile/constants/colors.dart';

class CustomSelect extends StatefulWidget{
  final List<String> items;

  const CustomSelect({Key? key, required this.items}) : super(key: key);

  @override
  _CustomSelectState createState() => _CustomSelectState();
}

class _CustomSelectState extends State<CustomSelect> {
  String? _value;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      hint: Text(tr("package")),
      isExpanded: true,
      value: _value,
      icon: Icon(Icons.keyboard_arrow_down, color: primary,),
      iconSize: 24,
      elevation: 16,
      underline: Container(
        height: 2,
        color: Colors.blue,
      ),
      onChanged: (String? newValue) {
        setState(() {
          _value = newValue!;
        });
      },
      items: widget.items
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}