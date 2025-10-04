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

  int _currentYear = DateTime.now().year;
  int _currentMonth = DateTime.now().month;
  String _currentSearchQuery = '';

  TransactionBloc(
    this.getAllTransactions,
    this.getTransaction,
    this.insertTransaction,
    this.updateTransaction,
    this.deleteTransaction,
  ) : super(TransactionLoading()) {
    on<GetAllTransactionsEvent>(_onGetAllTransactionsEvent);
    on<InsertTransactionEvent>(_onInsertTransactionEvent);
    on<UpdateTransactionEvent>(_onUpdateTransactionEvent);
    on<DeleteTransactionEvent>(_onDeleteTransactionEvent);
  }

  Future<void> _onGetAllTransactionsEvent(
    GetAllTransactionsEvent event,
    Emitter<TransactionState> emit,
  ) async {
    emit(TransactionLoading());
    _currentYear = event.year ?? _currentYear;
    _currentMonth = event.month ?? _currentMonth;
    _currentSearchQuery = event.searchQuery ?? _currentSearchQuery;

    final result = await getAllTransactions.execute(
      _currentYear, _currentMonth, _currentSearchQuery,
    );

    result.fold(
      (failure) => emit(TransactionLoadError(failure.message)),
      (transactions) => emit(TransactionLoaded(transactions)),
    );
  }
  
  Future<void> _onInsertTransactionEvent(
    InsertTransactionEvent event, Emitter<TransactionState> emit,
  ) async {

    final result = await insertTransaction.execute(event.transaction);
    result.fold(
      (failure) => emit(TransactionLoadError(failure.message)),
      (_) {

        add(GetAllTransactionsEvent());
      },
    );
  }

  Future<void> _onUpdateTransactionEvent(
    UpdateTransactionEvent event, Emitter<TransactionState> emit,
  ) async {
    final result = await updateTransaction.execute(event.transaction);
    result.fold(
      (failure) => emit(TransactionLoadError(failure.message)),
      (_) {

        add(GetAllTransactionsEvent());
      },
    );
  }

  Future<void> _onDeleteTransactionEvent(
    DeleteTransactionEvent event, Emitter<TransactionState> emit,
  ) async {
    final result = await deleteTransaction.execute(event.id);
    result.fold(
      (failure) => emit(TransactionLoadError(failure.message)),
      (_) {
 
        add(GetAllTransactionsEvent());
      },
    );
  }
}