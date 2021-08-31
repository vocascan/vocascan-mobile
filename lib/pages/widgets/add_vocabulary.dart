import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddVocabularyPopup extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Center(child: Container(
      width: size.width * 0.9,
      height: size.height *  0.5,
      padding: EdgeInsets.all(20),
      color: Colors.white,
      child: Column(
        children: [

        ],
      ),
    ),);
  }
}
