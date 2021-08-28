import 'package:flutter/material.dart';
import 'package:vocascan_mobile/pages/auth/login/auth_page.dart';
import 'package:vocascan_mobile/pages/auth/registration/sign_up_page.dart';
import 'package:vocascan_mobile/pages/home/home_page.dart';
import 'package:vocascan_mobile/services/api_client.dart';
import 'package:vocascan_mobile/services/auth.dart';
import 'package:vocascan_mobile/services/storage.dart';
import 'mapper.g.dart' as mapper;

Future<void> main() async {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  WidgetsFlutterBinding.ensureInitialized(); // Important for Flutter Secure Storage

  AuthService _authService = AuthService.getInstance();
  StorageService _storageService = StorageService.getInstance();

  String homeServer = "";
  if(await _storageService.exists("server")) {
    homeServer = (await _storageService.get("server"))!;
  }

  ApiClientService(homeServer);
  mapper.init();

  Widget _defaultHome = AuthPage();

  if (await _authService.isLoggedIn()){
    _defaultHome = HomePage();
  }

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


