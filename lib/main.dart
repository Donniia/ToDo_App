import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:t0d0/AppTheme/app_theme.dart';
import 'package:t0d0/Providers/Auth_Provider.dart';
import 'package:t0d0/Providers/tasks_provider.dart';
import 'package:t0d0/UI/Home/home_screen.dart';
import 'package:t0d0/UI/LoginScreen/login_screen.dart';
import 'package:t0d0/UI/SplashScreen/splash.dart';
import 'package:t0d0/firebase_options.dart';

import 'Providers/theme_provider.dart';
import 'UI/RegisterScreen/register_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  var themeProvider = ThemeProvider();
 await themeProvider.loadSettingConfig();
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => Auth_Provider()),
          ChangeNotifierProvider(create: (context) => TasksProvider()),
          ChangeNotifierProvider(create: (context) => themeProvider),
        ],
          child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode:themeProvider.currentTheme ,
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (_) => SplashScreen(),
        RegisterScreen.routeName: (_) => RegisterScreen(),
        LoginScreen.routeName: (_) => LoginScreen(),
        HomeScreen.routeName: (_) => HomeScreen(),
      },
    );
  }
}
