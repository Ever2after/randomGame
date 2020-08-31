import 'package:flutter/material.dart';
import 'package:wave/wave.dart';
import 'package:wave/config.dart';
import 'package:wave_progress_widget/wave_progress.dart';
import 'package:wave_progress_widget/wave_progress_widget.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    double _progress = 50.0;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: height * 0.18),
                child: Text(
                  '더 게임 오브 알코올',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),
              Stack(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(top : height*0.125),
                    child: WaveWidget(
                        duration: 1,
                        config: CustomConfig(
                          gradients: [
                            [Color.fromRGBO(104, 178, 228,1), Color.fromRGBO(104, 178, 228,1)],
                            [Color.fromRGBO(104, 178, 228,1), Color.fromRGBO(104, 178, 228,1)],
                            [Color.fromRGBO(104, 178, 228,1), Color.fromRGBO(104, 178, 228,1)],
                            [Color.fromRGBO(104, 178, 228,1), Color.fromRGBO(104, 178, 228,1)],
                          ],
                          durations: [10000, 12000, 15000, 20000],
                          heightPercentages: [0.20, 0.23, 0.25, 0.30],
                          blur: MaskFilter.blur(BlurStyle.inner, 5),
                          gradientBegin: Alignment.centerLeft,
                          gradientEnd: Alignment.centerRight,
                        ),
                        waveAmplitude: 1.0,
                        backgroundColor: Colors.transparent,
                        size: Size(height*0.21, 170.0)),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: height * 0.1),
                    height: height * 0.3,
                    decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage('images/emptylogo.png'))),
                  ),
                ]
              ),
              RaisedButton(
                color: Colors.greenAccent,
                child: Text('next'),
                onPressed: () {
                  Navigator.pushNamed(context, '/home');
                },
              ),
            ],
      )),
    );
  }
}
