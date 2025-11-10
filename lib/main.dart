import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bazaar/theme/app_theme.dart';

import 'package:bazaar/features/home/presentation/providers/theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:bazaar/firebase_options.dart';
import 'package:bazaar/routes/app_router.dart' as app_router; // Added as app_router alias

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(isDarkModeProvider);

    return MaterialApp.router(
      title: 'Bazaar - Flipkart Clone',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      routerConfig: app_router.goRouter, // Used app_router.goRouter
    );
  }
}