import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../user/domain/usecases/get_active_user.dart';

import '../../../user/domain/entities/user_entity.dart';
import '../../../user/domain/usecases/get_user.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetUser getUser;
  final GetLastActiveUser getLastActiveUser;

  HomeBloc(this.getUser, this.getLastActiveUser) : super(HomeInitial()) {
    on<LoadHomeEvent>(_onLoadHomeEvent);
  }

  Future<void> _onLoadHomeEvent(
  LoadHomeEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());

    final result = await getLastActiveUser.execute();

    log("result: ${result.toString()}");
    result.fold(
      (failure) => emit(HomeError(failure.message)),
      (user) => emit(HomeLoaded(user)),
    );
  }
}
