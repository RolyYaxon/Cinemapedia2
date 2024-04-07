import 'package:flutter/material.dart';

import '../../../config/domain/entities/movie.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'movie_poster_link.dart';

class MovieMasonry extends StatefulWidget {
  final List<Movie> movies;
  final VoidCallback? loadNextpage;

  const MovieMasonry({super.key, required this.movies, this.loadNextpage});

  @override
  State<MovieMasonry> createState() => _MovieMasonry();
}

class _MovieMasonry extends State<MovieMasonry> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (widget.loadNextpage == null) return;

      if ((scrollController.position.pixels + 200) >=
          scrollController.position.maxScrollExtent) {
        widget.loadNextpage!();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: MasonryGridView.count(
          controller: scrollController,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          itemCount: widget.movies.length,
          crossAxisCount: 3,
          itemBuilder: (context, index) {
            if (index == 1) {
              return Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  MoviePosterLink(movie: widget.movies[index])
                ],
              );
            }

            return MoviePosterLink(movie: widget.movies[index]);
          }),
    );
  }
}
