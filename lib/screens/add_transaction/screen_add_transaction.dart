import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:money_management/db/category/category_db.dart';
import 'package:money_management/db/transaction/transaction_db.dart';
import 'package:money_management/models/category/category_model.dart';
import 'package:money_management/models/transaction/transaction_model.dart';

class screenaddtransaction extends StatefulWidget {
  static const routeName ='add-transaction';
  const screenaddtransaction({super.key});

  @override
  State<screenaddtransaction> createState() => _screenaddtransactionState();
}

class _screenaddtransactionState extends State<screenaddtransaction> {

  DateTime? _SelecteDate;
  CategoryType? _setectedCategoryType;
  CategoryModel? _setectedCategoryModel;
  
  String? _categoryID;

  final _purposeTextEditingController = TextEditingController();
  final _amoundTextEditingController  = TextEditingController();

    @override
  void initState() {
    _setectedCategoryType = CategoryType.income;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:
       Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextFormField(
                controller: _purposeTextEditingController,
                decoration:const InputDecoration(
                  hintText: 'purpose'
                ),
              ),
              TextFormField(
                controller: _amoundTextEditingController,
                keyboardType: TextInputType.number,
                decoration:const InputDecoration(
                  hintText: 'Amond'
                ),
              ),

              
              TextButton.icon(onPressed: ()async{
                 final _SelecteDateTemp = await showDatePicker(context: context, 
                  initialDate: DateTime.now() ,
                   firstDate: DateTime.now().subtract(Duration(days: 30)), 
                  lastDate: DateTime.now(),);
               if(_SelecteDateTemp == null){
                return;
               }else{
                print(_SelecteDateTemp.toString());
                setState(() {
                  _SelecteDate=_SelecteDateTemp;
                });
               }
              }, icon:Icon(Icons.calendar_today), 
              label: Text(_SelecteDate == null ? 'Select Date' : _SelecteDate.toString())),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Radio(
                        value: CategoryType.income, 
                        groupValue: _setectedCategoryType,
                         onChanged: (newValue){
                          setState(() {
                            _setectedCategoryType = CategoryType.income;
                            _categoryID = null;
                          });
                         }
                      ),
                      Text('Income')
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: CategoryType.expense, 
                        groupValue: _setectedCategoryType,
                         onChanged: (newValue){
                         setState(() {
                            _setectedCategoryType = CategoryType.expense;
                            _categoryID = null;
                         });
                         }
                      ),
                      Text('Expance')
                    ],
                  ),
                ],
              ),
              DropdownButton<String>(
                hint: const Text('Select Category'),
                value: _categoryID,
                items:(_setectedCategoryType == CategoryType.income
                ? CategoryDb().incomeCategoryListListener
                : CategoryDb().expenseCategoryListListener)
                .value.map((e) {
                  return DropdownMenuItem(
                    value: e.id,
                    child: Text(e.name),
                    onTap: () {
                     setState(() {
                        _setectedCategoryModel = e;
                     });
                    },
                  );
              }).toList(), onChanged: (selectedvalue){
                  setState(() {
                    _categoryID =selectedvalue;
                  });
              }),

              ElevatedButton(onPressed: (){
                  addTransaction();
              },child: Text('Submit'))
            ],
          ),
        )
        ));
  }
  Future<void> addTransaction()async{
        final _purposeText = _purposeTextEditingController.text;
        final _amoundText = _amoundTextEditingController.text;

        if(_purposeText.isEmpty){
          return;
        }
        if(_amoundText.isEmpty){
          return;
        }
        if(_setectedCategoryModel == null){
          return;
        }
        if(_SelecteDate == null){
          return;
        }
        final _parseAmound = double.tryParse(_amoundText);
        if(_parseAmound == null){
          return;
        }
        //_SelecteDate
        //_setectedCategoryType
        //_categoryID
        // _SelecteDate

     final _model = transactionModel(
        purpose: _purposeText, 
        amound: _parseAmound,
        date: _SelecteDate!,
        type: _setectedCategoryType!,
        category: _setectedCategoryModel!,
      );
   await TransactionDB.instance.addTransaction(_model);
   Navigator.of(context).pop();
   TransactionDB.instance.refresh();
  }
}

