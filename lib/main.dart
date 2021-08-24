import 'package:flutter/material.dart';
import 'package:vocascan_mobile/pages/auth/login/auth_page.dart';
import 'package:vocascan_mobile/pages/auth/registration/sign_up_page.dart';
import 'package:vocascan_mobile/pages/home/home_page.dart';
import 'package:vocascan_mobile/services/api_client.dart';
import 'package:vocascan_mobile/services/auth.dart';
import 'package:vocascan_mobile/services/storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Important for Flutter Secure Storage

  String homeServerUrl = "";

  if(await StorageService.getInstance().exists("server")) {
    homeServerUrl = (await StorageService.getInstance().get("server"))!;
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


