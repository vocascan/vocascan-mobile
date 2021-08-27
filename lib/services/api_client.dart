
import 'dart:convert';

import 'package:http/http.dart';
import 'package:vocascan_mobile/api/schemas/endpoint_info.dart';

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

class ApiClientService{
  String homeServer = "";
  static ApiClientService? instance;

  ApiClientService(this.homeServer){
    instance = this;
  }

  static ApiClientService getInstance(){
    try{
      return instance!;
    }catch(_){
      throw Exception("Api Client Instance not found");
    }
  }

  void setHomeServerUrl(String homeServerUrl) {
    this.homeServer = homeServerUrl;
  }

  Future<ApiResponse> request(String route, Map<String, dynamic> data, [bool loggedIn = true, HTTPMethod method = HTTPMethod.GET]) async {

    Uri url = Uri.parse("${this.homeServer}/api/$route");

    Map<String, String> headers = {};
    List<int> body = utf8.encode(json.encode(data));
    Response response;

    if(loggedIn) {

    }

    switch(method) {
      case HTTPMethod.GET:
        response = await get(url, headers: headers);
        break;
      case HTTPMethod.POST:
        response = await post(url, headers: headers, body: body);
        break;
      default:
        throw Exception("Method Not implemented yet");
    }

    Map responseData;
    responseData = json.decode(utf8.decode(response.body.codeUnits));

    return ApiResponse(response, responseData);
  }


  Future<EndpointInfoResponseScheme> endpointInfo() async {
    final ApiResponse response = await request("info", {}, false, HTTPMethod.GET);

    if(response.response.statusCode != 200) {
      throw EndpointInfoResponseNotCorrect(response.response.statusCode);
    }

    if(!response.data.containsKey("identifier")
        || !response.data.containsKey("version")
        || !response.data.containsKey("commitRef")) {
      throw EndpointInfoResponseNotCorrect(response.response.statusCode, response.data.keys.toList());
    }

    if(response.data["identifier"] != "vocascan-server") {
      throw EndpointInfoServerNotSupported(response.data["identifier"]);
    }

    return EndpointInfoResponseScheme(response.data["identifier"],
        response.data["version"], response.data["commitRef"]);
  }
}