import 'package:hive_flutter/adapters.dart';
import 'package:money_management/models/category/category_model.dart';
part 'transaction_model.g.dart';

@HiveType(typeId: 3)
class transactionModel{

  @HiveField(0)
  final String purpose;

  @HiveField(1)
  final double amound;

  @HiveField(2)
  final DateTime date;

  @HiveField(3)
  final CategoryType type;

  @HiveField(4)
  final CategoryModel category;

  @HiveField(5)
   String? id;

  transactionModel({
    required this.purpose,
    required this.amound, 
    required this.date, 
    required this.type,
    required this.category,
    }){
      id = DateTime.now().microsecondsSinceEpoch.toString();
    }

}