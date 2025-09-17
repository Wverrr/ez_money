part of 'transaction_bloc.dart';

abstract class TransactionState extends Equatable {
  const TransactionState();  

  @override
  List<Object> get props => [];
}
class TransactionLoading extends TransactionState {}

class TransactionEmpty extends TransactionState {}

class TransactionLoaded extends TransactionState {
  final List<TransactionEntity> transactions;

  const TransactionLoaded(this.transactions);

  @override
  List<Object> get props => [transactions];
}

class TransactionLoadError extends TransactionState {
  final String message;

  const TransactionLoadError(this.message);

  @override
  List<Object> get props => [message];
}

class TransactionActionSuccess extends TransactionState {
  final String message;

  const TransactionActionSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class TransactionActionError extends TransactionState {
  final String message;

  const TransactionActionError(this.message);

  @override
  List<Object> get props => [message];
}

class TransactionTypeChanged extends TransactionState {
  final TransactionType type;

  const TransactionTypeChanged(this.type);

  @override
  List<Object> get props => [type];
}
