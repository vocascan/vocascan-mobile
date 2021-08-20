import 'package:flutter/material.dart';

class AuthService{


  // static instance
  static AuthService? instance;

  // will never be null, but the kex is generated
  // in the main.dart after class init
  static GlobalKey<NavigatorState>? key;



  AuthService() {
    instance = this;
  }

  // also will never be null
  static AuthService getInstance() {
      return instance ?? AuthService();
  }

  Future<bool> isLoggedIn()async{
    return false;
  }
}