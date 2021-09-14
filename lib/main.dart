import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:vocascan_mobile/pages/auth/login/auth_page.dart';
import 'package:vocascan_mobile/pages/auth/login/login_page.dart';
import 'package:vocascan_mobile/pages/auth/registration/sign_up_page.dart';
import 'package:vocascan_mobile/pages/home/home_page.dart';
import 'package:vocascan_mobile/services/api_client.dart';
import 'package:vocascan_mobile/services/auth.dart';
import 'package:vocascan_mobile/services/storage.dart';
import 'mapper.g.dart' as mapper;



String _homeServer = "";
bool _isLoggedIn = false;
final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized(); // Important for Flutter Secure Storage

  AuthService _authService = AuthService.getInstance();
  StorageService _storageService = StorageService.getInstance();

  if(await _storageService.exists("server")) {
    _homeServer = (await _storageService.get("server"))!;
  }

  ApiClientService(_homeServer);
 _isLoggedIn = await _authService.isLoggedIn();
  mapper.init();

  runApp(
    EasyLocalization(
        supportedLocales: [Locale('en', 'US'), Locale('de', 'DE')],
        path: 'assets/translations',
        fallbackLocale: Locale('en', 'US'),
        child: VocaScan()
    ),
  );
}

class VocaScan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        title: 'Vocascan',
        navigatorKey: _navigatorKey,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: <String, WidgetBuilder>{
          '/login': (context) => LoginPage(),
          '/register': (context) => SignUpPage(),
          '/home': (context) => HomePage(),
        },
        home: _isLoggedIn? HomePage(): AuthPage()
    );
  }
}