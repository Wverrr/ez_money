import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../user/domain/entities/user_entity.dart';
import '../../../user/domain/usecases/insert_user.dart';

part 'boarding_event.dart';
part 'boarding_state.dart';

class BoardingBloc extends Bloc<BoardingEvent, BoardingState> {
  final InsertUser insertUser;
  final SharedPreferences sharedPreferences;

  BoardingBloc(this.insertUser, this.sharedPreferences)
    : super(BoardingInitial()) {
    on<OnBoardingSaveButtonPressed>(_onBoardingSaveButtonPressed);
  }

  Future<void> _onBoardingSaveButtonPressed(
    OnBoardingSaveButtonPressed event,
    Emitter<BoardingState> emit,
  ) async {
    emit(BoardingLoading());
    final result = await insertUser.execute(event.user);
    sharedPreferences.setInt('last_active_user', event.user.id!);
    sharedPreferences.setBool('isFirstRun', false);

    result.fold(
      (failure) => emit(BoardingError(failure.message)),
      (_) => emit(BoardingSuccess(event.user)),
    );
  }
}
