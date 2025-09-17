import 'package:drift/drift.dart';

import 'category.dart';
import 'debt.dart';
import 'saving.dart';
import 'user.dart';


@DataClassName('Transaction')
class Transactions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userId => integer().references(Users, #id)();
  IntColumn get categoryId => integer().nullable().references(Categories, #id)();
  IntColumn get savingsId => integer().nullable().references(Savings, #id)();
  IntColumn get debtId => integer().nullable().references(Debts, #id)();

  RealColumn get amount => real()();
  // 1: Income, 2: Expense, 3: Saving, 4: Debt
  IntColumn get type => integer()();
  TextColumn get description => text().nullable()();
  
  DateTimeColumn get date => dateTime()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}