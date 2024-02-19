import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../settings-provider.dart';

class SettingsView extends StatelessWidget {
  SettingsView({super.key});

  final List<String> languageList = [
    "English",
    "عربى",
  ];

  final List<String> themeMode = [
    "dark",
    "light",
  ];
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    //var lang = AppLocalizations.of(context)!;

    var vm = Provider.of<SettingsProvider>(context);
    var mediaQuery = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          width: mediaQuery.width,
          height: mediaQuery.height * 0.2,
          color: theme.primaryColor,
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
          child: Text(
            "Settings",
            style: theme.textTheme.titleLarge,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Language",
                // lang.language,
                style: theme.textTheme.bodySmall,
              ),
              SizedBox(
                height: 10,
              ),
              CustomDropdown(
                items: languageList,
                //initial item =>دى عشان لما اجى اشوف اللغه االى انا حطاها ميكتليش select
                initialItem: vm.currentLanguage == "en"
                    ?
                    "English"
                    :
                    "عربى",
                decoration: CustomDropdownDecoration(
                  expandedFillColor:
                  vm.isDark() ? Color(0XFF141922) : Colors.white,
                  closedFillColor:
                  vm.isDark() ? Color(0XFF141922) : Colors.white,
                  closedBorder: Border.all(
                    color: theme.primaryColor,
                  ),
                  closedBorderRadius: BorderRadius.circular(4),

                ),
                onChanged: (value) {
                  if (value == "English") {
                    vm.changLanguage("en");
                  } else if (value == "عربى") {
                    vm.changLanguage("ar");
                  }
                },
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                  // lang.theme,
                   style: theme.textTheme.bodySmall,
                  "Theme Mode"),
              SizedBox(
                height: 10,
              ),
              CustomDropdown(
                items: themeMode,
                initialItem: vm.isDark() ? "dark" : "light",
                decoration: CustomDropdownDecoration(
                  expandedFillColor:
                      vm.isDark() ? Color(0XFF141922) : Colors.white,
                  closedFillColor:
                      vm.isDark() ? Color(0XFF141922) : Colors.white,
                  closedBorder: Border.all(
                    color: theme.primaryColor,
                  ),
                  closedBorderRadius: BorderRadius.circular(4),
                ),
                onChanged: (value) {
                  if (value == "dark") {
                    vm.changeTheme(ThemeMode.dark);
                  } else if (value == "light") {
                    vm.changeTheme(ThemeMode.light);
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
