import 'package:flutter/material.dart';
import 'welcomeScreen.dart';
import 'homeScreen.dart';
import 'package:random_game/games/game1.dart';
import 'package:random_game/games/consonant_game/consonant_game_time_select.dart';
import 'package:random_game/games/random_target_game.dart';
import 'package:random_game/games/up&down.dart';
import 'package:random_game/games/bottle_spinner.dart';
import 'package:random_game/games/jurumarble/jurumarble.dart';
import 'package:random_game/games/frying_pan_screen.dart';


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
  FryingPanScreen.id,
];

final List<List<String>> gameInfo = [  //게임 정보 [게임 로고, 이름, 설명, 라우팅 정보]
  ['images/logo/3.png', '클레오파트라', '목청이 클수록 유리한 게임', routes[0]],
  ['images/logo/6.png', '랜덤초성게임', '', routes[1]],
  ['images/logo/4.png', 'Up & Down', '랜덤 숫자 맞추기', routes[2]],
  ['images/logo/1.png', '소주병 돌리기', '누군가 한 명 고르고 싶을 때', routes[3]],
  ['images/logo/5.png', '주루마블', '', routes[4]],
  ['images/logo/2.png', '랜덤터치', '', routes[5]],
  ['images/logo/7.png', '후라이펜돌이', '', routes[6]],
];

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '랜덤 술게임',
      initialRoute: '/home',
      routes: {
        '/' : (context) => WelcomeScreen(),
        '/home' : (context) => HomeScreen(),
        routes[0] : (context) => Game1(),
        routes[1] : (context) => ConsonantGameTimeSelectScreen(),
        routes[2] : (context) => UpDown(),
        routes[3] : (context) => BottleSpinner(),
        routes[4] : (context) => JuruMarble(),
        routes[5] : (context) => RandomTargetGame(),
        routes[6] : (context) => FryingPanScreen()
      },
      theme: ThemeData(
        fontFamily : 'Recipekorea'
      ),
    );
  }
}