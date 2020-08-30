import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const List<String> consonants = [
  'ㄱ',
  'ㄴ',
  'ㄷ',
  'ㄹ',
  'ㅁ',
  'ㅂ',
  'ㅅ',
  'ㅇ',
  'ㅈ',
  'ㅊ',
  'ㅋ',
  'ㅌ',
  'ㅍ',
  'ㅎ'
];

const Color textColor = Color.fromRGBO(80, 158, 77, 1);
const Color backgroundColor = Color.fromRGBO(235, 215, 138, 1);
const Color textColor2 = Color.fromRGBO(104, 178, 228, 1);

class ConsonantGameScreen extends StatefulWidget {
  final int timeLimit;
  ConsonantGameScreen({Key key, @required this.timeLimit}) : super(key: key);
  @override
  _ConsonantGameScreenState createState() => _ConsonantGameScreenState();
}

class _ConsonantGameScreenState extends State<ConsonantGameScreen> {
  String randomWord1;
  String randomWord2;
  int _counter;
  Timer _timer;
  int penaltyNum; // 벌칙결정하는 랜덤숫자
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
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
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
                    color: Colors.black,
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
                    color: Colors.black,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          (_counter > 0)
              ? Text('')
              : Text(
                  '시간초과!',
                  style: TextStyle(
                      color: textColor,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
          SizedBox(
            height: 10,
          ),
          (_counter > 0)
              ? Text(
                  '$_counter',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : Text(''),
          SizedBox(
            height: 15,
          ),
          FlatButton(
            color: textColor2,
            child: Text('다음', style: TextStyle(fontSize: 16, color: Colors.white70),),
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

  int getRandomNumber(int num) {
    int ranNum = random.nextInt(num);
    return ranNum;
  }

  void startTimer() {
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_counter > 0)
          _counter--;
        else {
          penaltyNum = getRandomNumber(101);
          setPenalty(penaltyNum);
          _timer.cancel();
        }
      });
    });
  }

  void setTimeLimit() {
    if (widget.timeLimit == -1) {
      // timeLimit이 -1이면 사용자가 randomTime을 선택한 것
      int ranNum = minNum + random.nextInt(maxNum - minNum);
      _counter = ranNum;
    } else {
      _counter = widget.timeLimit;
    }
  }

  void setPenalty(int penaltyNum) {
    if (penaltyNum <= 10) {
      _showPenalty('소주2잔ㅋㅋ', 'images/soju.png');
    } else if (10 < penaltyNum && penaltyNum <= 20) {
      _showPenalty('물1잔^^7 ', 'images/water.png');
    } else if (20 < penaltyNum && penaltyNum <= 70) {
      _showPenalty('소주1잔!', 'images/soju.png');
    } else if (70 < penaltyNum && penaltyNum <= 85) {
      _showPenalty('맥주 반컵!', 'images/beer.png');
    } else {
      _showPenalty('소맥1잔!', 'images/beer.png');
    }
  }

  //벌칙 알림창
  void _showPenalty(String penaltyText, String image) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (_) => AlertDialog(
          backgroundColor: backgroundColor,
              title: Text(
                penaltyText,
                textAlign: TextAlign.center,
                style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
              ),
              content: Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(image), fit: BoxFit.contain),
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('확인', style: TextStyle(color: Colors.black),),
                  onPressed: () => Navigator.of(context).pop(),
                )
              ],
            ));
  }
}
