import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vocascan_mobile/pages/widgets/rounded_button.dart';
import 'package:vocascan_mobile/pages/widgets/rounded_input_field.dart';
import 'package:vocascan_mobile/pages/widgets/text_field_container.dart';
import 'package:vocascan_mobile/services/storage.dart';

class SelectEmailPage extends StatefulWidget{
  final PageController controller;
  SelectEmailPage({required this.controller});

  @override
  _SelectEmailPageState createState() => _SelectEmailPageState();
}

class _SelectEmailPageState extends State<SelectEmailPage> {
  final TextEditingController _mailController = new TextEditingController();
  final TextEditingController _usernameController = new TextEditingController();

  bool _isUsernameValid = false;
  bool _isEmailValid = false;
  StorageService _storageService = StorageService.getInstance();

  @override
  initState() {
    super.initState();
    updateInputs();
  }

  updateInputs() async{
    String? email = await _storageService.get("email");
    String? username = await _storageService.get("username");

    if (email != null){
      validateEmail(email);
      _mailController.text = email;
    }

    if(username != null){
      validateUsername(username);
      _usernameController.text = username;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SvgPicture.asset(
              "assets/images/illustrations/undraw_Mention.svg",
              height: size.height * 0.3,
              width: size.height * 0.25,
            ),
            TextFieldContainer(
              child: Text("Please specify your email and username",
                textAlign: TextAlign.center,),
              decoration: BoxDecoration(),
            ),
            RoundedInputField(controller: _mailController, hintText: "Email", onChanged: (String email) {
              validateEmail(email);
            },),
            RoundedInputField(icon: Icons.person, controller: _usernameController,
              hintText: "Username", onChanged: (String username) {
              validateUsername(username);
            },),
            RoundedButton(text: "Continue", disabled: !(_isUsernameValid && _isEmailValid), press: (){
              return !(_isUsernameValid && _isEmailValid) ? null : widget.controller.animateToPage(widget.controller.page!.toInt() + 1,
                  duration: Duration(milliseconds: 400),
                  curve: Curves.easeIn
              );
            }),
          ],
        ),
      ))
    );
  }

  validateEmail(String email){
    String emailPattern = r"^\S+@\S+.\S+$";
    setState(() {
      _isEmailValid = RegExp(emailPattern).hasMatch(email);
      if (_isEmailValid){
        _storageService.add('email', email);
      }
    });
  }

  validateUsername(String username){
    setState(() {
      _isUsernameValid = username.length >= 2
          && username.length <= 32;
      if (_isUsernameValid){
        _storageService.add('username', username);
      }
    });
  }
}