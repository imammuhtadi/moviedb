import 'package:moviedb/data/models/movie/movie_model.dart';
import 'package:moviedb/data/models/movie_detail/movie_detail_response.dart';
import 'package:moviedb/data/repositories/movie_repository.dart';

class DetailState {
  late MovieRepository service;
  late MovieModel movie;
  MovieDetailResponse? movieDetail;

  DetailState() {
    service = MovieRepository();
  }
}
