import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vocascan_mobile/pages/auth/registration/select_email_page.dart';
import 'package:vocascan_mobile/pages/auth/registration/select_password.dart';


class SignUpPage extends StatefulWidget{
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  PageController controller = new PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
          controller: controller,
          children: [
            SelectEmailPage(controller: controller,),
            SelectPasswordPage(),
          ]),
    );
  }
}