import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/get_user.dart';
import '../../domain/usecases/insert_user.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUser getUser;
  final InsertUser insertUser;

  UserBloc(this.getUser, this.insertUser) : super(UserInitial()) {
    on<InsertUserEvent>(_onInsertUserEvent);
  }

  Future<void> _onInsertUserEvent(
    InsertUserEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoading());
    final result = await insertUser.execute(event.user);
    result.fold(
      (failure) => emit(UserError(failure.message)),
      (_) => emit(UserInserted()),
    );
  }
}
