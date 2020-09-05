import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'main.dart';

import 'dart:math';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                height : height*0.13,
                margin: EdgeInsets.only(top: height * 0.05),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image : AssetImage('images/title.png')
                    )
                ),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(30,30,30,30),
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
                          fontSize: 16, color  : Colors.white, fontFamily: 'Recipekorea'
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
                            _gameTile(gameInfo[6])
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
      title: Text(_gameInfo[1], style: TextStyle(fontFamily: 'Recipekorea'),),
      subtitle: Text(_gameInfo[2], style: TextStyle(fontFamily: 'Recipekorea'),),
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
        child: Text('랜덤으로 게임 스타트!', style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontFamily: 'Recipekorea'
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