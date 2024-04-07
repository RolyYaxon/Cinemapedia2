import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/theme/app_theme.dart';


final isDarkModeProvider = StateProvider((ref) => false);






final selectedColorProvider = StateProvider((ref) => 0);

final appThemeProvider =
    StateNotifierProvider<ThemeNotifier, AppTheme>((ref) => ThemeNotifier());

class ThemeNotifier extends StateNotifier<AppTheme> {
  ThemeNotifier() : super(AppTheme());

  void toggleDarkMode() {
    state = state.copyWith(isDarkMode: !state.isDarkMode);
  }

  }
