part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class LoadHomeEvent extends HomeEvent {
  final int userId;
  const LoadHomeEvent(this.userId);


  @override
  List<Object> get props => [userId];
}