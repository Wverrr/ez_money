import '../../../category/data/models/category_model.dart';
import '../../../user/data/models/user_model.dart';
import '../../domain/entities/transaction_entity.dart';
import 'transaction_model.dart';

class TransactionWithRelationsModel {
  final UserModel user;
  final TransactionModel transaction;
  final CategoryModel? category;
  // final SavingsModel? savings;
  // final DebtModel? debt;

  TransactionWithRelationsModel({
    required this.user,
    required this.transaction,
    this.category,
    // this.savings,
    // this.debt,
  });

  TransactionEntity toEntity() {
    return TransactionEntity(
      id: transaction.id,
      userId: transaction.userId,
      categoryId: transaction.categoryId,
      savingsId: transaction.savingsId,
      debtId: transaction.debtId,
      amount: transaction.amount,
      type: transaction.type,
      description: transaction.description,
      date: transaction.date,
      createdAt: transaction.createdAt,
      updatedAt: transaction.updatedAt,
      user: user,
      category: category,
      // savings: savings,
      // debt: debt,
    );
  }
}
