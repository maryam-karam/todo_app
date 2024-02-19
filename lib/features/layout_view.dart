import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/features/settings-provider.dart';

class LayoutView extends StatelessWidget {
  const LayoutView({super.key});
  static const String routeName = "LayoutView";
  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<SettingsProvider>(context);

    return Scaffold(
      body: vm.screens[vm.currentIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add,
        color: Colors.white,),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        elevation: 0,
        child: BottomNavigationBar(
          elevation: 0,
          currentIndex: vm.currentIndex,
          onTap: vm.changeIndex,
          items:const [
             BottomNavigationBarItem(icon: Icon(Icons.list), label: "Tasks"),
             BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: "Settings"),
          ],
        ),
      ),
    );
  }
}
