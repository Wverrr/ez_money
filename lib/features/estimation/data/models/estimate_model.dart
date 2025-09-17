import '../../domain/entities/estimation_entity.dart';

class EstimationRequestModel extends EstimationRequestEntity {
  const EstimationRequestModel({
    required super.userId,
    required super.basicNeeds,
    required super.secondaryNeeds,
    required super.debts,
    required super.savings,
    required super.income,
  });

  factory EstimationRequestModel.fromEntity(EstimationRequestEntity e) =>
      EstimationRequestModel(
        userId: e.userId,
        basicNeeds: e.basicNeeds,
        secondaryNeeds: e.secondaryNeeds,
        debts: e.debts,
        savings: e.savings,
        income: e.income,
      );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "basic_needs": basicNeeds,
    "secondary_needs": secondaryNeeds,
    "debts": debts,
    "savings": savings,
    "income": income,
  };

  factory EstimationRequestModel.fromJson(Map<String, dynamic> json) {
    return EstimationRequestModel(
      userId: json["user_id"],
      basicNeeds: json["basic_needs"],
      secondaryNeeds: json["secondary_needs"],
      debts: json["debts"],
      savings: json["savings"],
      income: json["income"],
    );
  }
}

class EstimationResponseModel extends EstimationResponseEntity {
  const EstimationResponseModel({
    required super.userId,
    required super.estimatedExpense,
    required super.analysis,
  });

  factory EstimationResponseModel.fromEntity(EstimationResponseEntity e) =>
      EstimationResponseModel(
        userId: e.userId,
        estimatedExpense: e.estimatedExpense,
        analysis: e.analysis,
      );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "estimated_expense": estimatedExpense,
    "analysis": analysis,
  };

  factory EstimationResponseModel.fromJson(Map<String, dynamic> json) {
    return EstimationResponseModel(
      userId: json["user_id"],
      estimatedExpense: json["estimated_expense"],
      analysis: json["analysis"],
    );
  }
}
