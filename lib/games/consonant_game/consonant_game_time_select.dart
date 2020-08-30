import 'package:flutter/material.dart';
import 'consonant_game_screen.dart';

enum TimeEnum { three, five, seven, randomTime }

class ConsonantGameTimeSelectScreen extends StatefulWidget {
  static const String id = 'consonant_game_time_select_screen';
  @override
  _ConsonantGameTimeSelectScreenState createState() =>
      _ConsonantGameTimeSelectScreenState();
}

class _ConsonantGameTimeSelectScreenState
    extends State<ConsonantGameTimeSelectScreen> {
  TimeEnum timeLimit = TimeEnum.three;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Text(
              '제한시간을 선택하세요',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            selectionTile('3초', TimeEnum.three),
            selectionTile('5초', TimeEnum.five),
            selectionTile('7초', TimeEnum.seven),
            selectionTile('랜덤', TimeEnum.randomTime),
            SizedBox(
              height: 20,
            ),
            FlatButton(
              child: Text(
                  '확인',
                style: TextStyle(fontSize: 15, color: Colors.white70),
              ),
              color: Colors.green,
              onPressed: _showRule,
            ),
          ],
        ),
      ),
    );
  }

  Widget selectionTile(String time, TimeEnum val) {
    return ListTile(
      title: Text(time),
      leading: Radio(
          activeColor: Colors.green,
          value: val,
          groupValue: timeLimit,
          onChanged: (TimeEnum selectedTime) {
            setState(() {
              timeLimit = selectedTime;
            });
          }),
    );
  }

  int getTimeLimit(TimeEnum time) {
    switch (time) {
      case TimeEnum.three:
        return 3;

      case TimeEnum.five:
        return 5;

      case TimeEnum.seven:
        return 7;
      case TimeEnum.randomTime:
        return -1; // consonant_game_screen에서 -1을 받으면 random시간으로 설정

      default:
        return 3;
    }
  }

  //gameRule 보여줌
  _showRule() {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text('게임방법'),
              content: Text('제한시간안에 초성에 맞는 단어를 말하고 다음버튼을 누른후에 다음사람에게 넘겨주세요'),
              actions: <Widget>[
                FlatButton(
                  child: Text('취소'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  child: Text('확인'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ConsonantGameScreen(
                                  timeLimit: getTimeLimit(timeLimit),
                                )));
                  },
                )
              ],
            ));
  }
}
