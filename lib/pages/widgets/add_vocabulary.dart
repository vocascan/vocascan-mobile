import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vocascan_mobile/constants/colors.dart';
import 'package:vocascan_mobile/pages/widgets/rounded_input_field.dart';
import 'package:vocascan_mobile/pages/widgets/text_field_container.dart';

class AddVocabularyPopup extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(child: Container(
        width: size.width * 0.9,
        height: size.height *  0.5,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(color: Colors.white,
            borderRadius: BorderRadius.circular(10)
        ),
        child: Column(
          children: [
            TextFieldContainer(child: TextField(decoration: InputDecoration(
                hintText: tr("translation")
            ),), decoration: BoxDecoration()),
            TextFieldContainer(child: TextField(decoration: InputDecoration(
                hintText: tr("foreign_word")
            ),), decoration: BoxDecoration()),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              IconButton(icon: Icon(Icons.add, color: primary,), onPressed: () {
                
              },)],)
          ],
        ),
      ),)
    );
  }
}
