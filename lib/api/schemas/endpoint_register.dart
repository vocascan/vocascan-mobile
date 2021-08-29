
import 'package:simple_json_mapper/simple_json_mapper.dart';

import 'endpoint_user.dart';


@JObj()
class EndpointRegister {

  final String token;
  final User user;

  const EndpointRegister({required this.user, required this.token});
}