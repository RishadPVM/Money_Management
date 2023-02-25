import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:money_management/db/category/category_db.dart';
import 'package:money_management/screens/category/expense_catagory_list.dart';
import 'package:money_management/screens/category/income_catagory_list.dart';

class screenCatgory extends StatefulWidget {
  const screenCatgory({super.key});

  @override
  State<screenCatgory> createState() => _screenCatgoryState();
}

class _screenCatgoryState extends State<screenCatgory>with SingleTickerProviderStateMixin {


  late TabController _tabController;

  @override

  void initState() {
      _tabController=TabController(length: 2, vsync: this);
      CategoryDb().refreshUI();
    super.initState();
  }
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          tabs:const[
            Tab(text: 'INCOME',),
            Tab(text: 'EXPENSE',),
          ]
         ),
         Expanded(
           child: TabBarView(
            controller: _tabController,
            children:const[
               IncomCatagoryList(),
              ExpenseCatagoryList(),
           ]),
         )
      ],
    );
  }
  
}