import 'package:flutter/material.dart';
import 'package:interview_test/models/movie_model.dart';

import '../services/the_movie_db_service.dart';

enum MoviesStatus {
  none,
  loading,
  loaded,
  failed,
}

class MoviesProvider extends ChangeNotifier {
  MoviesProvider({
    this.movies = const <MovieModel>[],
    this.moviesStatus = MoviesStatus.none,
  });

  List<MovieModel> movies;
  MoviesStatus moviesStatus;

  final movieService = TheMovieDBService();

  getPopularMovies() async {
    try {
      moviesStatus = MoviesStatus.loading;
      notifyListeners();
      await Future.delayed(const Duration(seconds: 3));
      final responseMovies = await movieService.getPopularMovies();
      movies = responseMovies;
      moviesStatus = MoviesStatus.loaded;
      notifyListeners();
    } catch (exception) {
      moviesStatus = MoviesStatus.failed;
      notifyListeners();
    }
  }
}
