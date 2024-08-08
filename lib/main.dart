import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/ui/providers/list_provider.dart';
import 'package:todo/ui/screens/auth/login/login_screen.dart';
import 'package:todo/ui/screens/auth/register/register_screen.dart';
import 'package:todo/ui/screens/home/home.dart';
import 'package:todo/ui/utils/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(apiKey:  "AIzaSyDIgAjXGjFjkfpItpb7Sx2RCWco6Mx_hXY",
        appId: "1:521300274354:android:f35ad6cbc57cf7f24a6dab",
        messagingSenderId: "1:521300274354:android:f35ad6cbc57cf7f24a6dab",
        projectId: "todo-mon-c11"),
  );
  FirebaseFirestore.instance.settings =
      Settings(persistenceEnabled: true);
  FirebaseFirestore.instance.disableNetwork();
  runApp(ChangeNotifierProvider(
      create: (_) => ListProvider(),
      child: const MyApp()));

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
      initialRoute: LoginScreen.routeName,
      themeMode: ThemeMode.light,
      routes: {
        RegisterScreen.routeName: (_) => RegisterScreen(),
        LoginScreen.routeName: (_) => LoginScreen(),
        HomeScreen.routeName : (_) => HomeScreen(),
      },
      darkTheme: AppTheme.dark,
    );
  }
}
