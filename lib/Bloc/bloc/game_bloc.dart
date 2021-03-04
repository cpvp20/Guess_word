import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
part 'game_event.dart';
part 'game_state.dart';

List<String> palabras = ["pasta", "pizza", "chocolate", "salad", "wine"];

class GameBloc extends Bloc<GameEvent, GameState> {
  final List<String> _palabrasSugeridas = List<String>.from(palabras);
  final List<String> _palabrasReales = List<String>.from(palabras);

  int count = 0;
  int index = 0;

  GameBloc() : super(GameInitialState());

  @override
  Stream<GameState> mapEventToState(
    GameEvent event,
  ) async* {
    if (event is StartGameEvent) {
      //Inicializar 2 listas que contengan las mismas palabras pero en orden diferente (list.shuffle())
      //una lista mostrará palabras sugeridas en la vista y la otra va a contener la palabra a adivinar.
      _palabrasSugeridas.shuffle();
      _palabrasReales.shuffle();
      count =
          0; //Se debe tener un índice que incremente cada que se presiona el botón de skip o got it
      index = 0; //Llevar la cuenta de los aciertos con un contador en el BLoC
      yield GameStartedState(
        palabra: _palabrasSugeridas[index],
        label: "The word is...",
        count: count,
      );
    } else if (event is NextQuestionEvent) {
      if ((event.skipQuestion &&
              _palabrasSugeridas[index] != _palabrasReales[index]) ||
          (!event.skipQuestion &&
              _palabrasSugeridas[index] == _palabrasReales[index])) {
        count++;
      }
      index++;
      if (index >= _palabrasSugeridas.length) {
        yield GameEndedState(count: count);
      } else {
        yield GameStartedState(
            palabra: _palabrasSugeridas[index],
            count: count,
            label: "The word is...");
      }
    } else if (event is EndGameEvent) {
      yield GameEndedState(count: count);
    } else if (event is RestartGameEvent) {
      yield GameInitialState();
    }
  }
}
