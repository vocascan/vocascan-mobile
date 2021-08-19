import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vocascan_mobile/pages/auth/login_page.dart';
import 'package:vocascan_mobile/pages/home/select_server_page.dart';

class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(children: [
        SelectServerPage(),
        LoginPage(),
      ],),
    );
  }
}