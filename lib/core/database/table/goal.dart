import 'package:drift/drift.dart';

import 'user.dart';

@DataClassName('Goal')
class Goals extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userId => integer().references(Users, #id)();
  TextColumn get name => text().withLength(min: 3, max: 50)();
  
  RealColumn get targetAmount => real()();
  RealColumn get savedAmount => real().withDefault(Constant(0.0))();

  DateTimeColumn get deadline => dateTime().nullable()();
  // 1: Active, 2: Completed
  IntColumn get status => integer()();

  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}