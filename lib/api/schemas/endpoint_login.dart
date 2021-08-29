import 'package:simple_json_mapper/simple_json_mapper.dart';

import 'endpoint_user.dart';

@JObj()
class EndpointLogin {

  final String token;
  final User user;

  const EndpointLogin({required this.user, required this.token});
}