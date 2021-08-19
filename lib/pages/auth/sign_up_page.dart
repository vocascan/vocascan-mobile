import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vocascan_mobile/pages/widgets/rounded_button.dart';
import 'package:vocascan_mobile/pages/widgets/rounded_input_field.dart';
import 'package:vocascan_mobile/pages/widgets/text_field_container.dart';

class SignUpPage extends StatefulWidget{
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body:  Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
            children:  <Widget>[
              SingleChildScrollView(child: Flexible(
                  flex: 4,
                  child: Flex(direction: Axis.vertical, children: <Widget>[
                    SvgPicture.asset(
                      "assets/images/illustrations/undraw_social_thinking.svg",
                      height: size.height * 0.3,
                      width: size.height * 0.25,
                    ),
                    TextFieldContainer(child: Text("Use a strong Password to secure your data",
                    textAlign: TextAlign.center,),
                      decoration: BoxDecoration(),)
                  ],)) ,),
              Flexible(flex: 2,
                child:  RoundedInputField(
                  hintText: 'Password',
                  icon: Icons.password,
                  obscureText: true,
                  onChanged: (String value) {},
                ),),
              Flexible(flex: 2,
                child:  RoundedInputField(
                  hintText: 'Confirm Password',
                  icon: Icons.password,
                  obscureText: true,
                  onChanged: (String value) {

                  },
                ),),
              Flexible(flex: 2,
                  child: RoundedButton(text: 'Finish', press: () {

                  },))
            ],
          ),
        ),
    );
  }

}