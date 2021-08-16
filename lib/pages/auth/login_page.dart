import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vocascan_mobile/pages/widgets/rounded_button.dart';
import 'package:vocascan_mobile/pages/widgets/rounded_input_field.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageSate createState() => _LoginPageSate();
}

class _LoginPageSate extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: Column(children: <Widget>[
          SizedBox(height: size.height * 0.15),
          SvgPicture.asset(
            "assets/images/logos/vocascan-cloud.svg",
            height: size.height * 0.25,
          ),
          SizedBox(height: size.height * 0.05),
          RoundedInputField(
            hintText: 'Email',
            onChanged: (String value) {},
          ),
          RoundedInputField(
            hintText: 'Password',
            onChanged: (String value) {},
            obscureText: true,
            icon: Icons.password,
          ),
          RoundedButton(text: 'LOGIN', press: () {}),
          Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Don’t have an account?"),
                  TextButton(
                    onPressed: () {

                    },
                    child: Text("Sign up"),
                  )
                ],
              ))
        ]),
      ),
    );
  }
}
