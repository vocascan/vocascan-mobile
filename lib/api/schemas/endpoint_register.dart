
import 'package:simple_json_mapper/simple_json_mapper.dart';


@JObj()
class User{
  final String id;
  final String username;

  const User({required this.id, required this.username});
}

@JObj()
class EndpointRegister {

  final String token;
  final User user;

  const EndpointRegister({required this.user, required this.token});
}