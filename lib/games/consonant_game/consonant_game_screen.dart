import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

const List<String> consonants = [
  'ㄱ', 'ㄴ', 'ㄷ', 'ㄹ', 'ㅁ', 'ㅂ', 'ㅅ', 'ㅇ', 'ㅈ', 'ㅊ', 'ㅋ', 'ㅌ', 'ㅍ', 'ㅎ'
];

class ConsonantGameScreen extends StatefulWidget {
  final int timeLimit;
  ConsonantGameScreen ({ Key key, @required this.timeLimit }): super(key: key);
  @override
  _ConsonantGameScreenState createState() => _ConsonantGameScreenState();
}

class _ConsonantGameScreenState extends State<ConsonantGameScreen> {
  String randomWord1;
  String randomWord2;
  int _counter;
  Timer _timer;
  Random random = Random();
  final int minNum = 3; // randomTime 선택시 최소제한시간
  final int maxNum = 10; // randomTime 선택시 최대제한시간

  @override
  void initState() {
    super.initState();
    randomWord1 = getRandomConsonant(consonants);
    randomWord2 = getRandomConsonant(consonants);
    setTimeLimit();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 120,
                width: 120,
                child: Text(
                  randomWord1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                height: 120,
                width: 120,
                child: Text(
                  randomWord2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),],
          ),
          SizedBox(height: 20,),
          (_counter > 0)
              ? Text('')
              : Text('시간초과!', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),),
          SizedBox(height: 10,),
          Text(
            '$_counter',
            style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 15,),
          FlatButton(
            color: Colors.blue,
            child: Text('다음'),
            onPressed: () {
              setState(() {
                randomWord1 = getRandomConsonant(consonants);
                randomWord2 = getRandomConsonant(consonants);
                setTimeLimit();
                startTimer();
              });
            },
          ),
        ],
      ),
    );
  }

  String getRandomConsonant(List<String> consonants) {
    int ranNum = random.nextInt(consonants.length);
    return consonants[ranNum];
  }

  void startTimer() {
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_counter > 0)
          _counter--;
        else
          _timer.cancel();
      });
    });
  }

  void setTimeLimit() {
    if (widget.timeLimit == -1) { // timeLimit이 -1이면 사용자가 randomTime을 선택한 것
      int ranNum = minNum + random.nextInt(maxNum-minNum);
      _counter = ranNum;
    } else {
      _counter = widget.timeLimit;
    }
  }
}
