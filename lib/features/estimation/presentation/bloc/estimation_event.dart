part of 'estimation_bloc.dart';

abstract class EstimationEvent extends Equatable {
  const EstimationEvent();

  @override
  List<Object> get props => [];
}

class TrainEstimationEvent extends EstimationEvent {
  final TrainRequestEntity request;

  const TrainEstimationEvent(this.request);

  @override
  List<Object> get props => [request];
}

class EstimateExpenseEvent extends EstimationEvent {
  final EstimationRequestEntity request;

  const EstimateExpenseEvent(this.request);

  @override
  List<Object> get props => [request];
}