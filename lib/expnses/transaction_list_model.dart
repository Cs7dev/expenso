import 'package:Expenso/expnses/transactions_database.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

import 'expense.dart';

class TransactionList extends ChangeNotifier {
  List<Expense> transactions = [];

  bool _isInitialized = false;

  TransactionList() {
    loadUsersFromDatabase();
  }

  Future<void> loadUsersFromDatabase() async {
    if (_isInitialized) {
      return;
    }

    _isInitialized = true;

    var isar = await TransacationsDatabase.isar();
    var tempUserList = await isar!.expenses
        .filter()
        .isarIdGreaterThan(Isar.minId)
        .sortBySelectedDate()
        .findAll();

    transactions = tempUserList;
    notifyListeners();
  }

  void add(Expense expense) {
    if (transactions.contains(expense)) {
      return;
    }

    transactions.add(expense);
    notifyListeners();
  }

  void insert(int index, Expense expense) {
    if (transactions.contains(expense)) {
      return;
    }

    transactions.insert(index, expense);
    notifyListeners();
  }

  void sort([int Function(Expense, Expense)? compare]) {
    transactions.sort(compare);
    notifyListeners();
  }

  Expense removeAt(int index) {
    if (index >= transactions.length) {
      throw "Out of bounds. Index accessed: $index, length of list: ${transactions.length}";
    }

    Expense deleted = transactions.removeAt(index);
    notifyListeners();
    return deleted;
  }

  Future<void> save() async {
    TransacationsDatabase.putAll(list);
  }

  List<Expense> get list => transactions;
}
