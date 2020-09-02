import 'package:flutter/material.dart';

class JuruMarbleCard extends StatelessWidget {
  final bool endgame;
  final String content;
  JuruMarbleCard({Key key, @required this.content, @required this.endgame})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          NavigatorState nav = Navigator.of(context);
          nav.pop();
          if (endgame) nav.pop();
        },
        child: Stack(children: <Widget>[
          Opacity(
              opacity: 0.6,
              child: Container(
                color: Color.fromRGBO(104, 178, 228, 89),
              )),
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(80),
                  padding: EdgeInsets.all(20),
                  child: Align(
                      child: Text(
                    content,
                    style: TextStyle(color: Colors.black, fontSize: 40, fontFamily: 'Recipekorea'),
                  )),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Color.fromRGBO(104, 178, 228, 89)),
                ),
                Container(),
              ]),
        ]));
  }
}
