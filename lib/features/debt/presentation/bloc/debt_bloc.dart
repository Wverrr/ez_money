import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/debt_entity.dart';
import '../../domain/usecases/delete_debt.dart';
import '../../domain/usecases/get_all_debts.dart';
import '../../domain/usecases/get_debt.dart';
import '../../domain/usecases/insert_debt.dart';
import '../../domain/usecases/update_debt.dart';

part 'debt_event.dart';
part 'debt_state.dart';

class DebtBloc extends Bloc<DebtEvent, DebtState> {
  final GetAllDebts getAllDebts;
  final GetDebt getDebt;
  final InsertDebt insertDebt;
  final UpdateDebt updateDebt;
  final DeleteDebt deleteDebt;

  DebtBloc(
    this.getAllDebts,
    this.getDebt,
    this.insertDebt,
    this.updateDebt,
    this.deleteDebt,
  ) : super(DebtLoading()) {
    on<GetAllDebtsEvent>(_onGetAllDebtsEvent);
    on<GetDebtEvent>(_onGetDebtEvent);
    on<InsertDebtEvent>(_onInsertDebtEvent);
    on<UpdateDebtEvent>(_onUpdateDebtEvent);
    on<DeleteDebtEvent>(_onDeleteDebtEvent);
  }

  Future<void> _onGetAllDebtsEvent(
    GetAllDebtsEvent event,
    Emitter<DebtState> emit,
  ) async {
    emit(DebtLoading());
    final result = await getAllDebts.execute();
    result.fold(
      (failure) => emit(DebtError(failure.message)),
      (debts) => debts.isEmpty ? emit(DebtEmpty()) : emit(DebtLoaded(debts)),
    );
  }

  Future<void> _onGetDebtEvent(
    GetDebtEvent event,
    Emitter<DebtState> emit,
  ) async {
    emit(DebtLoading());
    final result = await getDebt.execute(event.id);
    result.fold(
      (failure) => emit(DebtError(failure.message)),
      (debt) => emit(DebtLoaded([debt])),
    );
  }

  Future<void> _onInsertDebtEvent(
    InsertDebtEvent event,
    Emitter<DebtState> emit,
  ) async {
    emit(DebtLoading());
    final result = await insertDebt.execute(event.debt);
    result.fold(
      (failure) => emit(DebtError(failure.message)),
      (_) => add(GetAllDebtsEvent()), // Refresh list
    );
  }

  Future<void> _onUpdateDebtEvent(
    UpdateDebtEvent event,
    Emitter<DebtState> emit,
  ) async {
    emit(DebtLoading());
    final result = await updateDebt.execute(event.debt);
    result.fold(
      (failure) => emit(DebtError(failure.message)),
      (_) => add(GetAllDebtsEvent()), // Refresh list
    );
  }

  Future<void> _onDeleteDebtEvent(
    DeleteDebtEvent event,
    Emitter<DebtState> emit,
  ) async {
    emit(DebtLoading());
    final result = await deleteDebt.execute(event.id);
    result.fold(
      (failure) => emit(DebtError(failure.message)),
      (_) => add(GetAllDebtsEvent()), // Refresh list
    );
  }
}
