import '../../../../../core/database/database.dart';
import '../../models/debt_model.dart';

abstract class DebtLocalDataSource {
  Future<List<DebtModel>> getAllDebts();
  Future<DebtModel> getDebt(int id);
  Future<void> insertDebt(DebtModel debt);
  Future<void> updateDebt(DebtModel debt);
  Future<void> deleteDebt(int id);
}

class DebtLocalDataSourceImpl implements DebtLocalDataSource {
  final AppDb db;

  DebtLocalDataSourceImpl(this.db);

  @override
  Future<List<DebtModel>> getAllDebts() async {
    final result = await db.select(db.debts).get();
    return result.map(DebtModel.fromDb).toList();
  }

  @override
  Future<DebtModel> getDebt(int id) async {
    final result = await (db.select(db.debts)..where((tbl) => tbl.id.equals(id))).getSingle();
    return DebtModel.fromDb(result);
  }

  @override
  Future<void> insertDebt(DebtModel debt) async {
    await db.into(db.debts).insert(debt.toCompanion(isInsert: true));
  }

  @override
  Future<void> updateDebt(DebtModel debt) async {
    await (db.update(db.debts)..where((tbl) => tbl.id.equals(debt.id))).write(debt.toCompanion());
  }

  @override
  Future<void> deleteDebt(int id) async {
    await (db.delete(db.debts)..where((tbl) => tbl.id.equals(id))).go();
  }
}

