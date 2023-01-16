import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_session/audio_session.dart';

class CourseChoice extends StatefulWidget {
  const CourseChoice({Key? key}) : super(key: key);

  @override
  State<CourseChoice> createState() => _CourseChoiceState();
}

class _CourseChoiceState extends State<CourseChoice> {
  late AudioPlayer _player;
  final userUid = FirebaseAuth.instance.currentUser!.uid;

  double _currentSliderValue = 1.0;
  bool _changeAudioSource = false;
  String _stateSource = 'アセットを再生';

  @override
  void initState() {
    super.initState();

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
  Color choiceColor1=Colors.transparent;
  Color choiceColor2=Colors.transparent;
  Color choiceColor3=Colors.white.withOpacity(0.4);

  @override
  Widget build(BuildContext context) {

    final receive =
    ModalRoute.of(context)!.settings.arguments as AudioPlayer;


    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceSize = MediaQuery.of(context).textScaleFactor;
    Future<void> _setupSession() async {
      _player = AudioPlayer();
      final session = await AudioSession.instance;
      await session.configure(AudioSessionConfiguration.speech());
      await _loadAudioFile();
    }
    return SafeArea(
      child: Scaffold(
        body: Stack(children: [
          Container(
            height: deviceHeight * 1,
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/images/utyuu 1.png'),
              fit: BoxFit.cover,
            )),
          ),
          Column(
            children: [
              SizedBox(
                height: deviceHeight * 0.15,
              ),
              Container(
                width: deviceWidth * 1,
                color: Colors.black,
                height: deviceHeight * 0.6,
                child: Column(
                  children: [
                    Text('コースの選択',
                        style: TextStyle(
                            color: Colors.white, fontSize: deviceSize * 30)),
                    Divider(
                      color: Colors.grey,
                      height: deviceHeight * 0.01,
                    ),
                    InkWell(
                      enableFeedback: false,
                      onTap: ()async{
                        await _player.setAsset('assets/bgms/choice.mp3');
                        _playSoundFile();
                        setState(() {
                          choiceColor3=Colors.orangeAccent;
                          choiceColor2=Colors.transparent;
                          choiceColor1=Colors.red;
                        });
                      },
                      child: Container(
                        height: deviceHeight * 0.25,
                        color:choiceColor1,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: deviceWidth * 0.3,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                image: AssetImage('assets/images/火星.png'),
                              )),
                            ),
                            Text(
                              '早押しクイズ',
                              style: TextStyle(
                                  color: Colors.white, fontSize: deviceSize * 40),
                            ),

                          ],
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.grey,
                      height: deviceHeight * 0.02,
                    ),
                InkWell(
                  enableFeedback: false,
                  onTap: ()async{

                    await _player.setAsset('assets/bgms/choice.mp3');
                    _playSoundFile();
                    setState(() {
                      choiceColor3=Colors.orangeAccent;

                      choiceColor1=Colors.transparent;

                      choiceColor2=Colors.red;
                    });

                  },
                  child: Container(
                    height: deviceHeight * 0.25,
                    color:choiceColor2,

                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: deviceWidth * 0.3,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/土星.png'),
                              )),
                        ),
                        Text(
                          '選択クイズ',
                          style: TextStyle(
                              color: Colors.white, fontSize: deviceSize * 40),
                        )
                      ],
                    ),
                  ),
                ),
                  ],
                ),
              ),
              SizedBox(
                height: deviceHeight*0.075,
              ),
              InkWell(
                enableFeedback: false,
                onTap: ()async{
                  await receive.stop();
                  _player.stop();
                  await _player.setAsset('assets/bgms/enter.mp3');
                  final now = DateTime.now();
                  int unixtime = now.millisecondsSinceEpoch;
                  await  FirebaseFirestore.instance
                      .collection('waitingUsers')
                      .doc(userUid)
                      .set({'status':'waiting','updateAt':unixtime});


                  Navigator.pushNamed(context, '/wait');
                },
                child: Container(
                    height: deviceHeight*0.08,
                    width:deviceWidth*0.4,
                    decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.grey),
                      color: choiceColor3,
                      borderRadius: BorderRadius.circular(20),

                    ),
                    child:Center(child: Text('GO!',style: TextStyle(                          fontStyle: FontStyle.italic,
                        fontSize: deviceSize*40,color:Colors.white),))

                ),
              ),

            ],
          )
        ]),
      ),
    );


  }
  Future<void> _loadAudioFile() async {
    await _player.setAsset('assets/bgms/choice.mp3'); // アセット(ローカル)のファイル
  }
  Future<void> _playSoundFile() async {
    // 再生終了状態の場合、新たなオーディオファイルを定義し再生できる状態にする
    if(_player.processingState == ProcessingState.completed) {
      await _loadAudioFile();
    }

    await _player.setSpeed(_currentSliderValue); // 再生速度を指定
    await _player.play();
  }



}
