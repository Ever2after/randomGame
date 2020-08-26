import 'package:flutter/material.dart';
import 'package:random_game/games/game1.dart';
import 'package:random_game/games/consonant_game/consonant_game_time_select.dart';
import 'package:random_game/games/up&down.dart';
import 'package:random_game/games/bottle_spinner.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '랜덤 술게임',
      home: HomePage(),
      initialRoute: '/',
      routes: {
        '/game1' : (context)=>Game1(),
        ConsonantGameTimeSelectScreen.id: (context) => ConsonantGameTimeSelectScreen(),
        '/upDown' : (context)=>UpDown(),
        '/bottleSpinner' : (context)=>BottleSpinner(),
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
                    _gameSelect('images/game1.jpg', '클레오파트라', '/game1'),
                    _gameSelect('images/game1.jpg', '랜덤초성게임', ConsonantGameTimeSelectScreen.id),
                    _gameSelect('images/game1.jpg', 'Up & Down', '/upDown'),
                    _gameSelect('images/game1.jpg', '소주병 돌리기', '/bottleSpinner'),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _gameSelect(String _imageSrc, String _gameName, String _route){
    return FlatButton(
      padding: EdgeInsets.all(0),
      child: Container(
          padding: EdgeInsets.all(0),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              )
            ],
            image: DecorationImage(
                image: AssetImage(_imageSrc),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.5),
                    BlendMode.srcOver)),
          ),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: Text(
              _gameName,
              style:
              TextStyle(fontSize: 20, color: Colors.white),
            ),
            alignment: Alignment.center,
          )),
      onPressed: () {
        Navigator.pushNamed(context, _route);
      },
    );
  }
}
