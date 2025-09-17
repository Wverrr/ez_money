import 'package:drift/drift.dart';

import 'user.dart';

@DataClassName('Debt')
class Debts extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userId => integer().references(Users, #id)();
  TextColumn get name => text().withLength(min: 3, max: 50)();

  RealColumn get totalAmount => real()();
  RealColumn get paidAmount => real().withDefault(Constant(0.0))();
  
  DateTimeColumn get dueDate => dateTime()();
  IntColumn get status => integer()(); // 1: Active, 2: Completed

  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}