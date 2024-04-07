import 'package:cinemapedia2/presentation/providers/dark_mode_provide.dart';
import 'package:cinemapedia2/presentation/providers/search/search_movies_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../config/domain/entities/movie.dart';
import '../../delegates/search_movie_delegate.dart';

class CustomAppBar extends ConsumerWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final colors = Theme.of(context).colorScheme;
    final titleSty = Theme.of(context).textTheme.titleMedium;
     final isDarkMode = ref.watch(appThemeProvider).isDarkMode;
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Icon(
                Icons.movie_creation,
                color: colors.primary,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                "Cines",
                style: titleSty,
              ),
              IconButton(
                  onPressed: () {
                    ref.read(appThemeProvider.notifier).toggleDarkMode();
                  },
                  icon: Icon(isDarkMode
                  ? Icons.dark_mode_outlined
                  : Icons.light_mode_outlined),),
              const Spacer(),
              IconButton(
                  onPressed: () {
                    final searchedMovies = ref.read(searchedMovieProvider);
                    final searchQuery = ref.read(searchQueryProvider);

                    showSearch<Movie?>(
                            query: searchQuery,
                            context: context,
                            delegate: SearchMovieDelegate(
                                initialMovies: searchedMovies,
                                searchMovies: ref
                                    .read(searchedMovieProvider.notifier)
                                    .searchMoviesByQuery))
                        .then((movie) {
                      if (movie == null) return;
                      context.push("/home/0/movie/${movie.id}");
                    });
                  },
                  icon: const Icon(Icons.search))
            ],
          ),
        ),
      ),
    );
  }
}
