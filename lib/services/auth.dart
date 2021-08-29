import 'package:flutter/material.dart';
import 'package:vocascan_mobile/api/schemas/endpoint_login.dart';
import 'package:vocascan_mobile/api/schemas/endpoint_register.dart';

import 'api_client.dart';

class AuthService {
  // static instance
  static AuthService? instance;
  static ApiClientService _apiClientService = ApiClientService.getInstance();

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
    return false;
  }

  Future<bool> loginUser(email, password) async {
    Map data = {
      "email": email,
      "password": password,
    };

    EndpointLogin? result = await _apiClientService.endpointPost<EndpointLogin>("user/login", data);

    return result != null;
  }

  Future<bool> signupUser(username, email, password) async {

    Map data = {
      "email": email,
      "password": password,
      "username": username
    };

    EndpointRegister? result = await _apiClientService.endpointPost<EndpointRegister>("user/register", data);

    return result != null;
  }
}
