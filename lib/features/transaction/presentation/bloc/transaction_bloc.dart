import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/transaction_entity.dart';
import '../../domain/usecases/delete_transaction.dart';
import '../../domain/usecases/get_all_transactions.dart';
import '../../domain/usecases/get_transaction.dart';
import '../../domain/usecases/insert_transaction.dart';
import '../../domain/usecases/update_transaction.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

enum TransactionType { pemasukan, pengeluaran, tabungan, hutang }

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final GetAllTransactions getAllTransactions;
  final GetTransaction getTransaction;
  final InsertTransaction insertTransaction;
  final UpdateTransaction updateTransaction;
  final DeleteTransaction deleteTransaction;

  TransactionBloc(
    this.getAllTransactions,
    this.getTransaction,
    this.insertTransaction,
    this.updateTransaction,
    this.deleteTransaction,
  ) : super(TransactionLoading()) {
    on<GetAllTransactionsEvent>(_onGetAllTransactionsEvent);
    on<GetTransactionEvent>(_onGetTransactionEvent);
    on<InsertTransactionEvent>(_onInsertTransactionEvent);
    on<UpdateTransactionEvent>(_onUpdateTransactionEvent);
    on<DeleteTransactionEvent>(_onDeleteTransactionEvent);

    on<ChangeTransactionTypeEvent>(_onChangeTransactionTypeEvent);
  }

  Future<void> _onGetAllTransactionsEvent(
    GetAllTransactionsEvent event,
    Emitter<TransactionState> emit,
  ) async {
    emit(TransactionLoading());

    final result = await getAllTransactions.execute();

    result.fold((failure) => emit(TransactionLoadError(failure.message)), (
      transactions,
    ) {
      if (transactions.isEmpty) {
        emit(TransactionEmpty());
      } else {
        emit(TransactionLoaded(transactions));
      }
    });
  }

  Future<void> _onGetTransactionEvent(
    GetTransactionEvent event,
    Emitter<TransactionState> emit,
  ) async {
    emit(TransactionLoading());

    final result = await getTransaction.execute(event.id);

    result.fold(
      (failure) => emit(TransactionLoadError(failure.message)),
      (transaction) => emit(TransactionLoaded([transaction])),
    );
  }

  Future<void> _onInsertTransactionEvent(
    InsertTransactionEvent event,
    Emitter<TransactionState> emit,
  ) async {
    emit(TransactionLoading());

    final result = await insertTransaction.execute(event.transaction);

    result.fold(
      (failure) => emit(TransactionActionError(failure.message)),
      (_) =>
          emit(TransactionActionSuccess('Transaction inserted successfully')),
    );
  }

  Future<void> _onUpdateTransactionEvent(
    UpdateTransactionEvent event,
    Emitter<TransactionState> emit,
  ) async {
    emit(TransactionLoading());

    final result = await updateTransaction.execute(event.transaction);

    result.fold(
      (failure) => emit(TransactionActionError(failure.message)),
      (_) => emit(TransactionActionSuccess('Transaction updated successfully')),
    );
  }

  Future<void> _onDeleteTransactionEvent(
    DeleteTransactionEvent event,
    Emitter<TransactionState> emit,
  ) async {
    emit(TransactionLoading());

    final result = await deleteTransaction.execute(event.id);

    result.fold(
      (failure) => emit(TransactionActionError(failure.message)),
      (_) => emit(TransactionActionSuccess('Transaction deleted successfully')),
    );
  }

  Future<void> _onChangeTransactionTypeEvent(
    ChangeTransactionTypeEvent event,
    Emitter<TransactionState> emit,
  ) async {
    emit(TransactionTypeChanged(event.type));
    
  }
}
