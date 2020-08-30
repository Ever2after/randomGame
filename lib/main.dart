import 'package:flutter/material.dart';
import 'package:random_game/games/game1.dart';
import 'package:random_game/games/consonant_game/consonant_game_time_select.dart';
import 'package:random_game/games/random_target_game.dart';
import 'package:random_game/games/up&down.dart';
import 'package:random_game/games/bottle_spinner.dart';
import 'package:random_game/games/jurumarble/jurumarble.dart';

import 'dart:math';
import 'package:bordered_text/bordered_text.dart';

void main() {
  runApp(MyApp());
}

final List<String> routes = [   //모든 라우팅 정보는 이곳에
  '/game1',
  ConsonantGameTimeSelectScreen.id,
  '/upDown',
  '/bottleSpinner',
  JuruMarble.id,
  RandomTargetGame.id,
];

final List<List<String>> gameInfo = [  //게임 정보 [게임 로고, 이름, 설명, 라우팅 정보]
  ['images/logo.png', '클레오파트라', '목청이 클수록 유리한 게임', routes[0]],
  ['images/logo.png', '랜덤초성게임', '', routes[1]],
  ['images/logo.png', 'Up & Down', '랜덤 숫자 맞추기', routes[2]],
  ['images/logo.png', '소주병 돌리기', '누군가 한 명 고르고 싶을 때', routes[3]],
  ['images/logo.png', '주루마블', '', routes[4]],
  ['images/logo.png', '랜덤터치', '', routes[5]],
];

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '랜덤 술게임',
      home: HomePage(),
      initialRoute: '/',
      routes: {
        '/' : (context) => WelcomePage(),
        routes[0] : (context) => Game1(),
        routes[1] : (context) => ConsonantGameTimeSelectScreen(),
        routes[2] : (context) => UpDown(),
        routes[3] : (context) => BottleSpinner(),
        routes[4] : (context) => JuruMarble(),
        routes[5] : (context) => RandomTargetGame(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Color.fromRGBO(235, 215, 138, 1),
          child: Column(
            children: <Widget>[
              Container(
                child: BorderedText(
                  strokeWidth: 12,
                  strokeColor: Color.fromRGBO(104, 178, 228,1),
                  child: Text(
                    '더 게임 오브 알코올',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                ),
                width: width,
                height: height * 0.2,
                alignment: Alignment.center,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(30,0,30,30),
                padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                height : height*0.55,
                decoration: BoxDecoration(
                  color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      height : 35,
                      child: Text('게임 목록', style: TextStyle(
                        fontSize: 18, color  : Colors.white,
                      ),),
                      decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.only(
                            topLeft : Radius.circular(20),
                            topRight : Radius.circular(20),
                          )
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        physics: BouncingScrollPhysics(),
                        children: <Widget>[
                          _gameTile(gameInfo[0]),
                          _gameTile(gameInfo[1]),
                          _gameTile(gameInfo[2]),
                          _gameTile(gameInfo[3]),
                          _gameTile(gameInfo[4]),
                          _gameTile(gameInfo[5]),
                        ],
                      ),
                    )
                  ],
                )
              ),
              Container(
                width : width,
                color : Color.fromRGBO(235, 215, 138, 1),
                child: Column(
                  children: <Widget>[
                    _randomSelect(),
                    SizedBox(
                      height: height*0.04, //주루마블 안보여서 0.2>0.1로 수정햇어요
                    )
                  ]
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _gameTile(List<String> _gameInfo){
    return ListTile(
      onTap: (){
        Navigator.pushNamed(context, _gameInfo[3]);
      },
      title: Text(_gameInfo[1]),
      subtitle: Text(_gameInfo[2]),
      leading: CircleAvatar(
        backgroundColor: Colors.white,
        backgroundImage : AssetImage(
          _gameInfo[0],
        )
      ),
      trailing: Icon(Icons.play_arrow),
    );
  }

  Widget _randomSelect(){  //게임 랜덤 선택 버튼 위젯
    return RaisedButton(
      color: Color.fromRGBO(77, 158, 79,1),
      child: Container(
        padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
        child: Text('게임 랜덤 스타트!', style: TextStyle(
          color: Colors.white,
          fontSize: 18
        ),),
      ),
      onPressed: (){
        Navigator.pushNamed(
          context, routes[Random().nextInt(routes.length)]
        );
      },
    );
  }
}
