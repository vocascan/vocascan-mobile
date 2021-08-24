import 'package:http/http.dart';
import 'dart:convert';

import 'package:vocascan_mobile/services/storage.dart';

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

class ApiClientService {
  static ApiClientService? instance;
  String homeServerUrl;


  ApiClientService(this.homeServerUrl) {
    instance = this;
  }

  static ApiClientService getInstance() {
    try {
      return instance!;
    } catch(_) {
      throw Exception("Api Client Instance not found");
    }

  }

  void setHomeServerUrl(String homeServerUrl) {
    this.homeServerUrl = homeServerUrl;
  }

  Future<ApiResponse> request(String route, Map<String, dynamic> data, [bool loggedIn = true, HTTPMethod method = HTTPMethod.GET]) async {
    Map<String, String> headers = {};
    Uri url = Uri.parse("${this.homeServerUrl}/api/$route");
    Response response;
    Map responseData;
    var body = utf8.encode(json.encode(data));
    print("1");

    if(loggedIn) {
      // TODO Add Auth Token to Headers
    }
    print("2");

    switch(method) {
      case HTTPMethod.GET:
        response = await get(url, headers: headers);
        print("get");
        break;
      case HTTPMethod.POST:
        print("post");
        response = await post(url, headers: headers, body: body);
        break;
      default:
        print("default");
        throw Exception("Not implemented yet");
    }
    print("3");

    responseData = json.decode(utf8.decode(response.body.codeUnits));
    print("4");
    print(response.body);
    print("5");
    return ApiResponse(response, responseData);
  }

}