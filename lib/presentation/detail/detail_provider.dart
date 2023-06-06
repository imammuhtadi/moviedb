import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'detail_state.dart';

class DetailProvider extends ChangeNotifier {
  final state = DetailState();

  getMovieDetail() async {
    var res = await state.service.getMovieDetail(id: state.movie.id ?? 0);
    res.fold((left) {
      Fluttertoast.showToast(msg: left.message);
    }, (right) {
      state.movieDetail = right;
      notifyListeners();
    });
  }
}
