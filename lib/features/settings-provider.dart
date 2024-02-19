
import 'package:flutter/material.dart';
import 'package:todo_app/features/settings/pages/settings_view.dart';
import 'package:todo_app/features/tasks/pages/tasks_view.dart';

class SettingsProvider extends ChangeNotifier {
  int currentIndex = 0;
  changeIndex(int index) {
    if (currentIndex == index) return;
    currentIndex = index;

    notifyListeners();
  }

  ThemeMode currentTheme = ThemeMode.light;
  changeTheme(ThemeMode newTheme) {
    if (currentTheme == newTheme) return;
    currentTheme = newTheme;

    notifyListeners();
  }

  bool isDark() {
    return currentTheme == ThemeMode.dark;
  }

  var currentLanguage="en";
  changLanguage(String newLanguage){
    if(currentLanguage==newLanguage)return;
    currentLanguage=newLanguage;
    notifyListeners();
  }

  List<Widget> screens =  [
    TasksView(),
     SettingsView(),
  ];
}
