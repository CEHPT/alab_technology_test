import 'package:alab_technology_test/providers/post_provider.dart';
import 'package:alab_technology_test/providers/theme_provider.dart';
import 'package:alab_technology_test/screens/login_screen.dart';
import 'package:alab_technology_test/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    
    MultiProvider(
      providers: [
          ChangeNotifierProvider(create: (context) => PostsProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      
        child: const MyApp(),
      
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Modern Flutter UI',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeProvider.themeMode,
          home: const LoginScreen(),
        );
      },
    );
  }
}
