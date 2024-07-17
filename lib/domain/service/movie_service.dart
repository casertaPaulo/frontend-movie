import 'dart:convert';
import 'package:movies/domain/model/movie_entity.dart';
import 'package:movies/domain/repository/movie_repository.dart';
import 'package:http/http.dart' as http;

class MovieService {
  MovieRepository movieRepository;

  MovieService({required this.movieRepository});

  Future<void> searchMovies(String movie) async {
    final url =
        Uri.parse("https://crud-movies-deploy.onrender.com/search/$movie");
    movieRepository.setIsLoading();

    final response = await http.get(url);

    if (response.statusCode == 404) {
      movieRepository.setMovies([]);
      movieRepository.setNotFoundResponse();
    }

    final jsonMap = jsonDecode(response.body) as List<dynamic>;

    List<MovieEntity> movies =
        jsonMap.map((json) => MovieEntity.fromJson(json)).toList();

    movieRepository.setMovies(movies);
  }
}
