part of 'saving_bloc.dart';

abstract class SavingState extends Equatable {
  const SavingState();  

  @override
  List<Object> get props => [];
}

class SavingLoading extends SavingState {}

class SavingEmpty extends SavingState {}

class SavingLoaded extends SavingState {
  final List<SavingEntity> savings;

  const SavingLoaded(this.savings);

  @override
  List<Object> get props => [savings];
}

class SavingError extends SavingState {
  final String message;

  const SavingError(this.message);

  @override
  List<Object> get props => [message];
}

class SavingActionSuccess extends SavingState {
  final String message;

  const SavingActionSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class SavingActionError extends SavingState {
  final String message;

  const SavingActionError(this.message);

  @override
  List<Object> get props => [message];
}
