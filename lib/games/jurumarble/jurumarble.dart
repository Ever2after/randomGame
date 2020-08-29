import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:numberpicker/numberpicker.dart';
import "dart:async";
import 'jurumarble_game.dart';
import 'jurumarble_roullete.dart';
import 'jurumarble_card.dart';

List<Color> myColors = [
  Colors.red,
  Colors.purple,
  Colors.green,
  Colors.blue,
  Colors.black,
  Colors.orangeAccent
];

class JuruMarble extends StatefulWidget {
  static const String id = 'jurumarble'; //먼지 모르겠지만 따라하자
  @override
  _JuruMarbleState createState() => _JuruMarbleState();
}

class _JuruMarbleState extends State<JuruMarble> {
  //플레이어 x,y좌표
  List<double> posx = List(6); 
  List<double> posy = List(6);
  int _playerNum = 0; //플레이어수(2~6)
  int _curPlayer = 0; //현재 움직이는 플레이어
  Game _game = Game();

  @override
  void initState() {
    super.initState(); //플레이어 수 받기
    Timer.run(() {
      showDialog<int>(
          context: context,
          builder: (BuildContext context) {
            return NumberPickerDialog.integer(
              minValue: 2,
              maxValue: 6,
              title: Text("플레이어 수를 선택하세요"),
              initialIntegerValue: 2,
            );
          }).then((int value) {
        if (value != null) {
          setState(() {
            _playerNum = value;
            _game.setPlayerNum(_playerNum);
            for (int k = 0; k < _playerNum; k++) {
              posx[k] = _game.getPlayerPosX(683, 387, k);
              posy[k] = _game.getPlayerPosY(683, 387, k); //수정해야함
            }
          });
          _moveToRoulletePage(683, 387); //수정...
        }
      });
    });
  } //initState

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]); //화면을 landscape로 고정

    return SafeArea(child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final double height = constraints.maxHeight;
      final double width = constraints.maxWidth; //SafeArea의 width, height
      return Scaffold(
          //child: Scaffold(
          body: Stack(
        children: <Widget>[
          Container(
            //height: height,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('images/jurumarble_chart.jpg'), //주루마블판이미지
              fit: BoxFit.fill,
            )),
          ),
          ...loadPlayers(width, height), //플레이어 말
        ],
      ));
    }));
  }

  List<Widget> loadPlayers(double width, double height) {
    List<Widget> ret = [];

    for (int k = 0; k < _playerNum; k++) {
      ret.add(AnimatedPositioned(
          duration: const Duration(milliseconds: 200),
          curve: Curves.linear, //움직임 애니메이션
          top: posy[k],
          left: posx[k],
          child: Container(
            padding: EdgeInsets.all(7),
            child: Container(
              child: Align(
                  child: Text(
                (k + 1).toString(),
                style: TextStyle(color: Colors.white, fontSize: 16),
              )),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: myColors[k]),
            ),
            height: width / 21,
            width: width / 21,
          )));
    }
    return ret;
  }

  void _moveToRoulletePage(double width, double height) async { //룰렛 push할때 await쓰기위해 async함수로
    final roulleteResult = await Navigator.of(context).push(PageRouteBuilder(
        opaque: false,
        pageBuilder: (context, __, ___) => JuruMarbleRoullete(
              curPlayer: _curPlayer,
              width: width,
              height: height,
            )));
    setState(() {
      //_testreturn = roulleteResult;
      _move(width, height, roulleteResult);
      //_move(5);
    });
  }

  void _move(double width, double height, int k) {
    Future.delayed(Duration(milliseconds: 600)).then((_) async { //card push할때 await 쓰기위해 async함수로
      if (_game.endGame(_curPlayer)) { //현재 움직이는 플레이어가 마지막칸에 있는데 한칸 더가려고 할때임(게임종료)
        await Navigator.of(context).push(PageRouteBuilder( //여기서 pop두번해서 겜 종료댐
            opaque: false,
            pageBuilder: (context, __, ___) => JuruMarbleCard(
                  content: (_curPlayer + 1).toString() + "우승!",
                  endgame: true,
                )));
        return ;  
      }
      
      setState(() {
        _game.movePlayer(_curPlayer);
        for (int k = 0; k < _playerNum; k++) { //원래있던 말들도 자리비켜줘야되니까 걍 다 for문돌림
          posx[k] = _game.getPlayerPosX(width, height, k);
          posy[k] = _game.getPlayerPosY(width, height, k);
        }
      });
      if (k > 1)
        _move(width, height, k - 1); //재귀함수로 한칸씩 움직임
      else { //다 움직였을때 : 다음플레이어로 바꾸고 벌칙내용 알려주기
        _curPlayer = _curPlayer < _playerNum - 1 ? _curPlayer + 1 : 0;
        await Navigator.of(context).push(PageRouteBuilder(
            opaque: false,
            pageBuilder: (context, __, ___) => JuruMarbleCard(
                  content: "벌칙 내용",
                  endgame: false,
                ))); //
        _moveToRoulletePage(width, height);
      }
    });
  }
}
