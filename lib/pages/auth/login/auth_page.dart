import 'package:flutter/material.dart';
import 'package:vocascan_mobile/pages/auth/login/select_server_page.dart';

import 'login_page.dart';

class AuthPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _AuthPageState();

}
class _AuthPageState extends State<AuthPage>{
  bool signUpUser = false;
  PageController controller = new PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: controller,
          children: [
            SelectServerPage(controller: controller,),
            LoginPage(),
      ]),
    );
  }

}