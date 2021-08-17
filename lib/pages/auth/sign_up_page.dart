import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vocascan_mobile/pages/widgets/rounded_input_field.dart';

class SignUpPage extends StatefulWidget{
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: Column(
          children:  <Widget>[
            Flexible(
              flex: 6,
              fit: FlexFit.tight,
              child:  SvgPicture.asset(
              "assets/images/graphics/undraw_social_thinking.svg",
              height: size.height * 0.25,
              width: size.height * 0.01,
            ),),
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
            ),)
          ],
        ),
      ),
    );
  }

}