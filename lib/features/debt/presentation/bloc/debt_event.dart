part of 'debt_bloc.dart';

abstract class DebtEvent extends Equatable {
  const DebtEvent();

  @override
  List<Object> get props => [];
}

class GetAllDebtsEvent extends DebtEvent {

  const GetAllDebtsEvent();

  @override
  List<Object> get props => [];
}

class GetDebtEvent extends DebtEvent {
  final int id;

  const GetDebtEvent(this.id);

  @override
  List<Object> get props => [id];
}

class InsertDebtEvent extends DebtEvent {
  final DebtEntity debt;

  const InsertDebtEvent(this.debt);

  @override
  List<Object> get props => [debt];
}

class UpdateDebtEvent extends DebtEvent {
  final DebtEntity debt;

  const UpdateDebtEvent(this.debt);

  @override
  List<Object> get props => [debt];
}

class DeleteDebtEvent extends DebtEvent {
  final int id;

  const DeleteDebtEvent(this.id);

  @override
  List<Object> get props => [id];
}

