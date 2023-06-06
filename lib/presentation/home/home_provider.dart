import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'home_state.dart';

class HomeProvider extends ChangeNotifier {
  final state = HomeState();

  getNowPlayingMovie() async {
    var res = await state.service.getMovies(path: 'now_playing');
    res.fold((left) {
      Fluttertoast.showToast(msg: left.message);
    }, (right) {
      state.nowPlayingMovies = right.results!;
      notifyListeners();
    });
  }

  getPopularMovie() async {
    var res = await state.service.getMovies(path: 'popular');
    res.fold((left) {
      Fluttertoast.showToast(msg: left.message);
    }, (right) {
      state.popularMovies = right.results!;
      notifyListeners();
    });
  }
}
