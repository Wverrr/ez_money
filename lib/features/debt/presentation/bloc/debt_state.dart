part of 'debt_bloc.dart';

abstract class DebtState extends Equatable {
  const DebtState();  

  @override
  List<Object> get props => [];
}

class DebtLoading extends DebtState {}

class DebtEmpty extends DebtState {}

class DebtLoaded extends DebtState {
  final List<DebtEntity> debts;

  const DebtLoaded(this.debts);

  @override
  List<Object> get props => [debts];
}

class DebtError extends DebtState {
  final String message;

  const DebtError(this.message);

  @override
  List<Object> get props => [message];
}

class DebtActionSuccess extends DebtState {
  final String message;

  const DebtActionSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class DebtActionError extends DebtState {
  final String message;

  const DebtActionError(this.message);

  @override
  List<Object> get props => [message];
}
