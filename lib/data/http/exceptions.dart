class NotFoundException implements Exception {
  final String message;

  NotFoundException(this.message);
}

class TooManyResultsException implements Exception {
  final String message;

  TooManyResultsException(this.message);
}

class MovieAlreadySavedException implements Exception {
  final String message;

  MovieAlreadySavedException(this.message);
}
