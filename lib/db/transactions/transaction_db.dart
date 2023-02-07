import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:maniguru/models/transactions/transaction_model.dart';

const TRANSNAME = 'transaction-db';

abstract class TransactionDbFunctions {
  Future<void> addTransactions(transactionModel obj);
  Future<List<transactionModel>> getAllTransactions();
  Future<void>delete(String id);
}

class TransactionDB implements TransactionDbFunctions {
  TransactionDB._internal();

  static TransactionDB instance = TransactionDB._internal();

  factory TransactionDB() {
    return instance;
  }

  ValueNotifier<List<transactionModel>> transactionListNotifier =
      ValueNotifier([]);

  @override
  Future<void> addTransactions(transactionModel obj) async {
    final _db = await Hive.openBox<transactionModel>(TRANSNAME);
    await _db.put(obj.id, obj);
  }

  Future<void> refresh() async {
    final _list = await getAllTransactions();
    _list.sort(((a, b) => b.date.compareTo(a.date)));
    transactionListNotifier.value.clear();
    transactionListNotifier.value.addAll(_list);
    transactionListNotifier.notifyListeners();
  }

  @override
  Future<List<transactionModel>> getAllTransactions() async {
    final _db = await Hive.openBox<transactionModel>(TRANSNAME);
    return _db.values.toList();
  }
  
  @override
  Future<void> delete(String id) async{
    final _db = await Hive.openBox<transactionModel>(TRANSNAME);
   await _db.delete(id);
    refresh();
  }
  
  
}
