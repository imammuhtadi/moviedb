import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:moviedb/config/constanta.dart';
import 'package:moviedb/data/models/movie/movie_model.dart';
import 'package:moviedb/theme/app_color.dart';
import 'package:moviedb/theme/app_font.dart';
import 'package:provider/provider.dart';

import 'detail_provider.dart';

class DetailScreen extends StatefulWidget {
  final MovieModel movie;
  final String section;

  const DetailScreen({
    super.key,
    required this.movie,
    required this.section,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late DetailProvider provider;
  late StreamSubscription subs;

  @override
  void initState() {
    super.initState();
    provider = DetailProvider();
    provider.state.movie = widget.movie;
    provider.getMovieDetail();
    subs = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Anda sedang offline'),
          duration: Duration(hours: 1),
        ));
      } else {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        provider.getMovieDetail();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    subs.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => provider,
      builder: (context, child) => _buildPage(context),
    );
  }

  Widget _buildPage(BuildContext context) {
    final provider = context.watch<DetailProvider>();
    final state = provider.state;

    return Scaffold(
      backgroundColor: AppColor.background,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 600,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: '${widget.section}${state.movie.title}',
                child: Image.network(
                  '$imageUrl${state.movie.posterPath}',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: 1,
              (_, int index) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${state.movie.title}',
                        style: textExtraLargeSemiBold.copyWith(height: 1.5),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          RatingBar.builder(
                            initialRating:
                                (state.movie.voteAverage!.toDouble() / 2),
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            unratedColor: AppColor.white,
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {},
                          ),
                          const SizedBox(width: 16),
                          Text(
                            'rating ${state.movie.voteAverage}',
                            style: textLarge.copyWith(color: AppColor.white),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        children: [
                          for (var genre in state.movieDetail?.genres ?? [])
                            Text(
                              '${genre.name}${genre == state.movieDetail?.genres?.last ? "" : ", "}',
                              style: textMediumSemiBold,
                            ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      if (state.movieDetail?.runtime != null)
                        Text(
                          '${state.movieDetail!.runtime! ~/ 60}h ${state.movieDetail!.runtime! % 60}m',
                          style: textMediumSemiBold.copyWith(height: 1.5),
                        ),
                      const SizedBox(height: 12),
                      Text(
                        'Overview',
                        style: textLargeSemiBold.copyWith(height: 1.5),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${state.movie.overview}',
                        style: textMedium.copyWith(height: 1.5),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
