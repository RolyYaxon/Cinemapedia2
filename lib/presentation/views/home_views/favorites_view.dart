import 'package:cinemapedia2/presentation/providers/storage/favorite_movies_provider.dart';
import 'package:cinemapedia2/presentation/widgets/movies/movie_masonry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  FavoritesViewState createState() => FavoritesViewState();
}

class FavoritesViewState extends ConsumerState<FavoritesView> {
  bool isLastPage = false;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    loadNextPage();
  }

  void loadNextPage() async {
    if (isLoading || isLastPage) return;
    isLoading = true;

    final movies =
        await ref.read(favoriteMoviesProvider.notifier).loadNextPage();

    isLoading = false;

    if (movies.isEmpty) {
      isLastPage = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final favoriteMovies = ref.watch(favoriteMoviesProvider).values.toList();

    if (favoriteMovies.isEmpty) {
      final colors = Theme.of(context).colorScheme;

      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_border_sharp,
              size: 60,
              color: colors.primary,
            ),
            Text("Aun no tienes favoritos"),
            const SizedBox(
              height: 20,
            ),
            FilledButton.tonal(
                onPressed: () {
                  context.go("/home/0");
                },
                child: Text("ir a buscar"))
          ],
        ),
      );
    }

    return Scaffold(
        body: MovieMasonry(
      loadNextpage: loadNextPage,
      movies: favoriteMovies,
    ));
  }
}
