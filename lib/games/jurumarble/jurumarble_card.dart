import 'package:flutter/material.dart';


class JuruMarbleCard extends StatelessWidget {

  final bool endgame;
  final String content;
  JuruMarbleCard ({ Key key, @required this.content, @required this.endgame}): super(key: key);


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        NavigatorState nav = Navigator.of(context);
        nav.pop();
        if (endgame)
          nav.pop();
      },
      child: Stack(
      children: <Widget> [ Opacity(
        opacity: 0.5,
        child: Container(
          color: Colors.purple,
        )),
        Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
            Container(
              child: Align(
                  child: Text(
                content,
                style: TextStyle(color: Colors.white, fontSize: 40),
              )),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30), color: Colors.pink[200]),
            ),
            Container(),
          ]),
      ]));
  }
}