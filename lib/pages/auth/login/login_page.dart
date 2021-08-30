import 'dart:io';

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
                  hintText: 'Email',
                  onChanged: (String value) {
                    setState(() {
                      _isEmailValid = RegExp(emailRegex)
                          .hasMatch(_emailController.text);
                    });
                  },
                ),
                RoundedInputField(
                  hintText: 'Password',
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
                        child: Text("Forgot Password?"))
                ),
                RoundedButton(disabled: !(_isEmailValid && _isPasswordValid), press: () {
                  return !(_isEmailValid && _isPasswordValid)? null: login();
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
    var email = _emailController.text;
    var password = _passwordController.text;
    bool loginSuccessfully = false;

    try{
      loginSuccessfully = await _authService.loginUser(email, password);

      if (loginSuccessfully){
        Navigator.of(context).pushReplacementNamed("/home");
      }
    }
    on EndpointResponseNotCorrect catch (endpoint){
      setState(() {
        switch (endpoint.statusCode){
          case 401:
          case 404:
            _errorMessage = "Hello it seems that the password or the email was incorrect";
            break;
          default:
            _errorMessage = "An unknown error has occurred try again later";
        }
      });
    }
    on SocketException catch(_){
      _errorMessage = "It seems that I have no connection to the Internet";
    }
    catch (_){
      _errorMessage = "An unknown error has occurred try again later";
    }

    if (!loginSuccessfully){
      final snackBar = SnackBar(backgroundColor: Colors.red, content: Text(_errorMessage),
        action:  SnackBarAction(textColor: Colors.white,
        label: "Dismiss" ,
          onPressed: () {
            return null;
            },),);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
