import 'package:drift/drift.dart';

import '../../../../core/database/database.dart';
import '../../domain/entities/transaction_entity.dart';

class TransactionModel extends TransactionEntity {
  const TransactionModel({
    required super.id,
    required super.userId,
    super.categoryId,
    super.savingsId,
    super.debtId,
    required super.amount,
    required super.type,
    super.description,
    required super.date,
    required super.createdAt,
    required super.updatedAt,
  });

  /// 🔁 From Drift Table (Transaction)
  factory TransactionModel.fromDb(Transaction txn) {
    return TransactionModel(
      id: txn.id,
      userId: txn.userId,
      categoryId: txn.categoryId,
      savingsId: txn.savingsId,
      debtId: txn.debtId,
      amount: txn.amount,
      type: txn.type,
      description: txn.description,
      date: txn.date,
      createdAt: txn.createdAt,
      updatedAt: txn.updatedAt,

    );
  }

  /// 🔁 To Drift Companion (for insert/update)
  TransactionsCompanion toCompanion({bool isInsert = false}) {
    return TransactionsCompanion(
      id: isInsert ? const Value.absent() : Value(id!),
      userId: Value(userId),
      categoryId: Value(categoryId),
      savingsId: Value(savingsId),
      debtId: Value(debtId),
      amount: Value(amount),
      type: Value(type),
      description: Value(description),
      date: Value(date),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  /// 🔁 From Entity
  factory TransactionModel.fromEntity(TransactionEntity entity) {
    return TransactionModel(
      id: entity.id,
      userId: entity.userId,
      categoryId: entity.categoryId,
      savingsId: entity.savingsId,
      debtId: entity.debtId,
      amount: entity.amount,
      type: entity.type,
      description: entity.description,
      date: entity.date,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
}
