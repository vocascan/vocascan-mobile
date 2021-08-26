import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vocascan_mobile/pages/widgets/rounded_button.dart';
import 'package:vocascan_mobile/pages/widgets/rounded_input_field.dart';
import 'package:vocascan_mobile/pages/widgets/text_field_container.dart';
import 'package:vocascan_mobile/services/storage.dart';

class SelectPasswordPage extends StatefulWidget{
  @override
  _SelectPasswordPageState createState() => _SelectPasswordPageState();
}

class _SelectPasswordPageState extends State<SelectPasswordPage> {
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _passwordRepeatController = new TextEditingController();
  bool _passwordValid = true;

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
                  controller: _passwordController,
                  obscureText: true,
                  onChanged: (String password) {
                    validatePassword();
                  },
                ),
                RoundedInputField(
                  hintText: 'Confirm Password',
                  icon: Icons.password,
                  controller: _passwordRepeatController,
                  obscureText: true,
                  onChanged: (String password) {
                    validatePassword();
                  },
                ),
                RoundedButton(text: 'Finish', disabled: _passwordValid, press: () {
                  return _passwordValid ? null : signUp();
                },)
              ],
            ),
          ),
        )
    );
  }

  validatePassword()async{
    var password = _passwordController.text;
    var passwordRepeat = _passwordRepeatController.text;

    String  securePasswordPattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(securePasswordPattern);

    setState(() {
      _passwordValid = !(password == passwordRepeat
          && regExp.hasMatch(password));
    });
  }

  signUp()async{
  }
}