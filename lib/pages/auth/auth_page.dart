import 'package:flutter/material.dart';
import 'package:vocascan_mobile/pages/auth/select_server_page.dart';
import 'package:vocascan_mobile/pages/auth/sign_up_page.dart';

import 'login_page.dart';

class AuthPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _AuthPageState();
  }

}
class _AuthPageState extends State<AuthPage>{
  bool signUpUser = false;
  PageController controller = new PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
          controller: controller,
          children: [
        SelectServerPage(controller: controller,),

        LoginPage(
          ),
      ]),
    );
  }

}