import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vocascan_mobile/pages/auth/registration/sign_up_page.dart';
import 'package:vocascan_mobile/pages/widgets/rounded_button.dart';
import 'package:vocascan_mobile/pages/widgets/rounded_input_field.dart';
import 'package:vocascan_mobile/services/auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageSate createState() => _LoginPageSate();
}

class _LoginPageSate extends State<LoginPage> {
  TextEditingController _mailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  AuthService _authService = AuthService.getInstance();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SvgPicture.asset(
                  "assets/images/logos/cloud.svg",
                  height: size.height * 0.25,
                ),
                RoundedInputField(
                  controller: _mailController,
                  hintText: 'Email',
                  onChanged: (String value) {},
                ),
                RoundedInputField(
                  hintText: 'Password',
                  controller: _passwordController,
                  onChanged: (String value) {},
                  obscureText: true,
                  icon: Icons.password,
                ),
                Container(
                    child: TextButton(onPressed: (){},
                        child: Text("Forgot Password?"))
                ),
                RoundedButton(press: () {
                  login();
                },
                    text: 'LOGIN',
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Don’t have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context){
                          return SignUpPage();
                        }));
                      },
                      child: Text("Sign up"),
                    )
                  ],
                )
              ],
            ),
          ),
        )
    );
  }

  login() async{
    var snackBar = new SnackBar(content: Text('The login is currently not available!'),);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    Navigator.of(context).pushReplacementNamed("/home");

    var mail = _mailController.value;
    var password = _passwordController.value;

    var result = await _authService.loginUser(mail, password);
  }
}
