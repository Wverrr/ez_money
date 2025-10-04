import 'package:equatable/equatable.dart';


class TrainRecordEntity extends Equatable {
  final double basicNeeds;
  final double secondaryNeeds;
  final double debts;
  final double savings;
  final double income;
  final double totalExpense;

  const TrainRecordEntity({
    required this.basicNeeds,
    required this.secondaryNeeds,
    required this.debts,
    required this.savings,
    required this.income,
    required this.totalExpense,
  });
  
  @override
  List<Object?> get props => [
        basicNeeds,
        secondaryNeeds,
        debts,
        savings,
        income,
        totalExpense,
      ];

  }

class TrainRequestEntity {
  final int userId;
  final List<TrainRecordEntity> data;

  const TrainRequestEntity({required this.userId, required this.data});
}

class TrainResponseEntity extends Equatable {
  final String message;
  final int userId;
  final double r2Score;
  final Map<String, dynamic> analysis;

  const TrainResponseEntity({
    required this.message,
    required this.userId,
    required this.r2Score,
    required this.analysis,
  });

  factory TrainResponseEntity.fromJson(Map<String, dynamic> json) {
    return TrainResponseEntity(
      message: json['message'] ?? '',
      userId: json['user_id'] ?? 0,
      r2Score: (json['r2_score'] ?? 0).toDouble(),
      analysis: Map<String, dynamic>.from(json['analysis'] ?? {}),
    );
  }
  
  @override
  List<Object?> get props => [message, userId, r2Score, analysis];
}