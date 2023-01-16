import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_session/audio_session.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
class Top extends StatefulWidget {
  Top();

  @override
  _TopState createState() => _TopState();
}

class _TopState extends State<Top> with SingleTickerProviderStateMixin   {
  late AudioPlayer _player;
  double _currentSliderValue = 1.0;
  bool _changeAudioSource = false;
  String _stateSource = 'アセットを再生';
  late AnimationController _controller;
  late Animation<Offset> _animation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 25),
    );

    _controller.repeat();
    _animation = Tween<Offset>(
      begin: Offset(0.3, 0.0),
      end: Offset(-1.0, 0.0),
    ).animate(_controller);


    _setupSession();

    // AudioPlayerの状態を取得
    _player.playbackEventStream.listen((event) {
      switch(event.processingState) {
        case ProcessingState.idle:
          print('オーディオファイルをロードしていないよ');
          break;
        case ProcessingState.loading:
          print('オーディオファイルをロード中だよ');
          break;
        case ProcessingState.buffering:
          print('バッファリング(読み込み)中だよ');
          break;
        case ProcessingState.ready:
          print('再生できるよ');
          break;
        case ProcessingState.completed:
          print('再生終了したよ');
          break;
        default:
          print(event.processingState);
          break;
      }
    });
  }

  Future<void> _setupSession() async {
    _player = AudioPlayer();
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration.speech());
    await _loadAudioFile();
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceSize = MediaQuery.of(context).textScaleFactor;
    final timerProvider = Provider((_) => TimerController());
    return SafeArea(
        child: Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/images/utyuu 1.png'),
          fit: BoxFit.cover,
        )),
        child: Center(
          child: Column(children: <Widget>[

            Stack(children: [
              Container(
                height: deviceHeight * 0.075,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('assets/images/01_08 1.png'),
                  fit: BoxFit.cover,
                )),
              ),
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return FractionalTranslation(
                        translation: _animation.value,
                        child: child,
                      );
                    },
                    child: Text(
                      '秋の大会開催中！受け付けは設定から！！プレミアムプラン、今なら半額！',
                      style: TextStyle(
                          fontSize: deviceSize * 35, color: Colors.white),
                    ),
                  )),
            ]),
            SizedBox(
              height: deviceHeight * 0.1,
            ),
            Container(
                height: deviceHeight * 0.25,
                width: deviceWidth * 0.4,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('assets/images/globe.png'),
                  fit: BoxFit.cover,
                ))),
            SizedBox(
              height: deviceHeight * 0.08,
            ),
            InkWell(
                onTap: () async {
                  _player.setAsset('assets/bgms/n14.mp3'); // アセット(ローカル)のファイル


                  _player.play();

                  Navigator.pushNamed(context, '/course_choice',arguments: _player);
                },
                child: Container(
                    height: deviceHeight * 0.125,
                    width: deviceWidth * 0.8,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 4),
                      color: Colors.white.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: Text(
                        'START',
                        style: TextStyle(
                          color: Colors.white,
                          fontStyle: FontStyle.italic,
                          fontSize: 50,
                        ),
                      ),
                    ))),
            SizedBox(
              height: deviceHeight * 0.04,
            ),
            InkWell(
                onTap: () => Navigator.pushNamed(context, '/premium'),
                child: Container(
                    height: deviceHeight * 0.125,
                    width: deviceWidth * 0.8,
                    decoration: BoxDecoration(
                      border: Border.all(width: 3, color: Colors.orangeAccent),
                      color: Colors.white.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: Text(
                        'PREMIUM',
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.white,
                          fontSize: 50,
                        ),
                      ),
                    ))),
            SizedBox(
              height: deviceHeight * 0.05,
            ),
            SizedBox(
              width: deviceWidth * 0.8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        border: Border.all(width: 4, color: Colors.grey),
                        color: Colors.white.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(30),
                      ),
                  child:Icon(Icons.local_post_office,size: deviceSize*40,color:Colors.white)
                  ),
                  Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        border: Border.all(width: 4, color: Colors.grey),
                        color: Colors.white.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(30),
                      ),
                  child:Icon(Icons.edit,color:Colors.white,size:deviceSize*40)),
                  Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        border: Border.all(width: 4, color: Colors.grey),
                        color: Colors.white.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(30),

                      ),
                      child:Icon(Icons.settings,size: deviceSize*40,color:Colors.white)

                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    ));
  }
  Future<void> _playSoundFile() async {
    // 再生終了状態の場合、新たなオーディオファイルを定義し再生できる状態にする
    if(_player.processingState == ProcessingState.completed) {
      await _loadAudioFile();
    }

    await _player.setSpeed(_currentSliderValue); // 再生速度を指定
    await _player.play();
  }

  Future<void> _loadAudioFile() async {
    await _player.setAsset('assets/bgms/n14.mp3'); // アセット(ローカル)のファイル

  }}


class TimerController {
  int _seconds = 0;
  late Timer _timer;

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _seconds++;
    });
  }

  void stopTimer() {
    _timer?.cancel();
  }

  String getTimerString() {
    int minutes = _seconds ~/ 60;
    int seconds = _seconds % 60;
    return "$minutes:$seconds";
  }
}