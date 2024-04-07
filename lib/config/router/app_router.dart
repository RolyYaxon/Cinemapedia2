import 'package:cinemapedia2/presentation/screens/movies/home_screen.dart';
import 'package:cinemapedia2/presentation/screens/movies/movie_screen.dart';


import 'package:go_router/go_router.dart';

final appRoute = GoRouter(initialLocation: "/home/0", routes: [
  //Rutas padre/hijo
  GoRoute(
      path: "/home/:page",
      name: HomeScreen.name,
      builder: (context, state) {
        final pageIndex = state.pathParameters["page"] ?? "0";

        return HomeScreen(pageIndex: int.parse(pageIndex),);
      },
      routes: [
        GoRoute(
            path: 'movie/:id',
            name: MovieScreen.name,
            builder: (context, state) {
              final movieId = state.pathParameters["id"] ?? "no id";

              return MovieScreen(movieId: movieId);
            }),
      ]),


      GoRoute(path: "/",
      redirect: (_, __) => "/home/0"
      )
]);
