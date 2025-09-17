import 'package:drift/drift.dart';

import '../../../../../core/database/database.dart';
import '../../../../category/data/models/category_model.dart';
import '../../../../user/data/models/user_model.dart';
import '../../models/transaction_model.dart';
import '../../models/transaction_with_relations_model.dart';

abstract class TransactionLocalDataSource {
  Future<List<TransactionWithRelationsModel>> getAllTransactions();
  Future<TransactionModel> getTransaction(int id);
  Future<void> insertTransaction(TransactionModel transaction);
  Future<void> updateTransaction(TransactionModel transaction);
  Future<void> deleteTransaction(int id);
}

class TransactionLocalDataSourceImpl implements TransactionLocalDataSource {
  final AppDb database;

  TransactionLocalDataSourceImpl(this.database);

  // @override
  // Future<List<TransactionModel>> getAllTransactions() async {
  //   final transactions = await database.select(database.transactions).get();
  //   return transactions.map((t) => TransactionModel.fromDb(t)).toList();
  // }

  @override
  Future<List<TransactionWithRelationsModel>> getAllTransactions() async {
    final query = database.select(database.transactions).join([
      leftOuterJoin(
        database.users,
        database.users.id.equalsExp(database.transactions.userId),
      ),
      leftOuterJoin(
        database.categories,
        database.categories.id.equalsExp(database.transactions.categoryId),
      ),
      leftOuterJoin(
        database.savings,
        database.savings.id.equalsExp(database.transactions.savingsId),
      ),
      leftOuterJoin(
        database.debts,
        database.debts.id.equalsExp(database.transactions.debtId),
      ),
    ]);

    final rows = await query.get();

    return rows.map((row) {
      final user = row.readTable(database.users);
      final transaction = row.readTable(database.transactions);
      final category = row.readTableOrNull(database.categories);
      // final savings = row.readTableOrNull(database.savings);
      // final debt = row.readTableOrNull(database.debts);

      return TransactionWithRelationsModel(
        user: UserModel.fromDb(user),
        transaction: TransactionModel.fromDb(transaction),
        category: category != null ? CategoryModel.fromDb(category) : null,
        // savings: savings != null ? SavingsModel.fromDb(savings) : null,
        // debt: debt != null ? DebtModel.fromDb(debt) : null,
      );
    }).toList();
  }

  @override
  Future<TransactionModel> getTransaction(int id) async {
    final transaction =
        await (database.select(database.transactions)
          ..where((tbl) => tbl.id.equals(id))).getSingle();
    return TransactionModel.fromDb(transaction);
  }

  @override
  Future<void> insertTransaction(TransactionModel transaction) async {
    await database.transaction(() async {
      // Insert transaksi
      await database
          .into(database.transactions)
          .insert(transaction.toCompanion(isInsert: true));

      final userId = transaction.userId;
      final amount = transaction.amount;
      final type = transaction.type;

      // Ambil user
      final user =
          await (database.select(database.users)
            ..where((tbl) => tbl.id.equals(userId))).getSingle();

      double updatedBalance = user.balance;

      if (type == 1) {
        // Income
        updatedBalance += amount;
      } else if (type == 2) {
        // Expense
        updatedBalance -= amount;
      } else if (type == 3) {
        // Saving (tabungan)
        if (transaction.savingsId != null) {
          // Ambil saving
          final saving =
              await (database.select(database.savings)..where(
                (tbl) => tbl.id.equals(transaction.savingsId!),
              )).getSingle();

          // Update saving.currentAmount
          await (database.update(database.savings)
            ..where((tbl) => tbl.id.equals(saving.id))).write(
            SavingsCompanion(
              currentAmount: Value(saving.currentAmount + amount),
              updatedAt: Value(DateTime.now()),
            ),
          );

          // Kurangi saldo user
          updatedBalance -= amount;
        }
      } else if (type == 4) {
        // Debt (utang)
        if (transaction.debtId != null) {
          // Ambil debt
          final debt =
              await (database.select(database.debts)..where(
                (tbl) => tbl.id.equals(transaction.debtId!),
              )).getSingle();

          // Update debt.paidAmount
          await (database.update(database.debts)
            ..where((tbl) => tbl.id.equals(debt.id))).write(
            DebtsCompanion(
              paidAmount: Value(debt.paidAmount + amount),
              updatedAt: Value(DateTime.now()),
            ),
          );

          // Kurangi saldo user
          updatedBalance -= amount;
        }
      }

      // Update saldo user
      await (database.update(database.users)
        ..where((tbl) => tbl.id.equals(userId))).write(
        UsersCompanion(
          balance: Value(updatedBalance),
          updatedAt: Value(DateTime.now()),
        ),
      );
    });
  }

  @override
  Future<void> updateTransaction(TransactionModel transaction) async {
    await (database.update(database.transactions)..where(
      (tbl) => tbl.id.equals(transaction.id),
    )).write(transaction.toCompanion());
  }

  @override
  Future<void> deleteTransaction(int id) async {
    await (database.delete(database.transactions)
      ..where((tbl) => tbl.id.equals(id))).go();
  }
}
