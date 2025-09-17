part of 'saving_bloc.dart';

abstract class SavingEvent extends Equatable {
  const SavingEvent();

  @override
  List<Object> get props => [];
}

class GetAllSavingsEvent extends SavingEvent {}

class GetSavingEvent extends SavingEvent {
  final int id;

  const GetSavingEvent(this.id);

  @override
  List<Object> get props => [id];
}

class InsertSavingEvent extends SavingEvent {
  final SavingEntity saving;

  const InsertSavingEvent(this.saving);

  @override
  List<Object> get props => [saving];
}

class UpdateSavingEvent extends SavingEvent {
  final SavingEntity saving;

  const UpdateSavingEvent(this.saving);

  @override
  List<Object> get props => [saving];
}

class DeleteSavingEvent extends SavingEvent {
  final int id;

  const DeleteSavingEvent(this.id);

  @override
  List<Object> get props => [id];
}