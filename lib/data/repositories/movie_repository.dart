import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:moviedb/common/failure.dart';
import 'package:moviedb/config/constanta.dart';
import 'package:moviedb/data/models/movie/movie_list_response.dart';
import 'package:moviedb/data/models/movie_detail/movie_detail_response.dart';

class MovieRepository {
  final dio = Dio();

  Future<Either<Failure, MovieListResponse>> getMovies({
    required String path,
  }) async {
    try {
      final response = await dio.get(
        '${baseUrl}movie/$path?api_key=$apiKey',
      );
      return Right(MovieListResponse.fromJson(response.data));
    } catch (e) {
      if (e is DioError) {
        return Left(Failure(e.message ?? ''));
      } else {
        return const Left(Failure('Something went wrong'));
      }
    }
  }

  Future<Either<Failure, MovieDetailResponse>> getMovieDetail({
    required int id,
  }) async {
    try {
      final response = await dio.get(
        '${baseUrl}movie/$id?api_key=$apiKey',
      );
      return Right(MovieDetailResponse.fromJson(response.data));
    } catch (e) {
      if (e is DioError) {
        return Left(Failure(e.message ?? ''));
      } else {
        return const Left(Failure('Something went wrong'));
      }
    }
  }
}
