import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../transaction/domain/entities/transaction_entity.dart';
import '../../../transaction/domain/usecases/get_all_transactions.dart';
import '../../../user/domain/usecases/get_active_user.dart';

import '../../../user/domain/entities/user_entity.dart';
import '../../../user/domain/usecases/get_user.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetUser getUser;
  final GetAllTransactions getAllTransactions;
  // final GetLastActiveUser getLastActiveUser;

  HomeBloc(this.getUser, this.getAllTransactions) : super(HomeInitial()) {
    on<LoadHomeEvent>(_onLoadHomeEvent);
  }

  Future<void> _onLoadHomeEvent(
    LoadHomeEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());

    // final result = await getLastActiveUser.execute(event.userId);
    final userResult = await getUser.execute(event.userId);
    final transactionsResult = await getAllTransactions.execute(
      DateTime.now().year,
      DateTime.now().month,
      "",
    );

    // final results = await Future.wait([
    //   getUser.execute(event.userId),
    //   getAllTransactions.execute(DateTime.now().year, DateTime.now().month, ""),
    // ]);

    // final userResult = results[0];
    // final transactionsResult = results[1];

    // log("result: ${results.toString()}");
    userResult.fold((failure) => emit(HomeError(failure.message)), (user) {
      transactionsResult.fold((failure) => emit(HomeError(failure.message)), (
        transactions,
      ) {
        emit(HomeLoaded(user, transactions));
      });
    });
  }
}
