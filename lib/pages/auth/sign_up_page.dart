import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vocascan_mobile/pages/widgets/rounded_button.dart';
import 'package:vocascan_mobile/pages/widgets/rounded_input_field.dart';
import 'package:vocascan_mobile/pages/widgets/text_field_container.dart';
import 'package:vocascan_mobile/services/auth.dart';

class SignUpPage extends StatefulWidget{
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController passwordController = new TextEditingController();
  TextEditingController passwordRepeatController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SvgPicture.asset(
                  "assets/images/illustrations/undraw_my_password.svg",
                  height: size.height * 0.3,
                  width: size.height * 0.25,
                ),
                TextFieldContainer(
                  child: Text("Use a strong Password to secure your data",
                  textAlign: TextAlign.center,),
                  decoration: BoxDecoration(),
                ),
                RoundedInputField(
                  hintText: 'Password',
                  icon: Icons.password,
                  controller: passwordController,
                  obscureText: true,
                  onChanged: (String value) {

                  },
                ),
                RoundedInputField(
                  hintText: 'Confirm Password',
                  icon: Icons.password,
                  controller: passwordRepeatController,
                  obscureText: true,
                  onChanged: (String value) {

                  },
                ),
                RoundedButton(text: 'Finish', press: () {
                    signUp();
                },)
              ],
            ),
          ),
        )
    );
  }

  signUp()async{
    var snackBar = new SnackBar(content: Text("Die Registrierung ist aktuell nicht verfügbar!"),);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    var mail = "";
    var password = passwordController.text;

    var passwordRepeat = passwordRepeatController.text;

    // TODO: check if password is strong enough

    if (password == passwordRepeat){
      var result = await AuthService.getInstance().signupUser(mail, password);
      // TODO: handle Result

    }else{
      // TODO: warn user
    }
  }
}