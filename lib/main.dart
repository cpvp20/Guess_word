import 'package:Guess_word/Bloc/bloc/game_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: MyHomePage(title: 'Guess the Word'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GameBloc _bloc;
  _getNextQuestion(bool skip) {
    _bloc.add(NextQuestionEvent(skipQuestion: skip));
  }

  _endGame() {
    _bloc.add(EndGameEvent());
  }

  _restartGame() {
    _bloc.add(RestartGameEvent());
  }

  _startGame() {
    _bloc.add(StartGameEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen[800],
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: BlocProvider(
        create: (context) {
          _bloc = GameBloc();
          return _bloc;
        },
        child: BlocConsumer<GameBloc, GameState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is GameStartedState)
              return Template(
                title: state.palabra,
                label: state.label,
                count: state.count,
                nextQuestion: _getNextQuestion,
                endGame: _endGame,
              );
            else if (state is GameEndedState)
              return Template(
                label: "You scored",
                title: state.count.toString(),
                restartGame: _restartGame,
              );
            return Template(
              label: "Get ready to",
              title: "Guess the word!",
              startGame: _startGame,
            );
          },
        ),
      ),
    );
  }
}

class Template extends StatelessWidget {
  final String label;
  final String title;
  final int count;
  final Function nextQuestion;
  final Function endGame;
  final Function restartGame;
  final Function startGame;

  const Template({
    Key key,
    @required this.label,
    @required this.title,
    this.count,
    this.nextQuestion,
    this.endGame,
    this.restartGame,
    this.startGame,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spacer(),
          Column(
            children: [
              Text(label, style: TextStyle(fontSize: 18)),
              SizedBox(height: 20),
              Text(title,
                  style: TextStyle(fontSize: 34, fontWeight: FontWeight.w500)),
            ],
          ),
          if (restartGame == null) Spacer(),
          if (count != null)
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                "$count",
                style: TextStyle(fontSize: 18),
              ),
            ),
          if (restartGame == null && count == null)
            Padding(
              padding: EdgeInsets.only(bottom: 35),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: FlatButton(
                  child: Text("PLAY",
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                  color: Colors.lightGreen[800],
                  onPressed: () {
                    startGame();
                  },
                ),
              ),
            ),
          if (restartGame == null && count != null)
            Padding(
              padding: EdgeInsets.only(bottom: 35),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FlatButton(
                      color: Colors.white,
                      child: Text("SKIP", style: TextStyle(fontSize: 16)),
                      onPressed: () {
                        nextQuestion(true);
                      },
                    ),
                    FlatButton(
                      child: Text("GOT IT",
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                      color: Colors.lightGreen[800],
                      onPressed: () {
                        nextQuestion(false);
                      },
                    ),
                    FlatButton(
                      color: Colors.white,
                      child: Text("END GAME", style: TextStyle(fontSize: 16)),
                      onPressed: () {
                        endGame();
                      },
                    ),
                  ],
                ),
              ),
            ),
          if (restartGame != null)
            Padding(
              padding: const EdgeInsets.only(top: 80),
              child: FlatButton(
                child: Text(
                  "PLAY AGAIN",
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.lightGreen[800],
                onPressed: () {
                  restartGame();
                },
              ),
            ),
          if (restartGame != null) Spacer(),
        ],
      ),
    );
  }
}
