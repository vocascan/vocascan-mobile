import 'package:http/http.dart';
import 'package:simple_json_mapper/simple_json_mapper.dart';

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
    this.homeServer = homeServerUrl + "/api/";
  }

   Future<T?> endpointGet<T>(String endpoint) async {
    Uri url = Uri.parse(this.homeServer + endpoint);
    Response response = await get(url);

    final result = JsonMapper.deserialize<T>(response.body);

    return result;
  }
}