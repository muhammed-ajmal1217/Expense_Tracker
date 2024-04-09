import 'package:expensetracker/database_functions.dart/database_function.dart';
import 'package:expensetracker/model/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';


class ExpenseProvider extends ChangeNotifier {
  TextEditingController amountController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  String? selectedCategory;
  List<ExpenseModel> expenses = [];

  final uuid = Uuid();
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

  addExpenses() async {
    try {
      final id = uuid.v4();
      final amount = amountController.text;
      final date = dateController.text;
      final parsedDate = DateFormat('dd/MM/yyyy').parse(date);
      final description = descriptionController.text;
      final category = selectedCategory;
      if (id.isNotEmpty &&
          amount.isNotEmpty &&
          parsedDate != null &&
          description.isNotEmpty &&
          category!.isNotEmpty) {
        ExpenseModel expense = ExpenseModel(
          id: id,
          amount: int.parse(amount),
          date: parsedDate,
          category: category,
          description: description,
        );
        await DataBase.addExpenseBox(expense);
        amountController.clear();
        descriptionController.clear();
        dateController.clear();
        notifyListeners();
      }
    } catch (e) {
      throw Exception('Error in adding expense$e');
    }
  }

  updateExpense(ExpenseModel expens) async {
    try {
      final amount = amountController.text;
      final date = dateController.text;
      final parsedDate = DateFormat('dd/MM/yyyy').parse(date);
      final description = descriptionController.text;
      final category = selectedCategory;
      if (expens.id != null &&
          amount.isNotEmpty &&
          parsedDate != null &&
          description.isNotEmpty &&
          category!.isNotEmpty) {
        ExpenseModel expense = ExpenseModel(
          id: expens.id,
          amount: int.parse(amount),
          date: parsedDate,
          category: category,
          description: description,
        );
        await DataBase.updateExpense(expens.id!, expense);
        amountController.clear();
        descriptionController.clear();
        dateController.clear();
        notifyListeners();
      }
    } catch (e) {
      throw Exception('Error in adding expense$e');
    }
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      final formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
      dateController.text = formattedDate;
      print('Selected date: $formattedDate');
    }
    notifyListeners();
  }
}
