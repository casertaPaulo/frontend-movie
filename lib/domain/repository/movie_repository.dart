import 'package:flutter/material.dart';
import 'package:movies/domain/model/movie_entity.dart';

class MovieRepository extends ChangeNotifier {
  bool isLoading = false;
  bool notFoundResponse = false;
  List<MovieEntity> searchResult = [];

  void setIsLoading() {
    isLoading = true;
    notifyListeners();
  }

  void setNotFoundResponse() {
    notFoundResponse = true;
    isLoading = false;
    notifyListeners();
  }

  void setMovies(List<MovieEntity> movies) {
    searchResult = movies;
    isLoading = false;
    notFoundResponse = false;
    notifyListeners();
  }
}
