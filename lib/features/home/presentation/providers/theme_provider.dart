import 'package:flutter_riverpod/flutter_riverpod.dart';

final isDarkModeProvider = NotifierProvider<ThemeModeNotifier, bool>(() => ThemeModeNotifier());

class ThemeModeNotifier extends Notifier<bool> {
  @override
  bool build() => false;
  
  void toggle() => state = !state;
  void setDarkMode(bool value) => state = value;
}
