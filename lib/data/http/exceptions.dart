class NotFoundException implements Exception {
  final String message;

  NotFoundException(this.message);
}

class TooManyResultsException implements Exception {
  final String message;

  TooManyResultsException(this.message);
}
