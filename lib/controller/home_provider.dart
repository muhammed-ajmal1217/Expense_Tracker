import 'package:expensetracker/database_functions.dart/database_function.dart';
import 'package:expensetracker/model/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';


class ExpenseProvider extends ChangeNotifier {

  List<ExpenseModel> expenses = [];
  
  final box = Hive.box<ExpenseModel>('expense_box');

  ExpenseProvider() {
    loadData();
  }
  Future<void> loadData() async {
    try {
      final expenseBox = await Hive.box<ExpenseModel>('expense_box');
      expenses = expenseBox.values.toList();
      notifyListeners();
    } catch (e) {
      Exception(e);
    }
  }

  addExpenses(ExpenseModel expense) async {
    try {
      final id = expense.id;
      final amount = expense.amount;
      final date = expense.date;
      final description = expense.description;
      final category = expense.category;
      if (id!=null &&
          amount!=null &&
          date != null &&
          description!=null &&
          category!.isNotEmpty) {
        ExpenseModel expense = ExpenseModel(
          id: id,
          amount: amount,
          date: date,
          category: category,
          description: description,
        );
        await DataBase.addExpenseBox(expense);
        notifyListeners();
      }
    } catch (e) {
      throw Exception('Error in adding expense$e');
    }
  }

  updateExpense(ExpenseModel expens) async {
    try {
      final amount = expens.amount;
      final date = expens.date;
      final description = expens.description;
      final category = expens.category;
      if (expens.id != null &&
          amount!=null &&
          date != null &&
          description!=null &&
          category!.isNotEmpty) {
        ExpenseModel expense = ExpenseModel(
          id: expens.id,
          amount: amount,
          date: date,
          category: category,
          description: description,
        );
        await DataBase.updateExpense(expens.id!, expense);
        notifyListeners();
      }
    } catch (e) {
      throw Exception('Error in adding expense$e');
    }
  }

  // Future<void> selectDate(BuildContext context) async {
  //   final DateTime? pickedDate = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(2020),
  //     lastDate: DateTime(2100),
  //   );
  //   if (pickedDate != null) {
  //     final formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
  //     dateController.text = formattedDate;
  //     print('Selected date: $formattedDate');
  //   }
  //   notifyListeners();
  // }
  Future<void> selctDate(BuildContext context, TextEditingController date) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      final formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
      date.text = formattedDate;
      print('Selected date: $formattedDate');
    }
    notifyListeners();
  }

}
