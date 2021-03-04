part of 'game_bloc.dart';

@immutable
abstract class GameState extends Equatable {}

class GameInitialState extends GameState {
  @override
  List<Object> get props => [];
}

class GameStartedState extends GameState {
  final String palabra;
  final String label;
  final int count;

  GameStartedState(
      {@required this.palabra, @required this.count, @required this.label});
  @override
  List<Object> get props => [palabra, count];
}

class GameEndedState extends GameState {
  final int count;

  GameEndedState({@required this.count});
  @override
  List<Object> get props => [count];
}
