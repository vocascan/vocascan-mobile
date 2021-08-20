import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vocascan_mobile/pages/widgets/rounded_button.dart';
import 'package:vocascan_mobile/pages/widgets/rounded_input_field.dart';
import 'package:vocascan_mobile/pages/widgets/text_field_container.dart';

class SelectEmailPage extends StatelessWidget{
  final PageController controller;
  SelectEmailPage({required this.controller});

  final TextEditingController _mailController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SvgPicture.asset(
              "assets/images/illustrations/undraw_Mention.svg",
              height: size.height * 0.3,
              width: size.height * 0.25,
            ),
            TextFieldContainer(
              child: Text("Please specify your email",
                textAlign: TextAlign.center,),
              decoration: BoxDecoration(),
            ),
            RoundedInputField(controller: _mailController, hintText: "Email", onChanged: (String value) {

            },),
            RoundedButton(text: "Continue", press: (){
              controller.animateToPage(controller.page!.toInt() + 1,
                  duration: Duration(milliseconds: 400),
                  curve: Curves.easeIn
              );
            }),
          ],
        ),
      ))
    );
  }
  
}