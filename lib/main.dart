import 'package:flutter/material.dart';
import 'package:vocascan_mobile/pages/auth/login%20/auth_page.dart';
import 'package:vocascan_mobile/pages/auth/registration%20/sign_up_page.dart';
import 'package:vocascan_mobile/pages/home/home_page.dart';
import 'package:vocascan_mobile/services/auth.dart';

Future<void> main() async {

  AuthService();
  // TODO api
  Widget _defaultHome = new AuthPage();

  if (await AuthService.getInstance().isLoggedIn()){
    _defaultHome = HomePage();
  }

  final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

  runApp(MaterialApp(
    title: 'Vocascan',
    navigatorKey: navigatorKey,
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    routes: <String, WidgetBuilder>{
    '/register': (context) => new SignUpPage(),
    '/home': (context) => new HomePage(),
  },
    home: _defaultHome,
  ));
}


