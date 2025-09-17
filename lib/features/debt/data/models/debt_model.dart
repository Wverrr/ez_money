
import 'package:drift/drift.dart';

import '../../../../core/database/database.dart';
import '../../domain/entities/debt_entity.dart';

class DebtModel extends DebtEntity {
  const DebtModel({
    required super.id,
    required super.userId,
    required super.name,
    required super.totalAmount,
    required super.paidAmount,
    required super.dueDate,
    required super.status,
    required super.createdAt,
    required super.updatedAt,
  });

  factory DebtModel.fromDb(Debt debt) => DebtModel(
        id: debt.id,
        userId: debt.userId,
        name: debt.name,
        totalAmount: debt.totalAmount,
        paidAmount: debt.paidAmount,
        dueDate: debt.dueDate,
        status: debt.status,
        createdAt: debt.createdAt,
        updatedAt: debt.updatedAt,
      );

  DebtsCompanion toCompanion({bool isInsert = false}) => DebtsCompanion(
        id: isInsert ? const Value.absent() : Value(id),
        userId: Value(userId),
        name: Value(name),
        totalAmount: Value(totalAmount),
        paidAmount: Value(paidAmount),
        dueDate: Value(dueDate),
        status: Value(status),
        createdAt: Value(createdAt),
        updatedAt: Value(updatedAt),
      );

  factory DebtModel.fromEntity(DebtEntity entity) => DebtModel(
        id: entity.id,
        userId: entity.userId,
        name: entity.name,
        totalAmount: entity.totalAmount,
        paidAmount: entity.paidAmount,
        dueDate: entity.dueDate,
        status: entity.status,
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt,
      );
}
