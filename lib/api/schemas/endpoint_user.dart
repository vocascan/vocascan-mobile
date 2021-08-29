import 'package:simple_json_mapper/simple_json_mapper.dart';

@JObj()
class User{
  final String id;
  final String username;

  const User({required this.id, required this.username});
}