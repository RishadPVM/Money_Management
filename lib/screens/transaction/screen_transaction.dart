import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:money_management/db/category/category_db.dart';
import 'package:money_management/db/transaction/transaction_db.dart';
import 'package:money_management/models/category/category_model.dart';
import 'package:money_management/models/transaction/transaction_model.dart';

class screenTransaction extends StatelessWidget {
  const screenTransaction ({super.key});

  @override
  Widget build(BuildContext context) {
    TransactionDB.instance.refresh();
    CategoryDb.instance.refreshUI();
    return ValueListenableBuilder(
      valueListenable: TransactionDB.instance.transactionListnotifier, 
      builder:(BuildContext ctx,List<transactionModel> newList, Widget? _) {
        return ListView.separated(
      padding:const EdgeInsets.all(10),
      itemBuilder: (ctx,index) {
        final _value = newList[index];

        return Slidable(
          key: Key(_value.id!),
          startActionPane: ActionPane(
            motion: ScrollMotion(),
             children: [
              SlidableAction(
                backgroundColor: Colors.red,
                onPressed: (ctx){
                  TransactionDB.instance.deleteTransaction(_value.id!);
                },
                icon: Icons.delete,
                label: "delete",
                )
             ]),
          child: Card(
            elevation: 0,
            child: ListTile(
              leading: CircleAvatar(
                radius: 50,
                child: Text(parseDate(_value.date),textAlign: TextAlign.center,),
                backgroundColor: _value.type ==CategoryType.income 
                ? Colors.green
                : Colors.red
                ),
              title: Text("RS ${_value.amound}"),
              subtitle: Text(_value.category.name),
            ),
          ),
        ) ;
      }, 
      separatorBuilder: (context, index) {
        return const SizedBox(height: 10,);
      },
      itemCount: newList.length,
        );
      },
      );
  }
 
 String parseDate(DateTime date){
  final _date = DateFormat.MMMd().format(date);
  final _splitedDate= _date.split(' ');
 return '${_splitedDate.last}\n${_splitedDate.first}';
 }

}