class ServerException implements Exception {
  final String errorMassege;
  final String errorCode;
  ServerException({
    required this.errorMassege,
    required this.errorCode,
  });

  get message => "sgfgffg";

  get code => 0;

  @override
  String toString() => 'ServerExseption(errorMassege: $errorMassege, errorCode: $errorCode)';
}
