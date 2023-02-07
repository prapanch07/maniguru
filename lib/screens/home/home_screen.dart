import 'package:flutter/material.dart';
import 'package:maniguru/screens/Add%20Transactions/add_transactions.dart';
import 'package:maniguru/screens/category/category_screen.dart';
import 'package:maniguru/screens/home/widgets/bottom_navigation.dart';
import 'package:maniguru/screens/transation/transation_screen.dart';

import '../category/category_popup.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static ValueNotifier<int> selectedindexNotifier = ValueNotifier(0);

  final _pages = const [
   
    TransactionScreen(),
     CategoryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        
        title: Text('MANIGuru'),

      ),
      body: SafeArea(
        child: ValueListenableBuilder(
            valueListenable: selectedindexNotifier,
            builder: (BuildContext ctx, int updatedIndex, Widget? _) {
              return _pages[updatedIndex];
            }),
      ),
      floatingActionButton: FloatingActionButton(

        onPressed: () {
          if(selectedindexNotifier.value == 0){
            print('Add Transactions');
            Navigator.of(context).pushNamed(AddTransactions.routeName);
          }
         else{
           print('Add category');
           catpopup(context);
         }
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: MoneyGuruBottomNavigation(),
    );
  }
}
