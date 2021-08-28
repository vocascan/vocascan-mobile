
import 'package:simple_json_mapper/simple_json_mapper.dart';

@JObj()
class EndpointInfo{
  final String identifier;
  final String version;
  final String? commitRef;

  const EndpointInfo({required this.identifier, required this.version, this.commitRef});
}
