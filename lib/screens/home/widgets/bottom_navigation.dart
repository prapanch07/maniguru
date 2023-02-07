import 'package:flutter/material.dart';
import 'package:maniguru/screens/home/home_screen.dart';

class MoneyGuruBottomNavigation extends StatelessWidget {
  const MoneyGuruBottomNavigation({super.key});

   

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: HomeScreen.selectedindexNotifier,
      builder: (BuildContext ctx , int updatedIndex, Widget? _)  {
        return  BottomNavigationBar(
        currentIndex: updatedIndex,
        onTap: (newIndex) => {
            HomeScreen.selectedindexNotifier.value = newIndex
        },
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Transactions'),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Category')
        ],
      );
      },
    );
  }
}
