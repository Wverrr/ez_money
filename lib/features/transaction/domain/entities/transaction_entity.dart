import 'package:equatable/equatable.dart';

import '../../../category/domain/entities/category_entity.dart';
import '../../../user/domain/entities/user_entity.dart';

class TransactionEntity extends Equatable {
  final int? id;
  final int userId;
  final int? categoryId;
  final int? savingsId;
  final int? debtId;
  final double amount;
  final int type; // 1: Income, 2: Expense, 3: Saving, 4: Debt
  final String? description;
  final DateTime date;
  final DateTime createdAt;
  final DateTime updatedAt;

  // Optional Relationships
  final UserEntity? user;
  final CategoryEntity? category;
  // final SavingsEntity? savings;
  // final DebtEntity? debt;  


  const TransactionEntity({
    this.id,
    required this.userId,
    this.categoryId,
    this.savingsId,
    this.debtId,
    required this.amount,
    required this.type,
    this.description,
    required this.date,
    required this.createdAt,
    required this.updatedAt,

    this.user, 
    this.category
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        categoryId,
        savingsId,
        debtId,
        amount,
        type,
        description,
        date,
        createdAt,
        updatedAt,
        user,
        category,
        // savings,
        // debt,
      ];
}
