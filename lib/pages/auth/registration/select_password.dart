import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vocascan_mobile/constants/values.dart';
import 'package:vocascan_mobile/exceptions/response_note_correct.dart';
import 'package:vocascan_mobile/pages/widgets/rounded_button.dart';
import 'package:vocascan_mobile/pages/widgets/rounded_input_field.dart';
import 'package:vocascan_mobile/pages/widgets/text_field_container.dart';
import 'package:vocascan_mobile/services/auth.dart';
import 'package:vocascan_mobile/services/storage.dart';

class SelectPasswordPage extends StatefulWidget{

  @override
  _SelectPasswordPageState createState() => _SelectPasswordPageState();
}

class _SelectPasswordPageState extends State<SelectPasswordPage> {
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordRepeatController = TextEditingController();

  AuthService _authService = AuthService.getInstance();
  StorageService _storageService = StorageService.getInstance();

  String _errorMessage = "";
  bool _passwordValid = true;


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: size.height * 0.3,
                  width: size.height * 0.25,
                  child: SvgPicture.asset(
                    "assets/images/illustrations/undraw_my_password.svg",
                  ),
                ),
                TextFieldContainer(
                  child: Text(tr("strong_password"),
                    textAlign: TextAlign.center,),
                  decoration: BoxDecoration(),
                ),
                RoundedInputField(
                  hintText: tr('password'),
                  icon: Icons.password,
                  controller: _passwordController,
                  obscureText: true,
                  onChanged: (String password) {
                    validatePassword();
                  },
                ),
                RoundedInputField(
                  hintText: tr('confirm_password'),
                  icon: Icons.password,
                  controller: _passwordRepeatController,
                  obscureText: true,
                  onChanged: (String password) {
                    validatePassword();
                  },
                ),
                RoundedButton(text: tr("finish"), disabled: _passwordValid, press: () {
                  return _passwordValid ? null : signUp();
                },)
              ],
            ),
          ),
        )
    );
  }

  validatePassword()async{
    RegExp regExp = RegExp(securePasswordRegex);

    var password = _passwordController.text;
    var passwordRepeat = _passwordRepeatController.text;

    setState(() {
      _passwordValid = !(password == passwordRepeat
          && regExp.hasMatch(password));
    });
  }

  signUp() async{
    bool sinUpSuccessfully = false;

    try{
      String? email = await _storageService.get("email");
      String? username = await _storageService.get("username");

      sinUpSuccessfully = await _authService.signupUser(username, email, _passwordController.text);

      if (sinUpSuccessfully){
        Navigator.of(context).pushReplacementNamed("/home");
      }
    }
    on EndpointResponseNotCorrect catch (endpoint){
        switch(endpoint.statusCode){
          case 409:
            _errorMessage = tr("email_in_use");
            break;
          default:
            _errorMessage = tr("unknown_error");
        }
    }
    on SocketException catch(_){
        _errorMessage = tr("no_internet");
    }
    catch (exception){
        _errorMessage = tr("unknown_error");
    }

    if (!sinUpSuccessfully){
      final snackBar = SnackBar(backgroundColor: Colors.red,
        content: Text(_errorMessage), action:  SnackBarAction(textColor: Colors.white,
          label: tr("dismiss") ,
          onPressed: () {
            return null;
          },),);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}