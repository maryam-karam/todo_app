
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:todo_app/core/services/loading_service.dart';
import 'package:todo_app/features/layout_view.dart';
import 'package:todo_app/features/splash/pages/splash_view.dart';
import 'package:provider/provider.dart';
import 'core/config/application_theme_manager.dart';
import 'features/login/pages/login_view.dart';
import 'features/register/pages/register_view.dart';
import 'features/settings-provider.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
 main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context)=>SettingsProvider(),
      child: const MyApp(),
    ),
  );
  easyLoading();
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
        LoginView.routeName:(context)=>LoginView(),
        RegisterView.routeName:(context)=>RegisterView(),
        LayoutView.routeName: (context) => LayoutView(),

      },
      builder: EasyLoading.init(
        builder: BotToastInit(),
      ),
      navigatorObservers: [BotToastNavigatorObserver()], //2. registered route observer


    );
  }
}
