import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vocascan_mobile/pages/auth/sign_up_page.dart';
import 'package:vocascan_mobile/pages/widgets/rounded_button.dart';
import 'package:vocascan_mobile/pages/widgets/rounded_input_field.dart';
import 'package:vocascan_mobile/services/auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageSate createState() => _LoginPageSate();
}

class _LoginPageSate extends State<LoginPage> {
  TextEditingController mailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

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
                  controller: mailController,
                  hintText: 'Email',
                  onChanged: (String value) {},
                ),
                RoundedInputField(
                  hintText: 'Password',
                  controller: passwordController,
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
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => SignUpPage()));
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

  login()async{
    var mail = mailController.value;
    var password = passwordController.value;

    var result = await AuthService.getInstance().loginUser(mail, password);
    // TODO Handle result
  }
}
