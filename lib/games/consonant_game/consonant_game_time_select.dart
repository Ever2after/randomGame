import 'package:flutter/material.dart';
import 'consonant_game_screen.dart';

enum TimeEnum { three, five, seven, randomTime}

class ConsonantGameTimeSelectScreen extends StatefulWidget {
  static const String id = 'consonant_game_time_select_screen';
  @override
  _ConsonantGameTimeSelectScreenState createState() => _ConsonantGameTimeSelectScreenState();
}

class _ConsonantGameTimeSelectScreenState extends State<ConsonantGameTimeSelectScreen> {
  TimeEnum timeLimit = TimeEnum.three;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Text('제한시간을 선택하세요'),
            SizedBox(height: 20,),
            ListTile(
              title: Text('3초'),
              leading: Radio(
                  value: TimeEnum.three,
                  groupValue: timeLimit,
                  onChanged: (TimeEnum selectedTime) {
                    setState(() {
                      timeLimit = selectedTime;
                    });
                  }
              ),
            ),
            ListTile(
              title: Text('5초'),
              leading: Radio(
                  value: TimeEnum.five,
                  groupValue: timeLimit,
                  onChanged: (TimeEnum selectedTime) {
                    setState(() {
                      timeLimit = selectedTime;
                    });
                  }
              ),
            ),
            ListTile(
              title: Text('7초'),
              leading: Radio(
                  value: TimeEnum.seven,
                  groupValue: timeLimit,
                  onChanged: (TimeEnum selectedTime) {
                    setState(() {
                      timeLimit = selectedTime;
                    });
                  }
              ),
            ),
            ListTile(
              title: Text('랜덤'),
              leading: Radio(
                  value: TimeEnum.randomTime,
                  groupValue: timeLimit,
                  onChanged: (TimeEnum selectedTime) {
                    setState(() {
                      timeLimit = selectedTime;
                    });
                  }
              ),
            ),
            SizedBox(height: 20,),
            FlatButton(
              child: Text('확인'),
              onPressed: _showRule,

            ),
          ],
        ),
      ),
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
        return -1;  // consonant_game_screen에서 -1을 받으면 random시간으로 설정

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
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => ConsonantGameScreen(timeLimit: getTimeLimit(timeLimit),)
                ));
              },
            )
          ],
        ));
  }


}
