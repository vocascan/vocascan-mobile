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

    if(loggedIn) {
      // TODO Add Auth Token to Headers
    }

    switch(method) {
      case HTTPMethod.GET:
        response = await get(url, headers: headers);
        break;
      case HTTPMethod.POST:
        response = await post(url, headers: headers, body: body);
        break;
      default:
        throw Exception("Not implemented yet");
    }

    responseData = json.decode(utf8.decode(response.body.codeUnits));
    return ApiResponse(response, responseData);
  }

}