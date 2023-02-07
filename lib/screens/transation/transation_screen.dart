import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:maniguru/db/category/category_db.dart';
import 'package:maniguru/db/transactions/transaction_db.dart';
import 'package:maniguru/models/category/category_model.dart';

import '../../models/transactions/transaction_model.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TransactionDB.instance.refresh();
    categorydb.instance.RefreshUi();

    return ValueListenableBuilder(
      valueListenable: TransactionDB.instance.transactionListNotifier,
      builder: (BuildContext ctx, List<transactionModel> newlist, Widget? _) {
        return ListView.separated(
          padding: const EdgeInsets.all(10),

          //values

          itemBuilder: ((BuildContext ctx, int intex) {
            final _value = newlist[intex];
            return Slidable(
              key: Key(_value.id!),
              startActionPane: ActionPane(
                motion: ScrollMotion(),
                children: [
                  SlidableAction(
                    backgroundColor: Color.fromARGB(255, 255, 0, 0),
                    onPressed: (ctx) {
                      TransactionDB.instance.delete(_value.id!);
                    },
                    icon: Icons.delete,
                    label: 'Delete',
                  )
                ],
              ),
              child: Card(
                elevation: 0,
                child: ListTile(
                  leading: CircleAvatar(
                    // backgroundColor: _value.type == CategoryType.income
                    //     ? Colors.green
                    //     : Colors.red,
                    radius: 25,
                    child: Text(
                      parseDATE(_value.date),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  title: Text('${_value.amount} rs'),
                  subtitle: Text(_value.category.name),
                  trailing: CircleAvatar(
                    radius: 5,
                    backgroundColor: _value.type == CategoryType.income
                        ? Color.fromARGB(255, 9, 161, 22)
                        : Color.fromARGB(255, 221, 0, 0),
                  ),
                ),
              ),
            );
          }),
          separatorBuilder: ((BuildContext ctx, int intex) {
            return const SizedBox(
              height: 0.0001,
            );
          }),
          itemCount: newlist.length,
        );
      },
    );
  }

  String parseDATE(DateTime date) {
    final _date = DateFormat.MMMd().format(date);
    final splitteddata = _date.split(' ');
    return '${splitteddata.last}\n${splitteddata.first}';
    //   return'${date.day}\n${date.month}';
  }
}
