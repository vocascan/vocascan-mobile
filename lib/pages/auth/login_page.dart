import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vocascan_mobile/pages/auth/sign_up_page.dart';
import 'package:vocascan_mobile/pages/widgets/rounded_button.dart';
import 'package:vocascan_mobile/pages/widgets/rounded_input_field.dart';
import 'package:vocascan_mobile/pages/widgets/text_field_container.dart';

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
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
          SingleChildScrollView(
            child: Flexible(flex: 12,
              fit: FlexFit.tight,
              child:  SvgPicture.asset(
                "assets/images/logos/cloud.svg",
                height: size.height * 0.25,
              ),),
          ),
          Flexible(flex:4,
            child:  RoundedInputField(
            hintText: 'Email',
            onChanged: (String value) {},
          ),),
          Flexible(flex:4,
            child:   RoundedInputField(
            hintText: 'Password',
            onChanged: (String value) {},
            obscureText: true,
            icon: Icons.password,
          ),),
          Flexible(flex:2,
              child:  Container(child: TextButton(onPressed: () {  },
                child: Text("Forgot Password?"),)
          )),
          Flexible(flex:4,
            child:  RoundedButton(text: 'LOGIN', press: () {

            }),),
          Flexible(flex:2,
              child:  Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Don’t have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SignUpPage()));
                    },
                    child: Text("Sign up"),
                  )
                ],
              )))
        ]),
      ),
    );
  }
}
