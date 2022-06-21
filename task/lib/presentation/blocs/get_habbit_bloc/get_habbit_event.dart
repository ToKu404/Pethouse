part of 'get_habbit_bloc.dart';

abstract class GetHabbitEvent extends Equatable {
  const GetHabbitEvent();
  @override
  List<Object> get props => [];
}

class GetHabbits extends GetHabbitEvent {
  final List<HabbitEntity> listHabbit;

  const GetHabbits({required this.listHabbit});

  @override
  List<Object> get props => [listHabbit];
}

class FetchHabbits extends GetHabbitEvent {
  final String petId;

  const FetchHabbits({required this.petId});

  @override
  List<Object> get props => [petId];
}
