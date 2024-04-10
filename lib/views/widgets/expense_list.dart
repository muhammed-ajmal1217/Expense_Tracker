import 'package:expensetracker/controller/home_provider.dart';
import 'package:expensetracker/database_functions.dart/database_function.dart';
import 'package:expensetracker/views/utils/lists.dart';
import 'package:expensetracker/views/utils/utils.dart';
import 'package:expensetracker/views/widgets/edit_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseProvider>(
      builder: (context, value, child) => ListView.builder(
        itemCount: value.expenses.length,
        itemBuilder: (context, index) {
          final expense = value.expenses.reversed.toList()[index];
          return Dismissible(
            key: Key(expense.id.toString()),
            background: Container(
              color: Colors.red.withOpacity(0.5),
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            onDismissed: (direction) async {
              DataBase.deleteExpense(expense.id!);
              await value.loadData();
            },
            confirmDismiss: (direction) async {
              return await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Confirm"),
                    content: const Text(
                        "Are you sure you wish to delete this item?"),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: const Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: const Text("Delete"),
                      ),
                    ],
                  );
                },
              );
            },
            child: ListTile(
              title: Text(
                '${expense.description}',
                style: GoogleFonts.montserrat(
                    color: Color.fromARGB(255, 3, 58, 69),
                    fontWeight: FontWeight.w500),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '${DateFormat('dd/MM/yyyy').format(expense.date!)}',
                      style: GoogleFonts.montserrat(
                          color: Colors.grey, fontSize: 10),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            color: AppUtils.getCategoryColor(
                                    expense.category ?? '')
                                .withOpacity(0.3)),
                        color: AppUtils.getCategoryColor(expense.category ?? '')
                            .withOpacity(0.1),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 3, right: 3),
                        child: Text(
                          '${expense.category}',
                          style: GoogleFonts.raleway(
                              color: Color.fromARGB(255, 73, 73, 73),
                              fontSize: 10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        ' ₹${expense.amount}/-',
                        style: GoogleFonts.montserrat(
                            color: Color.fromARGB(255, 8, 85, 148),
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return EditDialogue(
                                expense: expense,
                                categoryIcons: CategoryItem.categoryIcons,
                                categoryNames: CategoryItem.categoryNames);
                          },
                        );
                      },
                      child: Icon(Iconsax.edit))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
