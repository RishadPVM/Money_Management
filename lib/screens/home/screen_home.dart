import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:money_management/db/category/category_db.dart';
import 'package:money_management/models/category/category_model.dart';
import 'package:money_management/screens/add_transaction/screen_add_transaction.dart';
import 'package:money_management/screens/category/categoty_add_popup.dart';
import 'package:money_management/screens/category/screen_category.dart';
import 'package:money_management/screens/home/widgets/bottom_navigation.dart';
import 'package:money_management/screens/transaction/screen_transaction.dart';

class screenHome extends StatelessWidget {
  const screenHome({super.key});

  static ValueNotifier<int> seletNidexNotfire = ValueNotifier(0);
  final _pages =const[
    screenTransaction(),
    screenCatgory()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('MONEY MANAGER'),centerTitle: true,),
      bottomNavigationBar:const MoneyManagerBottomNavigation(),
      body: SafeArea(child: ValueListenableBuilder(
        valueListenable: seletNidexNotfire,
      builder:(BuildContext context, int updateIndex, _) {
        return _pages[updateIndex];
      },
      )),
      floatingActionButton: FloatingActionButton(onPressed:() {
        if(seletNidexNotfire.value==0){
          print('add Transaction');
          Navigator.of(context).pushNamed(screenaddtransaction.routeName);
        }else{
          print('Add catagiry');
          showCategiryAddPopup(context);
        }
        
      },
      child: Icon(Icons.add),
      ),
    );
  }
}  