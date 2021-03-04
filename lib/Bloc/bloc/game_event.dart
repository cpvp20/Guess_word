part of 'game_bloc.dart';

@immutable
abstract class GameEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class StartGameEvent extends GameEvent {
  @override
  List<Object> get props => [];
}

class NextQuestionEvent extends GameEvent {
  final bool skipQuestion; //bandera

  NextQuestionEvent({@required this.skipQuestion});

  @override
  List<Object> get props => [skipQuestion];
}

class EndGameEvent extends GameEvent {
  @override
  List<Object> get props => [];
}

class RestartGameEvent extends GameEvent {
  @override
  List<Object> get props => [];
}
