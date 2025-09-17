import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/estimation_entity.dart';
import '../../domain/entities/train_record_entity.dart';
import '../../domain/usecases/estimate_expense.dart';
import '../../domain/usecases/train_model.dart';

part 'estimation_event.dart';
part 'estimation_state.dart';

class EstimationBloc extends Bloc<EstimationEvent, EstimationState> {
  final TrainRecord trains;
  final EstimateExpense estimate;

  EstimationBloc({required this.trains, required this.estimate})
    : super(EstimationInitial()) {
    on<TrainEstimationEvent>(_onTrainEstimationEvent);
    on<EstimateExpenseEvent>(_onEstimateExpenseEvent);
  }

  Future<void> _onTrainEstimationEvent(
    TrainEstimationEvent event,
    Emitter<EstimationState> emit,
  ) async {
    emit(EstimationLoading());
    final trainResult = await trains.execute(event.request);

    await trainResult.fold(
      (failure) async {
        emit(EstimationError(failure.message));
      },
      (trainSuccess) async {
        final lastRecord = event.request.data.last;
        final estimateRequest = EstimationRequestEntity(
          userId: event.request.userId,
          income: lastRecord.income,
          basicNeeds: lastRecord.basicNeeds,
          secondaryNeeds: lastRecord.secondaryNeeds,
          debts: lastRecord.debts,
          savings: lastRecord.savings,
        );

        final estimateResult = await estimate.execute(estimateRequest);

        estimateResult.fold(
          (failure) {
            emit(EstimationError(failure.message));
          },
          (estimateSuccess) {
            
            final combinedResult = EstimationResponseEntity(
              userId: estimateSuccess.userId,
              estimatedExpense: estimateSuccess.estimatedExpense,
              analysis: trainSuccess.analysis,
            );
            emit(EstimationLoaded(estimation: combinedResult));
          },
        );
      }
    );
  }

  Future<void> _onEstimateExpenseEvent(
    EstimateExpenseEvent event,
    Emitter<EstimationState> emit,
  ) async {
    Map<String, dynamic> lastAnalysis = {};
    if (state is EstimationLoaded) {
      lastAnalysis = (state as EstimationLoaded).estimation.analysis;
    }

    emit(EstimationLoading());
    final result = await estimate.execute(event.request);

    result.fold(
      (failure) => emit(EstimationError(failure.message)),
      (value) {
        final combinedResult = EstimationResponseEntity(
          userId: value.userId,
          estimatedExpense: value.estimatedExpense,
          analysis: lastAnalysis,
        );
        emit(EstimationLoaded(estimation: combinedResult));
      },
    );
  }
  
}