import 'package:flutter/material.dart';
import 'package:movies/data/model/movie_entity.dart';
import 'package:movies/data/repositories/movie_repository.dart';

class FavoritePageStore {
  final IMovieRepository movieRepository;

  FavoritePageStore({required this.movieRepository});

  // react variable for loading state
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  // react variable for movies state
  final ValueNotifier<List<MovieEntity>> state =
      ValueNotifier<List<MovieEntity>>([]);

  //react variavle for exception error state
  final ValueNotifier<String> error = ValueNotifier<String>("");

  Future getMovies() async {
    isLoading.value = true;

    try {
      final result = await movieRepository.getMovies();

      state.value = result;
      error.value = "";
    } catch (e) {
      error.value = e.toString();
    }

    isLoading.value = false;
  }
}
