
import 'dart:convert';

import 'package:http/http.dart';
import 'package:simple_json_mapper/simple_json_mapper.dart';
import 'package:vocascan_mobile/api/schemas/endpoint_info.dart';
import 'package:vocascan_mobile/api/schemas/endpoint_register.dart';

enum HTTPMethod {
  GET,
  POST,
  DELETE,
  PUT,
  PATCH
}


class ApiResponse {
  final Response response;
  final Map data;

  const ApiResponse(this.response, this.data);
}

class ApiClientService<T>{
  String homeServer = "";
  static ApiClientService? instance;

  ApiClientService(this.homeServer){
    instance = this;
  }

  static ApiClientService getInstance(){
    return instance!;
  }

  void setHomeServerUrl(String homeServerUrl) {
    this.homeServer = homeServerUrl;
  }

  dynamic endpointGet(String endpoint) async {
    Uri url = Uri.parse(this.homeServer + "/api/" + endpoint);
    Response response = await get(url);

    return jsonDecode(response.body);
  }
}