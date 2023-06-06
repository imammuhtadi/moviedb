import 'package:moviedb/data/models/movie/date_model.dart';
import 'package:moviedb/data/models/movie/movie_model.dart';

class MovieListResponse {
  DateModel? dates;
  int? page;
  List<MovieModel>? results;
  int? totalPages;
  int? totalResults;

  MovieListResponse({
    this.dates,
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  MovieListResponse.fromJson(Map<String, dynamic> json) {
    dates = json['dates'] != null ? DateModel.fromJson(json['dates']) : null;
    page = json['page'];
    if (json['results'] != null) {
      results = <MovieModel>[];
      json['results'].forEach((v) {
        results!.add(MovieModel.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (dates != null) {
      data['dates'] = dates!.toJson();
    }
    data['page'] = page;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    data['total_pages'] = totalPages;
    data['total_results'] = totalResults;
    return data;
  }
}
