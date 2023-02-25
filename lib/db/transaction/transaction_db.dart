//import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_management/models/category/category_model.dart';
import 'package:money_management/models/transaction/transaction_model.dart';

const TRANSACTION_DB_NAME = 'transaction-db';

abstract class TransactionDbFunction{
  Future<void> addTransaction(transactionModel obj);
  Future<List<transactionModel>>getAllTransaction();
  Future<void>deleteTransaction(String id);
}

class TransactionDB implements TransactionDbFunction{
   
   TransactionDB._internal();
  static TransactionDB instance =TransactionDB._internal();

  factory TransactionDB(){
    return instance;
  }

  ValueNotifier<List<transactionModel>> transactionListnotifier =ValueNotifier([]);
 
  @override
  Future<void> addTransaction(transactionModel obj)async {
    final _db=await Hive.openBox<transactionModel>(TRANSACTION_DB_NAME);
   await _db.put(obj.id, obj);
  }
  
  Future<void>refresh()async{
    final _list =await getAllTransaction();
    _list.sort((first,secont)=>secont.date.compareTo(first.date));
    transactionListnotifier.value.clear();
    transactionListnotifier.value.addAll(_list);
    transactionListnotifier.notifyListeners();
  }

  @override
  Future<List<transactionModel>> getAllTransaction()async {
    final _db = await Hive.openBox<transactionModel>(TRANSACTION_DB_NAME);
    return _db.values.toList();
  }
  
  @override
  Future<void> deleteTransaction(String id) async{
    final _db = await Hive.openBox<transactionModel>(TRANSACTION_DB_NAME);
    await _db.delete(id);
    refresh();
  }

  
}
