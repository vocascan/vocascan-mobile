class EndpointResponseNotCorrect implements Exception {
  final int statusCode;
  final List<dynamic>? keys;

  EndpointResponseNotCorrect(this.statusCode, [this.keys]);
}