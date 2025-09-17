part of 'boarding_bloc.dart';

abstract class BoardingEvent extends Equatable {
  const BoardingEvent();

  @override
  List<Object> get props => [];
}

class OnBoardingSaveButtonPressed extends BoardingEvent {
  final UserEntity user;

  const OnBoardingSaveButtonPressed(this.user);

  @override
  List<Object> get props => [user];
}
