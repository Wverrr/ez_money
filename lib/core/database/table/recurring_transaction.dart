import 'package:drift/drift.dart';

import 'category.dart';
import 'user.dart';

@DataClassName('RecurringTransaction')
class RecurringTransactions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userId => integer().references(Users, #id)();
  IntColumn get categoryId => integer().nullable().references(Categories, #id)();
  RealColumn get amount => real()();
  // 1: Income, 2: Expense, 3: Saving, 4: Debt
  IntColumn get type => integer()();

  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get nextDate => dateTime()();

  // Periode pengulangan (1: daily, 2: weekly, 3: monthly, 4: yearly)
  IntColumn get frequency => integer()();
  IntColumn get frequencyInterval => integer().nullable().withDefault(Constant(1))();
  TextColumn get frequencyDetail => text().nullable()();

  TextColumn get description => text().nullable()();
  BoolColumn get isActive => boolean().withDefault(Constant(true))();

  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}