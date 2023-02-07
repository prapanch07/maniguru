import 'package:flutter/material.dart';

import '../../db/category/category_db.dart';
import '../../models/category/category_model.dart';

class IncomeList extends StatelessWidget {
  const IncomeList({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: categorydb().incomeCategoryNotifier,
      builder: (BuildContext ctx , List<categoryModel> newList, Widget? _){
        return  ListView.separated(
        itemBuilder: ((context, index) {
          final _categoryINC = newList[index];
          return ListTile(
            title: Text(_categoryINC.name),
            trailing: IconButton(
              onPressed: () {
                 categorydb.instance.deletecategory(_categoryINC.id);
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
