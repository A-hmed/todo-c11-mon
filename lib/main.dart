import 'package:flutter/material.dart';
import 'package:todo/ui/home.dart';
import 'package:todo/ui/utils/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialRoute: HomeScreen.route,
      themeMode: ThemeMode.light,
      routes: {
        HomeScreen.route : (_) => HomeScreen(),
      },
      darkTheme: AppTheme.dark,
    );
  }
}
