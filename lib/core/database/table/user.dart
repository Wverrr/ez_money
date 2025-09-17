import 'package:drift/drift.dart';

@DataClassName('User')
class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().nullable().withLength(min: 3, max: 50)();
  RealColumn get balance => real().withDefault(Constant(0.0))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}