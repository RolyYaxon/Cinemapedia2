import 'package:cinemapedia2/presentation/views/home_views/favorites_view.dart';
import 'package:cinemapedia2/presentation/views/home_views/home_view.dart';
import 'package:flutter/material.dart';

import '../../widgets/shared/custom_bottom_navigation.dart';

class HomeScreen extends StatelessWidget {
  static const name = "home-screen";

  final int pageIndex;
  const HomeScreen({
    super.key,
    required this.pageIndex,
  });

  final viewRoutes = const <Widget>[
    HomeView(),
    SizedBox(),
    FavoritesView(),
  ];

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(

        body: IndexedStack(
          index: pageIndex,
          children: viewRoutes,
        ),
        bottomNavigationBar: CustomBottomNavigation(
          currentIndex: pageIndex,
        ));
  }
}
