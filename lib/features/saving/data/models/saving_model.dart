import 'package:drift/drift.dart';

import '../../../../core/database/database.dart';
import '../../domain/entities/saving_entity.dart';

class SavingModel extends SavingEntity{
  SavingModel({
    required super.id, 
    required super.userId, 
    required super.name, 
    required super.targetAmount, 
    required super.currentAmount, 
    required super.status, 
    required super.createdAt, 
    required super.updatedAt
    });

  factory SavingModel.fromDb(Saving saving) {
    return SavingModel(
      id: saving.id,
      userId: saving.userId,
      name: saving.name,
      targetAmount: saving.targetAmount,
      currentAmount: saving.currentAmount,
      status: saving.status,
      createdAt: saving.createdAt,
      updatedAt: saving.updatedAt,
    );
  }

  SavingsCompanion toCompanion({bool isInsert = false}) {
    return SavingsCompanion(
      id: isInsert ? const Value.absent() : Value(id),
      userId: Value(userId),
      name: Value(name),
      targetAmount: Value(targetAmount),
      currentAmount: Value(currentAmount),
      status: Value(status),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory SavingModel.fromEntity(SavingEntity entity) {
    return SavingModel(
      id: entity.id,
      userId: entity.userId,
      name: entity.name,
      targetAmount: entity.targetAmount,
      currentAmount: entity.currentAmount,
      status: entity.status,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

}