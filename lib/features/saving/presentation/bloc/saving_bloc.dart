import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/saving_entity.dart';
import '../../domain/usecases/delete_saving.dart';
import '../../domain/usecases/get_all_savings.dart';
import '../../domain/usecases/get_saving.dart';
import '../../domain/usecases/insert_saving.dart';
import '../../domain/usecases/update_saving.dart';

part 'saving_event.dart';
part 'saving_state.dart';

class SavingBloc extends Bloc<SavingEvent, SavingState> {
  final GetAllSavings getAllSavings;
  final GetSaving getSaving;
  final InsertSaving insertSaving;
  final UpdateSaving updateSaving;
  final DeleteSaving deleteSaving;

  SavingBloc(
    this.getAllSavings,
    this.getSaving,
    this.insertSaving,
    this.updateSaving,
    this.deleteSaving,

  ) : super(SavingLoading()) {
    on<GetAllSavingsEvent>(_onGetAllSavingsEvent);
    on<GetSavingEvent>(_onGetSavingEvent);
    on<InsertSavingEvent>(_onInsertSavingEvent);
    on<UpdateSavingEvent>(_onUpdateSavingEvent);
    on<DeleteSavingEvent>(_onDeleteSavingEvent);
  }

  Future<void> _onGetAllSavingsEvent(
      GetAllSavingsEvent event, Emitter<SavingState> emit) async {
    emit(SavingLoading());
    final result = await getAllSavings.execute();
    result.fold(
      (failure) => emit(SavingError(failure.message)),
      (savings) => savings.isEmpty ? emit(SavingEmpty()) : emit(SavingLoaded(savings)),
    );
  }
  
  Future<void> _onGetSavingEvent(
      GetSavingEvent event, Emitter<SavingState> emit) async {
    emit(SavingLoading());
    final result = await getSaving.execute(event.id);
    result.fold(
      (failure) => emit(SavingError(failure.message)),
      (saving) => emit(SavingLoaded([saving])),
    );
  }

  Future<void> _onInsertSavingEvent(
      InsertSavingEvent event, Emitter<SavingState> emit) async {
    emit(SavingLoading());
    final result = await insertSaving.execute(event.saving);
    result.fold(
      (failure) => emit(SavingError(failure.message)),
      (_) => add(GetAllSavingsEvent()),
    );
  }

  Future<void> _onUpdateSavingEvent(
      UpdateSavingEvent event, Emitter<SavingState> emit) async {
    emit(SavingLoading());
    final result = await updateSaving.execute(event.saving);
    result.fold(
      (failure) => emit(SavingError(failure.message)),
      (_) => add(GetAllSavingsEvent()),
    );
  }

  Future<void> _onDeleteSavingEvent(
      DeleteSavingEvent event, Emitter<SavingState> emit) async {
    emit(SavingLoading());
    final result = await deleteSaving.execute(event.id);
    result.fold(
      (failure) => emit(SavingError(failure.message)),
      (_) => add(GetAllSavingsEvent()),
    );
  }
}
