import 'package:equatable/equatable.dart';

class EstimationRequestEntity extends Equatable {
  final int userId;
  final double basicNeeds;
  final double secondaryNeeds;
  final double debts;
  final double savings;
  final double income;

  const EstimationRequestEntity({
    required this.userId,
    required this.basicNeeds,
    required this.secondaryNeeds,
    required this.debts,
    required this.savings,
    required this.income,
  });

  @override
  List<Object> get props => [
    userId,
    basicNeeds,
    secondaryNeeds,
    debts,
    savings,
    income,
  ];
}

class EstimationResponseEntity extends Equatable {
  final int userId;
  final double estimatedExpense;
  final Map<String, dynamic> analysis;

  const EstimationResponseEntity({
    required this.userId,
    required this.estimatedExpense,
    required this.analysis,
  });

  @override
  List<Object?> get props => [userId, estimatedExpense, analysis];
}
