
import 'package:flutter_test/flutter_test.dart';
import 'package:expensetracker/controller/home_provider.dart';
import 'package:expensetracker/model/expense_model.dart';

void main() {
  group('ExpenseProvider', () {
    test('Test loading data', () async {
      final provider = ExpenseProvider();
      await provider.loadData();
      expect(provider.expenses.isNotEmpty, true);
    });

    test('Test adding expenses', () async {
      final provider = ExpenseProvider();
      final initialCount = provider.expenses.length;
      final expense = ExpenseModel(
        id: '1',
        amount: 100,
        date: DateTime.now(),
        category: 'Test',
        description: 'Test expense',
      );
      await provider.addExpenses(expense);
      expect(provider.expenses.length, initialCount + 1);
    });

    test('Test updating expenses', () async {
      final provider = ExpenseProvider();
      final initialCount = provider.expenses.length;
      final expense = ExpenseModel(
        id: '1',
        amount: 100,
        date: DateTime.now(),
        category: 'Test',
        description: 'Test expense',
      );
      await provider.addExpenses(expense);
      final updatedExpense = ExpenseModel(
        id: '1',
        amount: 200,
        date: DateTime.now(),
        category: 'Updated',
        description: 'Updated expense',
      );
      await provider.updateExpense(updatedExpense);
      expect(provider.expenses.length, initialCount + 1);
      expect(provider.expenses[0].amount, 200);
      expect(provider.expenses[0].category, 'Updated');
    });

  });
}
