import 'package:drift/drift.dart';

import 'category.dart';
import 'user.dart';

@DataClassName('Budget')
class Budgets extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userId => integer().references(Users, #id)();
  IntColumn get categoryId => integer().references(Categories, #id)();
  RealColumn get limitAmount => real()();
  RealColumn get spentAmount => real().withDefault(Constant(0.0))();

  DateTimeColumn get startDate => dateTime()(); 
  DateTimeColumn get endDate => dateTime()(); 

  // 1: weekly, 2: monthly, 3: yearly
  IntColumn get period => integer()();

  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}