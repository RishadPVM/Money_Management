import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:money_management/screens/home/screen_home.dart';

class MoneyManagerBottomNavigation extends StatelessWidget {
  const MoneyManagerBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: screenHome.seletNidexNotfire,
      builder: (BuildContext ctx ,int uptadeIndex , Widget? _) {
        return BottomNavigationBar(
          currentIndex: uptadeIndex,
          selectedItemColor: Colors.purple,
          unselectedItemColor: Colors.grey,
        onTap: (newIndex) {
          screenHome.seletNidexNotfire.value=newIndex;
        },
        items:const [
        BottomNavigationBarItem(icon:Icon(Icons.home),label: "Transaction"),
        BottomNavigationBarItem(icon: Icon(Icons.category),label:"Catagory")
      ]);
      },
    );
  }
}