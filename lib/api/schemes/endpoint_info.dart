class EndpointInfoResponseScheme {
  final String identifier;
  final String version;
  final String? commitRef;

  EndpointInfoResponseScheme(this.identifier, this.version, this.commitRef);
}

class EndpointInfoResponseNotCorrect implements Exception {
  final int statusCode;
  final List<dynamic>? keys;

  EndpointInfoResponseNotCorrect(this.statusCode, [this.keys]);
}

class EndpointInfoVersionNotSupported implements Exception {
  final String serverVersion;

  EndpointInfoVersionNotSupported(this.serverVersion);
}

class EndpointInfoServerNotSupported implements Exception {
  final String serverIdentifier;

  EndpointInfoServerNotSupported(this.serverIdentifier);
}