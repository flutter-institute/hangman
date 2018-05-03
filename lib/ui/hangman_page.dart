import 'package:flutter/material.dart';

import 'package:hangman/engine/hangman.dart';

const List<String> progressImages = const [
  'data_repo/img/progress_0.png',
  'data_repo/img/progress_1.png',
  'data_repo/img/progress_2.png',
  'data_repo/img/progress_3.png',
  'data_repo/img/progress_4.png',
  'data_repo/img/progress_5.png',
  'data_repo/img/progress_6.png',
  'data_repo/img/progress_7.png',
];

const String victoryImage = 'data_repo/img/victory.png';

const List<String> alphabet = const [
  'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M',
  'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
];

const TextStyle activeWordStyle = TextStyle(
  fontSize: 30.0,
  letterSpacing: 5.0,
);

class HangmanPage extends StatefulWidget {
  final HangmanGame _engine;

  HangmanPage(this._engine);

  @override
  State<StatefulWidget> createState() => _HangmanPageState();
}

class _HangmanPageState extends State<HangmanPage> {
  bool _showNewGame;
  String _activeImage;
  String _activeWord;

  @override
  void initState() {
    super.initState();

    widget._engine.onChange.listen(this._updateWordDisplay);
    widget._engine.onWrong.listen(this._updateGallowsImage);
    widget._engine.onWin.listen(this._win);
    widget._engine.onLose.listen(this._gameOver);

    this._newGame();
  }

  void _updateWordDisplay(String word) {
    this.setState(() {
      _activeWord = word;
    });
  }

  void _updateGallowsImage(int wrongGuessCount) {
    this.setState(() {
      _activeImage = progressImages[wrongGuessCount];
    });
  }

  void _win([_]) {
    this.setState(() {
      _activeImage = victoryImage;
      this._gameOver();
    });
  }

  void _gameOver([_]) {
    this.setState(() {
      _showNewGame = true;
    });
  }

  void _newGame() {
    widget._engine.newGame();

    this.setState(() {
      _activeWord = '';
      _activeImage = progressImages[0];
      _showNewGame = false;
    });
  }

  _renderBottomContent() {
    if (_showNewGame) {
      return RaisedButton(
        child: new Text('New Game'),
        onPressed: this._newGame,
      );
    } else {
      final Set<String> guessedLetters = widget._engine.lettersGuessed;

      return Wrap(
        spacing: 1.0,
        runSpacing: 1.0,
        alignment: WrapAlignment.center,
        children: alphabet.map((letter) => MaterialButton(
          child: new Text(letter),
          padding: EdgeInsets.all(2.0),
          onPressed: guessedLetters.contains(letter) ? null : () {
            widget._engine.guessLetter(letter);
          },
        )).toList(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Hangman'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Image
            Expanded(
              flex: 2,
              child: Image.asset(_activeImage),
            ),
            // Word
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Center(
                child: Text(_activeWord, style: activeWordStyle),
              ),
            ),
            // Controls
            Expanded(
              flex: 2,
              child: Center(
                child: this._renderBottomContent(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}