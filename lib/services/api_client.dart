import 'package:http/http.dart';
import 'dart:convert';

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
  String homeServerUrl = "";


  ApiClientService() {
    instance = this;
  }

  static ApiClientService getInstance() {
    return instance ?? ApiClientService();
  }

  void setHomeServerUrl(String homeServerUrl) {
    this.homeServerUrl = homeServerUrl;
  }

  Future<ApiResponse> request(String route, Object data, [bool loggedIn = true, HTTPMethod method = HTTPMethod.GET]) async {
    Map<String, String> headers = {};
    Uri url = Uri.parse("${this.homeServerUrl}/api/$route");
    Response response;
    Map responseData;

    if(loggedIn) {
      // TODO Add Auth Token to Headers
    }

    switch(method) {
      case HTTPMethod.GET:
        response = await get(url, headers: headers);
        break;
      case HTTPMethod.POST:
        response = await post(url, headers: headers, body: data);
        break;
      default:
        throw Exception("Not implemented yet");
    }

    responseData = json.decode(response.body);
    return ApiResponse(response, responseData);
  }

}