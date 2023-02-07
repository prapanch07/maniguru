import 'package:flutter/material.dart';
import 'package:maniguru/db/category/category_db.dart';
import 'package:maniguru/models/category/category_model.dart';

ValueNotifier<CategoryType> selectedcategorynotifier =
    ValueNotifier(CategoryType.income);

void catpopup(BuildContext context) {
  final _nameEditingcontroller = TextEditingController();

  showDialog(
    context: context,
    builder: (ctx) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: SimpleDialog(
          title: Text('ADD CATEGORY'),
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                controller: _nameEditingcontroller,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'category name'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  RadioButton(title: 'Income', type: CategoryType.income),
                  RadioButton(title: 'Expense', type: CategoryType.expense)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: ElevatedButton(
                onPressed: () {
                  final _name = _nameEditingcontroller.text;
                  if (_name.isEmpty) {
                    return null;
                  } else {
                    final _type = selectedcategorynotifier.value;
                    final _category = categoryModel(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        name: _name,
                        type: _type);

                       categorydb().insertcategory(_category);
          
                       print(ctx);
                       Navigator.of(ctx).pop();

                  }
                },
                child: Text('Add'),
              ),
            )
          ],
        ),
      );
    },
  );
}

class RadioButton extends StatelessWidget {
  final String title;
  final CategoryType type;

  const RadioButton({
    super.key,
    required this.title,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedcategorynotifier,
      builder: ((context, value, child) {
        return Row(
          children: [
            Radio<CategoryType>(
                value: type,
                groupValue: selectedcategorynotifier.value,
                onChanged: (val) {
                  if (val == null) {
                    return null;
                  }

                  selectedcategorynotifier.value = val;
                  selectedcategorynotifier.notifyListeners();
                }),
            Text(title)
          ],
        );
      }),
    );
  }
}
