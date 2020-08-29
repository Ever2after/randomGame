import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';


class RandomTargetGame extends StatefulWidget {
  static const String id = 'random_target_game';
  @override
  _RandomTargetGameState createState() => _RandomTargetGameState();
}

class _RandomTargetGameState extends State<RandomTargetGame> {
  Random random = Random();
  double ranNum; // 좌표에 0~1 사이 숫자 곱할건데 그거 랜덤숫자
  double ranNum2;
  int _counter; // 시간 count
  int clickCount;
  Timer _timer;
  @override
  void initState() {
    super.initState();
    _counter = 15; // 0.4초에 맞춰서 하나씩 빼므로 6초 맞추려면 15초
    ranNum = getRandomNumber();
    ranNum2 = getRandomNumber();
    clickCount = 0;
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Positioned(
              top: 20,
              left: 20,
              child: Text(
                '6초동안 최대한 많은 소주잔을 터치하세요!',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,

                ),
              ),
            ),
            Positioned(
              bottom: (height - 40) * ranNum, // 랜덤좌표생성
              right: (width - 40) * ranNum2, // 랜덤좌표생성

              child: InkWell(
                onTap: () {
                  setState(() {
                    ranNum = getRandomNumber();
                    ranNum2 = getRandomNumber();
                    clickCount += 1;
                  });
                },
                child: Container(
                  width: 37,
                  height: 37,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/mini_soju.png'),
                        fit: BoxFit.contain),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  double getRandomNumber() {
    double ranNum = (random.nextInt(100) + 1) * 0.01;
    print('ranNum: $ranNum');
    return ranNum;
  }

  void startTimer() {
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = Timer.periodic(Duration(milliseconds: 400), (timer) {
      setState(() {
        if (_counter > 0) {
          _counter--;
          ranNum = getRandomNumber();
          ranNum2 = getRandomNumber();
        }
        else{
          _nextGame();
          _timer.cancel();
        }

      });
    });
  }

  void _nextGame() {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('$clickCount번 성공하셨습니다!', textAlign: TextAlign.center,),
          content: Text('다음 준비가 다됬으면 확인 버튼을 눌러주세요.'),
          actions: <Widget>[
            FlatButton(
              child: Text('확인'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  clickCount = 0;
                  _counter = 15;
                  startTimer();
                });
              }
            )
          ],
        )
    );
  }
}
