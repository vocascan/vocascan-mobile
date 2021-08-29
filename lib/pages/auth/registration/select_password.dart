import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vocascan_mobile/api/schemas/endpoint_register.dart';
import 'package:vocascan_mobile/constants/values.dart';
import 'package:vocascan_mobile/exceptions/response_note_correct.dart';
import 'package:vocascan_mobile/pages/widgets/rounded_button.dart';
import 'package:vocascan_mobile/pages/widgets/rounded_input_field.dart';
import 'package:vocascan_mobile/pages/widgets/text_field_container.dart';
import 'package:vocascan_mobile/services/api_client.dart';
import 'package:vocascan_mobile/services/storage.dart';

class SelectPasswordPage extends StatefulWidget{

  @override
  _SelectPasswordPageState createState() => _SelectPasswordPageState();
}

class _SelectPasswordPageState extends State<SelectPasswordPage> {
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _passwordRepeatController = new TextEditingController();
  ApiClientService _apiClientService = ApiClientService.getInstance();
  StorageService _storageService = StorageService.getInstance();

  String _errorMessage = "";
  bool _passwordValid = true;
  bool _errorMessageVisible = false;

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
                Visibility(child:
                  TextFieldContainer(decoration: BoxDecoration(),
                    child: Text(_errorMessage,
                      style: TextStyle(color: Colors.red),
                      textAlign: TextAlign.center),
                  ),
                visible: _errorMessageVisible,),
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
    RegExp regExp = RegExp(securePasswordRegex);

    var password = _passwordController.text;
    var passwordRepeat = _passwordRepeatController.text;

    setState(() {
      _passwordValid = !(password == passwordRepeat
          && regExp.hasMatch(password));
    });
  }

  signUp() async{
    try{
      Map data = {
        "email": await _storageService.get("email"),
        "password": _passwordController.text,
        "username": await _storageService.get("username")
      };

      EndpointRegister? result = await _apiClientService.endpointPost<EndpointRegister>("user/register", data);
      
      if (result != null){
        Navigator.of(context).pushReplacementNamed("/home");
      }
    }
    on EndpointResponseNotCorrect catch (endpoint){
      setState(() {
        switch(endpoint.statusCode){
          case 409:
            _errorMessage = "Sorry the selected email is already used";
        }
        _errorMessageVisible = true;
      });
    }
    on SocketException catch(_){
      setState(() {
        _errorMessage = "It seems that I have no connection to the Internet";
        _errorMessageVisible = true;
      });

    }
    catch (exception){
      setState(() {
        _errorMessage = "An unknown error has occurred try again later";
        _errorMessageVisible = true;
      });
    }
  }
}