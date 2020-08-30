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

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '랜덤 술게임',
      home: HomePage(),
      initialRoute: '/',
      routes: {
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
          child: Column(
            children: <Widget>[
              Container(
                child: Text(
                  '랜덤 술게임~~',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                color: Colors.lightBlue,
                width: width,
                height: height * 0.2,
                alignment: Alignment.center,
              ),
              Expanded(
                child: GridView.count(
                  primary: false,
                  padding: const EdgeInsets.all(25),
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  crossAxisCount: 2,
                  childAspectRatio: 1.618,
                  children: <Widget>[
                    _gameSelect('images/logo3_4x.png', '클레오파트라', routes[0]),
                    _gameSelect('images/logo3_4x.png', '랜덤초성게임', routes[1]),
                    _gameSelect('images/logo3_4x.png', 'Up & Down', routes[2]),
                    _gameSelect('images/logo3_4x.png', '소주병 돌리기', routes[3]),
                    _gameSelect('images/logo3_4x.png', '주루마블', routes[4]),
                    _gameSelect('images/logo3_4x.png', '랜덤터치', routes[5]),
                  ],
                ),
              ),
              _randomSelect(),
              SizedBox(
                height: height*0.1, //주루마블 안보여서 0.2>0.1로 수정햇어요
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _gameSelect(String _imageSrc, String _gameName, String _route){  //게임 선택 버튼 위젯
    return FlatButton(
      padding: EdgeInsets.all(0),
      child: Container(
          padding: EdgeInsets.all(0),
          decoration: BoxDecoration(
            /*
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              )
            ],*/
            image: DecorationImage(
                image: AssetImage(_imageSrc),
                fit: BoxFit.fitHeight,
                /*colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.5),
                    BlendMode.srcOver)*/),
          ),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: BorderedText(
              strokeWidth: 5.0,
              strokeColor: Colors.white,
              child: Text(
                _gameName,
                style:
                TextStyle(fontSize: 24, color: Colors.black, fontWeight: FontWeight.w900
                ,decorationColor : Colors.white,decoration : TextDecoration.none),
              ),
            ),
            alignment: Alignment.center,
          )),
      onPressed: () {
        Navigator.pushNamed(context, _route);
      },
    );
  }

  Widget _randomSelect(){  //게임 랜덤 선택 버튼 위젯
    return RaisedButton(
      color: Colors.greenAccent,
      child: Container(
        padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
        child: Text('게임 랜덤 스타트!', style: TextStyle(
          color: Colors.teal,
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
