part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class InsertUserEvent extends UserEvent {
  final UserEntity user;

  const InsertUserEvent(this.user);

  @override
  List<Object> get props => [user];
}
