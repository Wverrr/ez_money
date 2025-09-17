part of 'estimation_bloc.dart';

abstract class EstimationState extends Equatable {
  const EstimationState();

  @override
  List<Object> get props => [];
}

class EstimationInitial extends EstimationState {}

class EstimationLoading extends EstimationState {}

class EstimationLoaded extends EstimationState {
  final EstimationResponseEntity estimation;

  const EstimationLoaded({required this.estimation});

  @override
  List<Object> get props => [estimation];
}

class EstimationError extends EstimationState {
  final String message;

  const EstimationError(this.message);

  @override
  List<Object> get props => [message];
}


