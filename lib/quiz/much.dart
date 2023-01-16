import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_session/audio_session.dart';
import 'package:audio_service/audio_service.dart';
import 'package:quiz_new/quiz/quiz_pop_up.dart';


class Much extends StatelessWidget {
  var roomID;

   Much(this.roomID,{Key? key,}) : super(key: key);

//受け取る値を上記の変数に代入



  late AudioPlayer _player;
   @override
   void initState() {




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
  Widget build(BuildContext context) {


    Future.delayed(Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(context, '/quiz_pop_up1',arguments:roomID );
// Navigator.pushNamed(context,'/quiz_pop_up1',arguments:);
    });
     _setupSession();
     print('narasu');
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



     _player.setAsset('assets/bgms/対戦.mp3');
     _playSoundFile();
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceSize = MediaQuery.of(context).textScaleFactor;

    return Scaffold(

        body : Container(
          width: deviceWidth*1,
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/images/utyuu 1.png'),
          fit: BoxFit.cover,
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color:Colors.white, width: 1),

                // border: Border(
                // top: BorderSide(color: HexColor('#E6B422'), width: 4)),
                color: Colors.white.withOpacity(0.2),
              ),
              height: deviceHeight * 0.2,
              width: deviceWidth * 0.75,
           child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceAround,
             children: [
               Column(
                 children: [
                   Container(
                       height: 120,
                       width: 120,

                       decoration: const BoxDecoration(
                           shape: BoxShape.circle,
                           image: DecorationImage(
                             image: AssetImage('assets/images/guest_icon.png'),
                             fit: BoxFit.cover,
                           ))),

                   Text('あなた',         style: TextStyle(
                     fontSize: deviceSize * 20,
                     color: Colors.white,
                     decoration: TextDecoration.none,
                   ))
                 ],
               ),
               Column(
                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                 children: [
                   Text('正答率:93％', style: TextStyle(
                     fontSize: deviceSize * 20,
                     color: Colors.white,
                     decoration: TextDecoration.none,
                   )),
                   Text('勝率:52％', style: TextStyle(
                     fontSize: deviceSize * 20,
                     color: Colors.white,
                     decoration: TextDecoration.none,
                   )),
                   Text('11連勝中!!', style: TextStyle(
                     fontSize: deviceSize * 20,
                     color: Colors.red,
                     decoration: TextDecoration.none,
                   )),

                 ],
               )
             ],
           ),
            ),
            SizedBox(
              height: deviceHeight*0.025,
            ),

            Text('VS',
                style: TextStyle(
                  fontSize: deviceSize * 70,
                  color: Colors.white,
                  decoration: TextDecoration.none,
                )),
            SizedBox(
              height: deviceHeight*0.025,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: HexColor('#E6B422'), width: 3),

                // border: Border(
                // top: BorderSide(color: HexColor('#E6B422'), width: 4)),
                color: Colors.red.withOpacity(0.2),
              ),
              height: deviceHeight * 0.2,
              width: deviceWidth * 0.75,
            ),
          ],
        ),
      ),
    );
  }
   Future<void> _loadAudioFile() async {
     await _player.setAsset('assets/bgms/対戦.mp3'); // アセット(ローカル)のファイル
   }
   Future<void> _playSoundFile() async {
     // 再生終了状態の場合、新たなオーディオファイルを定義し再生できる状態にする
     if(_player.processingState == ProcessingState.completed) {
       await _loadAudioFile();
     }

     await _player.setSpeed(1.0); // 再生速度を指定
     await _player.play();
   }


}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
