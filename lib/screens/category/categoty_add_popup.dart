import 'package:flutter/material.dart';
import 'package:money_management/db/category/category_db.dart';
import 'package:money_management/models/category/category_model.dart';

ValueNotifier<CategoryType>selectCategiryNotifier=ValueNotifier(CategoryType.income);

Future<void>showCategiryAddPopup(BuildContext context)async{

  final _nameEditingController = TextEditingController();

  showDialog(
    context: context,
   builder: (ctx) {
     return SimpleDialog(
      title: Text('Add category'),
       children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextFormField(
            controller: _nameEditingController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "category Name"
            ),
          ),
        ),
        
         Padding(
           padding: const EdgeInsets.all(10.0),
           child: Row(
            children: [
              RadioButton(title:"Income", type: CategoryType.income),
              RadioButton(title:"Expence", type: CategoryType.expense)
            ],
           ),
         ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: ElevatedButton(
            onPressed: (){
              final _name =_nameEditingController.text;
              if(_name.isEmpty){
                print('name id empty');
              }
              final _type =selectCategiryNotifier.value;
              final _category = CategoryModel(
               id: DateTime.now().microsecondsSinceEpoch.toString(), 
               name: _name, 
               type: _type,
              );
              CategoryDb().insertCategory(_category);
              Navigator.of(ctx).pop();
            },
             child: Text('Add'),
             ),
        )
       ],
     );
   },
   );
}
class RadioButton extends StatelessWidget {
  final String title;
  final CategoryType type;
  const RadioButton({super.key,
  required this.title,
  required this.type
  });

  @override
  Widget build(BuildContext context) {
     return Row(
      children: [
    ValueListenableBuilder(
      valueListenable: selectCategiryNotifier,
       builder: (BuildContext context, CategoryType newCategory, Widget? _) {
        return Radio<CategoryType>(
          value: type,
         groupValue:newCategory, 
         onChanged:(value){
          if(value==null){
            return;
          }
          selectCategiryNotifier.value=value;
          selectCategiryNotifier.notifyListeners();
         },
         
         );
       },
       ),
       Text(title)
       ],
       );
  }
}
