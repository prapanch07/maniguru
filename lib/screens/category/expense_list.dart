
import 'package:flutter/material.dart';

import '../../db/category/category_db.dart';
import '../../models/category/category_model.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: categorydb().expenseCategoryNotifier,
      builder: (BuildContext ctx , List<categoryModel> newList, Widget? _){
        return  ListView.separated(
        itemBuilder: ((context, index) {
          final _categoryEXP = newList[index];
          return ListTile(
            title: Text(_categoryEXP.name),
            trailing: IconButton(
              onPressed: () {
               categorydb.instance.deletecategory(_categoryEXP.id);
              },
              icon: Icon(Icons.delete),
            ),
          );
        }),
        separatorBuilder: ((context, index) {
          return SizedBox(
            height: 5,
          );
        }),
        itemCount: newList.length);
      },
    );
  }
}
