import 'package:flutter/material.dart';
import 'package:vocascan_mobile/services/api_client.dart';

class AuthService {
  // static instance
  static AuthService? instance;

  // will never be null, but the key is generated
  // in the main.dart after class init
  static GlobalKey<NavigatorState>? key;

  AuthService() {
    instance = this;
  }

  // also will never be null
  static AuthService getInstance() {
    return instance ?? AuthService();
  }

  Future<bool> isLoggedIn() async {
    if(ApiClientService.getInstance().homeServerUrl == "") {
      return false;
    }
    return false;
  }

  Future<bool> loginUser(mail, password) async {
    return false;
  }

  Future<bool> signupUser(username, mail, password) async {
    return false;
  }
}
