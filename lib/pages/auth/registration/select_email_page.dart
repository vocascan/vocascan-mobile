import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vocascan_mobile/constants/values.dart';
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
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  bool _isUsernameValid = false;
  bool _isEmailValid = false;
  StorageService _storageService = StorageService.getInstance();

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: size.height * 0.3,
              width: size.height * 0.25,
              child: SvgPicture.asset(
                "assets/images/illustrations/undraw_Mention.svg",
              ),
            ),
            TextFieldContainer(
              child: Text(tr("specify_email"),
                textAlign: TextAlign.center,),
            ),
            RoundedInputField(controller: _mailController, hintText: tr("email"), onChanged: (String email) {
              validateEmail(email);
            },),
            RoundedInputField(icon: Icons.person, controller: _usernameController,
              hintText: tr("username"), onChanged: (String username) {
              validateUsername(username);
            },),
            RoundedButton(text: tr("continue"), disabled: !(_isUsernameValid && _isEmailValid), press: (){
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
    setState(() {
      _isEmailValid = RegExp(emailRegex).hasMatch(email);
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