import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vocascan_mobile/pages/widgets/rounded_button.dart';
import 'package:vocascan_mobile/pages/widgets/rounded_input_field.dart';
import 'package:vocascan_mobile/pages/widgets/text_field_container.dart';

class SelectEmailPage extends StatefulWidget{
  final PageController controller;
  SelectEmailPage({required this.controller});

  @override
  _SelectEmailPageState createState() => _SelectEmailPageState();
}

class _SelectEmailPageState extends State<SelectEmailPage> {
  final TextEditingController _mailController = new TextEditingController();

  bool _isButtonDisabled = true;

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
            RoundedInputField(controller: _mailController, hintText: "Email", onChanged: (String email) {
              setState(() {
                String emailPattern = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                _isButtonDisabled = !RegExp(emailPattern).hasMatch(email);
              });
            },),
            RoundedButton(text: "Continue", disabled: _isButtonDisabled, press: (){
              return _isButtonDisabled ? null : widget.controller.animateToPage(widget.controller.page!.toInt() + 1,
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