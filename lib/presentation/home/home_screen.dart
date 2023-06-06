import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:moviedb/presentation/detail/detail_screen.dart';
import 'package:moviedb/presentation/home/widget/section_widget.dart';
import 'package:moviedb/theme/app_color.dart';
import 'package:provider/provider.dart';

import 'home_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeProvider provider;
  late StreamSubscription subs;

  @override
  void initState() {
    super.initState();
    provider = HomeProvider();
    provider.getNowPlayingMovie();
    provider.getPopularMovie();
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
        provider.getNowPlayingMovie();
        provider.getPopularMovie();
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
    final provider = context.watch<HomeProvider>();
    final state = provider.state;

    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('MovieDB'),
        backgroundColor: AppColor.primary.shade900,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SectionWidget(
              title: 'Now Playing',
              data: state.nowPlayingMovies,
              onItemClick: (item) {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => DetailScreen(
                      movie: item,
                      section: 'Now Playing',
                    ),
                  ),
                );
              },
              onClickMore: () {
                Fluttertoast.showToast(msg: 'Coming soon...');
              },
            ),
            SectionWidget(
              title: 'Popular',
              data: state.popularMovies,
              onItemClick: (item) {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => DetailScreen(
                      movie: item,
                      section: 'Popular',
                    ),
                  ),
                );
              },
              onClickMore: () {
                Fluttertoast.showToast(msg: 'Coming soon...');
              },
            ),
          ],
        ),
      ),
    );
  }
}
