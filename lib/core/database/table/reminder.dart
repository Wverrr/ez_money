import 'package:drift/drift.dart';

import 'transaction.dart';
import 'user.dart';

@DataClassName('Reminder')
class Reminders extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userId => integer().references(Users, #id)();
  IntColumn get transactionId => integer().nullable().unique().references(Transactions, #id)();

  DateTimeColumn get reminderDate => dateTime()();
  TextColumn get note => text().nullable()();
  IntColumn get status => integer()(); // 1: Active, 2: Completed
  
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}