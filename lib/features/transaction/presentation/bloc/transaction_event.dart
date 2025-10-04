part of 'transaction_bloc.dart';

abstract class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object> get props => [];
}

class GetAllTransactionsEvent extends TransactionEvent {
  final int? year;
  final int? month;
  final String? searchQuery;

  const GetAllTransactionsEvent({
    this.year,
    this.month,
    this.searchQuery,
  });

  @override
  List<Object> get props => [year ?? 0, month ?? 0, searchQuery ?? ''];
}

class GetTransactionEvent extends TransactionEvent {
  final int id;

  const GetTransactionEvent(this.id);

  @override
  List<Object> get props => [id];
}

class InsertTransactionEvent extends TransactionEvent {
  final TransactionEntity transaction;

  const InsertTransactionEvent(this.transaction);

  @override
  List<Object> get props => [transaction];
}

class UpdateTransactionEvent extends TransactionEvent {
  final TransactionEntity transaction;

  const UpdateTransactionEvent(this.transaction);

  @override
  List<Object> get props => [transaction];
}

class DeleteTransactionEvent extends TransactionEvent {
  final int id;

  const DeleteTransactionEvent(this.id);

  @override
  List<Object> get props => [id];
}

class ChangeTransactionTypeEvent extends TransactionEvent {
  final TransactionType type;

  const ChangeTransactionTypeEvent(this.type);

  @override
  List<Object> get props => [type];
}
