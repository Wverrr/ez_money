import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'table/category.dart';
import 'table/transaction.dart';
import 'table/user.dart';
import 'table/saving.dart';
import 'table/debt.dart';
import 'table/recurring_transaction.dart';
import 'table/budget.dart';
import 'table/goal.dart';
import 'table/reminder.dart';

part 'database.g.dart';

@DriftDatabase(tables: [
  Users, Transactions, Categories,
  Savings, Debts, RecurringTransactions,
  Budgets, Goals, Reminders,
  ])
class AppDb extends _$AppDb {
  AppDb() : super(_openConnection());

  @override
  int get schemaVersion => 1;

}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));

    return NativeDatabase.createInBackground(file);
  });
}