import 'package:flutter/material.dart';

import 'package:hangman/engine/hangman.dart';
import 'package:hangman/ui/hangman_page.dart';

const List<String> wordList = const ["PLENTY","ACHIEVE","CLASS","STARE","AFFECT","THICK","CARRIER","BILL","SAY","ARGUE","OFTEN","GROW","VOTING","SHUT","PUSH","FANTASY","PLAN","LAST","ATTACK","COIN","ONE","STEM","SCAN","ENHANCE","PILL","OPPOSED","FLAG","RACE","SPEED","BIAS","HERSELF","DOUGH","RELEASE","SUBJECT","BRICK","SURVIVE","LEADING","STAKE","NERVE","INTENSE","SUSPECT","WHEN","LIE","PLUNGE","HOLD","TONGUE","ROLLING","STAY","RESPECT","SAFELY"];

void main() => runApp(HangmanApp());

class HangmanApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HangmanAppState();
}

class _HangmanAppState extends State<HangmanApp> {
  HangmanGame _engine;

  @override
  void initState() {
    super.initState();

    _engine = HangmanGame(wordList);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hangman',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HangmanPage(_engine),
    );
  }
}
