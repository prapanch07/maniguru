import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:maniguru/models/category/category_model.dart';
import 'package:maniguru/screens/category/income_list.dart';

final catname = 'catagory_database';


abstract class categorydbFunctions {
  Future<List<categoryModel>> getcategories();

  Future<void> insertcategory(categoryModel val);

  Future<void> deletecategory(String categoryID);
}

class categorydb implements categorydbFunctions {

  categorydb.internal();

  static categorydb instance = categorydb.internal();
  factory categorydb(){
    return instance;
  }

  ValueNotifier<List<categoryModel>> incomeCategoryNotifier = ValueNotifier([]);
  ValueNotifier<List<categoryModel>> expenseCategoryNotifier = ValueNotifier([]);


  @override
  Future<void> insertcategory(categoryModel val) async {
    final _category_db = await Hive.openBox<categoryModel>(catname);
    _category_db.put(val.id,val);
    RefreshUi();
  }

  @override
  Future<List<categoryModel>> getcategories() async {
    final _category_db = await Hive.openBox<categoryModel>(catname);
    return _category_db.values.toList();

  }

  Future<void> RefreshUi() async{

   final _allcategories = await getcategories();

   incomeCategoryNotifier.value.clear();
   expenseCategoryNotifier.value.clear();


   Future.forEach(_allcategories, (categoryModel category){
    if(category.type == CategoryType.income){
      incomeCategoryNotifier.value.add(category);
    }
    else if(category.type == CategoryType.expense){
      expenseCategoryNotifier.value.add(category);
    }
   });
   incomeCategoryNotifier.notifyListeners();
   expenseCategoryNotifier.notifyListeners();
  }
  
  @override
  Future<void> deletecategory(String categoryID)async {
    
  final _category_db = await Hive.openBox<categoryModel>(catname);
  await _category_db.delete(categoryID);
  RefreshUi();
  }
}
