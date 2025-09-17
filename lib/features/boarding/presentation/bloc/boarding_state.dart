part of 'boarding_bloc.dart';

abstract class BoardingState extends Equatable {
  const BoardingState();  

  @override
  List<Object> get props => [];
}
class BoardingInitial extends BoardingState {}

class BoardingLoading extends BoardingState {}

class BoardingSuccess extends BoardingState {
  final UserEntity user;

  const BoardingSuccess(this.user);

  @override
  List<Object> get props => [user];
}

class BoardingError extends BoardingState {
  final String message;

  const BoardingError(this.message);

  @override
  List<Object> get props => [message];
}
