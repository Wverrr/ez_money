import 'package:drift/drift.dart';

import 'user.dart';

@DataClassName('Saving')
class Savings extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userId => integer().references(Users, #id)();
  TextColumn get name => text().withLength(min: 3, max: 50)();
  
  RealColumn get targetAmount => real()();
  RealColumn get currentAmount => real().withDefault(Constant(0.0))();
  IntColumn get status => integer()(); // 1: Active, 2: Completed

  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}