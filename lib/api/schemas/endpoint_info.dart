class EndpointInfo<T> {
  final String identifier;
  final String version;
  final String? commitRef;

  EndpointInfo(this.identifier, this.version, this.commitRef);

  factory EndpointInfo.fromJSON(dynamic json){
    return EndpointInfo(json['identifier'], json['version'], json['commitREf']);
  }
}
