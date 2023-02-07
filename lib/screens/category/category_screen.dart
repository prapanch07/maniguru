import 'package:flutter/material.dart';
import 'package:maniguru/screens/category/expense_list.dart';
import 'package:maniguru/screens/category/income_list.dart';

import '../../db/category/category_db.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);

    categorydb().RefreshUi();
   
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          
          controller: _tabController,
          tabs: [
            Tab(
              text: 'INCOME',
            ),
            Tab(
              text: 'Expense',
            )
          ],
        ),

        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              IncomeList(),
              ExpenseList()
              
          ]),
        )
      ],
    );
  }
}
