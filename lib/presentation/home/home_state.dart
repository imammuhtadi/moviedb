import 'package:moviedb/data/models/movie/movie_model.dart';
import 'package:moviedb/data/repositories/movie_repository.dart';

class HomeState {
  late MovieRepository service;
  late List<MovieModel> nowPlayingMovies;
  late List<MovieModel> popularMovies;

  HomeState() {
    service = MovieRepository();
    nowPlayingMovies = <MovieModel>[];
    popularMovies = <MovieModel>[];
  }
}
