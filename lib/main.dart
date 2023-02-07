import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:maniguru/models/category/category_model.dart';
import 'package:maniguru/models/transactions/transaction_model.dart';
import 'package:maniguru/screens/Add%20Transactions/add_transactions.dart';
import 'package:maniguru/screens/home/home_screen.dart';

Future<void> main() async {
WidgetsFlutterBinding.ensureInitialized();


 await Hive.initFlutter();

 if(!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)){
   Hive.registerAdapter(CategoryTypeAdapter());
 }

 if(!Hive.isAdapterRegistered(categoryModelAdapter().typeId)){
    Hive.registerAdapter(categoryModelAdapter());
    
 }
 if(!Hive.isAdapterRegistered(transactionModelAdapter().typeId)){
    Hive.registerAdapter(transactionModelAdapter());
 }

  // TransactionDB.instance.refresh();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const HomeScreen(),
      routes: {
        AddTransactions.routeName:(ctx) => const AddTransactions()
      },
    );
  }
}
