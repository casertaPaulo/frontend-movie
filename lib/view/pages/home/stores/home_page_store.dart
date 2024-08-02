import 'package:flutter/material.dart';
import 'package:movies/data/http/exceptions.dart';
import 'package:movies/data/model/movie_entity.dart';
import 'package:movies/data/repositories/movie_repository.dart';

class HomePageStore {
  final IMovieRepository movieRepository;

  HomePageStore({required this.movieRepository});

  // react variable for loading state
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  // react variable for movies state
  final ValueNotifier<List<MovieEntity>> state =
      ValueNotifier<List<MovieEntity>>([]);

  //react variavle for exception error state
  final ValueNotifier<String> error = ValueNotifier<String>("");

  final ValueNotifier<String> feedbackResponse = ValueNotifier<String>("");

  Future searchMovies({required String title}) async {
    isLoading.value = true;

    try {
      // if the request is sucefull, uptate the current movie state
      final result = await movieRepository.searchMovies(title: title);

      state.value = result;
      error.value = "";
    } on NotFoundException catch (e) {
      error.value = e.message;
    } on TooManyResultsException catch (e) {
      error.value = e.message;
    } catch (e) {
      error.value = e.toString();
    }

    isLoading.value = false;
  }

  Future saveMovie({required String title}) async {
    isLoading.value = true;

    try {
      await movieRepository.saveMovie(title: title);
      feedbackResponse.value = "Sucess";
    } on MovieAlreadySavedException catch (e) {
      feedbackResponse.value = e.message;
    } catch (e) {
      feedbackResponse.value = e.toString();
    }

    isLoading.value = false;
  }
}
