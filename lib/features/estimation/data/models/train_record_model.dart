import '../../domain/entities/train_record_entity.dart';

class TrainRecordModel extends TrainRecordEntity {
  const TrainRecordModel({
    required super.income,
    required super.basicNeeds,
    required super.secondaryNeeds,
    required super.debts,
    required super.savings,
    required super.totalExpense,
  });

  factory TrainRecordModel.fromEntity(TrainRecordEntity e) => TrainRecordModel(
    income: e.income,
    basicNeeds: e.basicNeeds,
    secondaryNeeds: e.secondaryNeeds,
    debts: e.debts,
    savings: e.savings,
    totalExpense: e.totalExpense,
  );

  Map<String, dynamic> toJson() => {
    "income": income,
    "basic_needs": basicNeeds,
    "secondary_needs": secondaryNeeds,
    "debt": debts,
    "savings": savings,
    "total_expense": totalExpense,
  };

  factory TrainRecordModel.fromJson(Map<String, dynamic> json) {
    return TrainRecordModel(
      income: json["income"],
      basicNeeds: json["basic_needs"],
      secondaryNeeds: json["secondary_needs"],
      debts: json["debt"],
      savings: json["savings"],
      totalExpense: json["total_expense"],
    );
  }
}

class TrainRequestModel extends TrainRequestEntity {
  const TrainRequestModel({required super.userId, required super.data});

  factory TrainRequestModel.fromEntity(TrainRequestEntity e) =>
      TrainRequestModel(userId: e.userId, data: e.data);

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "data": data
        .map((entity) => TrainRecordModel.fromEntity(entity).toJson())
        .toList(),
  };
}

class TrainResponseModel extends TrainResponseEntity {
  const TrainResponseModel({
    required super.message,
    required super.userId,
    required super.r2Score,
    required super.analysis,
  });

  factory TrainResponseModel.fromEntity(TrainResponseEntity e) =>
      TrainResponseModel(
        message: e.message,
        userId: e.userId,
        r2Score: e.r2Score,
        analysis: e.analysis,
      );

  Map<String, dynamic> toJson() => {
    "message": message,
    "user_id": userId,
    "r2_score": r2Score,
    "analysis": analysis,
  };

  factory TrainResponseModel.fromJson(Map<String, dynamic> json) {
    return TrainResponseModel(
      message: json["message"],
      userId: json["user_id"],
      r2Score: json["r2_score"],
      analysis: json["analysis"],
    );
  }
}
