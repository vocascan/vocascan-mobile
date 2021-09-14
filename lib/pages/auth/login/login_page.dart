import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vocascan_mobile/constants/values.dart';
import 'package:vocascan_mobile/exceptions/response_note_correct.dart';
import 'package:vocascan_mobile/pages/auth/registration/sign_up_page.dart';
import 'package:vocascan_mobile/pages/widgets/rounded_button.dart';
import 'package:vocascan_mobile/pages/widgets/rounded_input_field.dart';
import 'package:vocascan_mobile/services/auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageSate createState() => _LoginPageSate();
}

class _LoginPageSate extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  AuthService _authService = AuthService.getInstance();
  String _errorMessage = "";

  bool _isEmailValid = false;
  bool _isPasswordValid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                 SvgPicture.asset(
                    "assets/images/logos/cloud.svg",
                  ),
                RoundedInputField(
                  controller: _emailController,
                  hintText: tr("Email"),
                  onChanged: (String value) {
                    setState(() {
                      _isEmailValid = RegExp(emailRegex)
                          .hasMatch(_emailController.text);
                    });
                  },
                ),
                RoundedInputField(
                  hintText: tr("password"),
                  controller: _passwordController,
                  onChanged: (String value) {
                    setState(() {
                      _isPasswordValid =
                          _passwordController.text.isNotEmpty;
                    });
                  },
                  obscureText: true,
                  icon: Icons.password,
                ),
                Container(
                    child: TextButton(onPressed: (){},
                        child: Text(tr("forgot_password")))
                ),
                RoundedButton(disabled: !(_isEmailValid && _isPasswordValid), press: () {
                  return !(_isEmailValid && _isPasswordValid)? null: login();
                },
                    text: tr("login"),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(tr("no_account")),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context){
                          return SignUpPage();
                        }));
                      },
                      child: Text(tr("sign_up")),
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
    var email = _emailController.text;
    var password = _passwordController.text;

    try{
      await _authService.loginUser(email, password);
      await Navigator.of(context).pushReplacementNamed("/home");
    }
    on EndpointResponseNotCorrect catch (endpoint){
      setState(() {
        switch (endpoint.statusCode){
          case 401:
          case 404:
            _errorMessage = tr("wrong_password");
            break;
          default:
            _errorMessage = tr("unknown_error");
        }
      });
    }
    on SocketException catch(_){
      _errorMessage = tr("no_internet");
    }
    catch (_){
      _errorMessage = tr("unknown_error");
    }

    if(_errorMessage.isNotEmpty){
      final snackBar = SnackBar(backgroundColor: Colors.red, content: Text(_errorMessage),
        action:  SnackBarAction(textColor: Colors.white,
          label: tr("dismiss") ,
          onPressed: () {
            return null;
          },),);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
