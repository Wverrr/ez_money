import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../category/domain/usecases/insert_default_category.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final SharedPreferences sharedPreferences;
  final InsertDefaultCategory insertDefaultCategory;

  SplashBloc(this.sharedPreferences, this.insertDefaultCategory) : super(SplashInitial()) {
    on<AppStarted>(_onAppStarted);
  }

  Future<void> _onAppStarted(
    AppStarted event,
    Emitter<SplashState> emit,
  ) async {

    // Insert default categories
    await insertDefaultCategory.execute();

    // emit(SplashGoToHome());
    
    final isFirstRun = sharedPreferences.getBool('isFirstRun') ?? true;


    if (isFirstRun) {
      sharedPreferences.setBool('isFirstRun', false);
      emit(SplashGoToOnboarding());
    } else {
      emit(SplashGoToHome());
      // emit(SplashGoToOnboarding());
    }

  }
}
