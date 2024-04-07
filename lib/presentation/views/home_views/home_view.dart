import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/initial_loading_provider.dart';
import '../../providers/movies/movies_providers.dart';
import '../../providers/movies/movies_slideshow_provider.dart';
import '../../widgets/movies/movies_horizontal.dart';
import '../../widgets/movies/movies_slideshow.dart';
import '../../widgets/shared/custom_appbar.dart';
import '../../widgets/shared/full_screen_loader.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();

    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final initialLoading = ref.watch(initialLoadingProvider);

    if (initialLoading) return const FullScreenloader();

    FlutterNativeSplash.remove();

    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final topRatedmovies = ref.watch(topRatedMoviesProvider);
    final upCommingMovies = ref.watch(upcomingMoviesProvider);

    final slideShowMovies = ref.watch(moviesSlideShowProvider);

    return CustomScrollView(slivers: [
      const SliverAppBar(
        floating: true,
        flexibleSpace: FlexibleSpaceBar(),
        title: CustomAppBar(),
      ),
      SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
        return Column(
          children: [
            //const CustomAppBar(),
            MoviesSlideShow(movies: slideShowMovies),
            MovieHorizontal(
              movies: nowPlayingMovies,
              label: "Solo en cines",
              subLabel: "Lunes 24",
              loadNextPage: () {
                ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
              },
            ),
            MovieHorizontal(
              movies: topRatedmovies,
              label: "Top",
              loadNextPage: () {
                ref.read(topRatedMoviesProvider.notifier).loadNextPage();
              },
            ),
            MovieHorizontal(
              movies: popularMovies,
              label: "Populares",
              subLabel: "Lunes 24",
              loadNextPage: () {
                ref.read(popularMoviesProvider.notifier).loadNextPage();
              },
            ),

            MovieHorizontal(
              movies: upCommingMovies,
              label: "Proximamente",
              loadNextPage: () {
                ref.read(upcomingMoviesProvider.notifier).loadNextPage();
              },
            ),
            const SizedBox(
              height: 10,
            )
          ],
        );
      }, childCount: 1)),
    ]);
  }
}