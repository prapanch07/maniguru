import 'package:hive_flutter/hive_flutter.dart';
import 'package:maniguru/models/category/category_model.dart';
part 'transaction_model.g.dart';

@HiveType(typeId: 3)
class transactionModel {
  @HiveField(0)
  final String purpose;

  @HiveField(1)
  final double amount;

  @HiveField(2)
  final DateTime date;

  @HiveField(3)
  final CategoryType type;

  @HiveField(4)
  final categoryModel category;

  @HiveField(5)
  String? id;

  transactionModel({
    required this.purpose,
    required this.amount,
    required this.date,
    required this.type,
    required this.category,
  }) {
    id = DateTime.now().millisecondsSinceEpoch.toString();
  }
}
