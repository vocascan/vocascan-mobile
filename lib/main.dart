import 'package:flutter/material.dart';
import 'package:vocascan_mobile/pages/auth/login/auth_page.dart';
import 'package:vocascan_mobile/pages/auth/registration/sign_up_page.dart';
import 'package:vocascan_mobile/pages/home/home_page.dart';
import 'package:vocascan_mobile/services/api_client.dart';
import 'package:vocascan_mobile/services/auth.dart';
import 'package:vocascan_mobile/services/storage.dart';

Future<void> main() async {

  String homeServerUrl = "";
  var test = StorageService.getInstance();
  print(test);
  if(await test.exists("server")) {
    print("exists");
    homeServerUrl = await test.get("server");
  } else {
    print(":(");
    homeServerUrl = "";
  }
  // TODO Validate URL
  ApiClientService(homeServerUrl);
  AuthService();

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


