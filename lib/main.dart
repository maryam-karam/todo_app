
import 'package:flutter/material.dart';
import 'package:todo_app/config/constants/application_theme_manager.dart';
import 'package:todo_app/features/layout_view.dart';
import 'package:todo_app/features/splash/pages/splash_view.dart';
import 'package:provider/provider.dart';
import 'features/settings-provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context)=>SettingsProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    var vm=Provider.of<SettingsProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TODO',
      theme: ApplicationThemeManager.lightTheme,
      darkTheme: ApplicationThemeManager.DarkTheme,
      themeMode: vm.currentTheme,
      initialRoute: SplashView.routeName,
      routes: {
        SplashView.routeName: (context) => SplashView(),
        LayoutView.routeName: (context) => LayoutView(),

      },
    );
  }
}
