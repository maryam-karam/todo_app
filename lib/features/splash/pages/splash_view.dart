import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../layout_view.dart';
import '../../login/pages/login_view.dart';
import '../../settings-provider.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});
  static const String routeName = "SplashView";

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  //for using timer in splash screen
  void initState() {
    Timer(
      Duration(seconds: 3),
      () {
        Navigator.pushReplacementNamed(context, LoginView.routeName);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var vm = Provider.of<SettingsProvider>(context);

    return Scaffold(
      body: Image.asset(
        vm.isDark()
            ? "assets/images/splash -dark.png"
            : "assets/images/splash.png",
        fit: BoxFit.cover,
        height: mediaQuery.height,
        width: mediaQuery.width,
      ),
    );
  }
}
