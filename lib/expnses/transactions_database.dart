import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'expense.dart';

class TransacationsDatabase {
  TransacationsDatabase._();

  static Isar? _isar;

  /// Must be called at least once before using the class.
  /// Calling this method multiple times has no effect
  static Future<void> init() async {
    if (_isar != null) return;

    final isarDir = await getApplicationDocumentsDirectory();

    _isar = await Isar.open(
      [ExpenseSchema],
      directory: isarDir.path,
    );
  }

  static Future<IsarCollection<Expense>?> database() async {
    if (_isar == null) init();
    return _isar?.collection<Expense>();
  }

  static Future<Isar?> isar() async {
    if (_isar == null) await init();
    return _isar;
  }

  static Future<int> size() async {
    if (_isar == null) init();
    return _isar!.collection<Expense>().count();
  }

  static Future<void> put(Expense user) async {
    var isar = await TransacationsDatabase.isar();
    await isar!.writeTxn(() async {
      await TransacationsDatabase.database().then((db) => db!.put(user));
    });
  }

  static Future<void> putAll(List<Expense> userList) async {
    var isar = await TransacationsDatabase.isar();
    await isar!.writeTxn(() => isar.expenses.putAll(userList));
  }

  static Future<void> delete(Expense user) async {
    var isar = await TransacationsDatabase.isar();
    await isar!.writeTxn(() async => await isar.expenses.delete(user.isarId));
  }

  static Future<void> deleteAll() async {
    var isar = await TransacationsDatabase.isar();
    await isar!.writeTxn(() async => await isar.expenses.clear());
  }
}
