import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ntp/ntp.dart';
import 'package:quiz_new/view_model/provider.dart';
import 'package:sizer/sizer.dart';

import '../../model/questions_relation/problem_set.dart';
import '../../test.dart';
import '../logic/sound_logic.dart';

class QuizPopUpViewModel {
  QuizPopUpViewModel({
    this.context,
    this.context1,
  });

  final BuildContext? context;
  final BuildContext? context1;

  late WidgetRef _ref;

  final SoundLogic _soundLogicSub = SoundLogic();

  bool correctWrong6=false;
  void setRef(WidgetRef ref) {
    _ref = ref;
  }

  //Providerを変数に格納する。

  //このバトルで使う問題、解説、解答などの集まり。
  late final List<String> _questionList =
      _ref.read(problemSetsListProvider.notifier).state.question;
  late final List<String> _answerList =
      _ref.read(problemSetsListProvider.notifier).state.answer;

  late final List<String> _commentaryList =
      _ref.read(problemSetsListProvider.notifier).state.commentary;

  late final List<String> _answerForSelect =
      _ref.read(problemSetsListProvider.notifier).state.answerForSelect;

  late final List<List<String>> _similarAnswer =
      _ref.read(problemSetsListProvider.notifier).state.similarAnswer;

  //このバトル全体での情報
  late final String matchID =
  _ref.read(matchInformationProvider.notifier).state['matchID'];

  late final String roomID =
  _ref.read(matchInformationProvider.notifier).state['roomID'];

  //このバトルの中の問題1つに対する情報
  late final int questionNumber =
      _ref.watch(questionNumberProvider.state).state;

  get countDownNumber =>
      '${(_ref.watch(countDownTimerProvider.state).state / 10)}';

  late DocumentReference<Map<String, dynamic>> reference = FirebaseFirestore
      .instance
      .collection('rooms')
      .doc(roomID)
      .collection('time')
      .doc('quiz$questionNumber');

  //問題解答解説
  get test => _ref.watch(problemSetProvider.state).state.question;

  get answer => _ref.read(problemSetProvider.notifier).state.answer;

  get commentary => _ref.read(problemSetProvider.notifier).state.commentary;

  get myInformation => {
    'uid': _ref.read(myInformationProvider).uid,
    'consecutive': _ref.read(myInformationProvider).consecutive,
    'name': _ref.read(myInformationProvider).name
  };
  get table=>_ref.read(resultProvider.notifier).state;
  //ボタンを押せる押せないなど、細かな条件文器に使用している。
  bool opponent = false;
  bool buttonTap = false;
  bool? opponentCorrectOrWrong;
  bool countDownStart = false;
  int time = 404;

  //外に出しておく必要があったため
  late StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>
  streamSubscription;
  late DocumentSnapshot<Map<String, dynamic>> newValueOut;

  firstProcess(
      BuildContext context,
      ) async {
    print('関数に入りました。');

    if (_ref.read(firstProvider.notifier).state) {
      print('if文に入りました。');
      _ref.read(firstProvider.notifier).state = false;
      //相手と決めた時間になるまで待機する。
      _ref.read(countDownTimerProvider.notifier).state = 100;
      var myTime = await NTP.now();
      int startTime = _ref.read(startTimeProvider.notifier).state;
      int offset = startTime - myTime.microsecondsSinceEpoch;
      await Future.delayed(Duration(microseconds: offset), () async {});

      print('問題のセットが完了しました。');
      //第n問の問題解説などをセットする。
      questionSet(questionNumber);

      countDownTimer();
      countDownStart = true;

      //相手がボタンを押したかを監視する。
      final stream = reference.snapshots();
      bool sentCorrectOrWrong = false;
      streamSubscription = stream.listen((newValue) async {
        newValueOut = newValue;
        time = newValue.data()?[matchID] ?? 404;
        if (time != 404) {
          opponent = true;
          _ref.read(cdStop.notifier).state = true;

          while (!sentCorrectOrWrong) {
            if (newValue.data()?['${matchID}correct'] != null) {
              opponentCorrectOrWrong = newValue.data()?['${matchID}correct'];
              sentCorrectOrWrong = true;
              Navigator.pop(context);
              break;
            }
            await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) {
                return AlertDialog(
                  title: Text('$matchIDさんが解答中です。'),
                );
              },
            );
          }

          if (opponentCorrectOrWrong != null) {
            //相手が正誤が分かった時のそれぞれの処理
            print('fdsafdsgggg');
            print( _ref.read(resultProvider.notifier).state);

            if (opponentCorrectOrWrong!) {

              correctWrongShowDialog(true);
            } else {
              correctWrongShowDialog(false);
            }
          }
        }
      });
    }
  }

  //ボタンが押された時に処理をする関数。
  buttonPress(
      context,
      ) async {
    if (!buttonTap && !opponent && countDownStart) {
      _ref.read(cdStop.notifier).state = true;
      //自分の時間を設定する。
      await reference.set({
        myInformation['uid']: _ref.read(countDownTimerProvider.notifier).state
      });

      //自分がボタンを押した記録を残しておく。
      buttonTap = true;

      Timer threeTimer() {
        var timer = Timer(const Duration(seconds: 3), () {
          Navigator.pop(context);
        });
        return timer;
      }

      await showDialog(
          context: context,
          builder: (context) {
            return Test(
                similarAnswer:
                _ref.read(problemSetProvider.notifier).state.similarAnswer,
                answerForSelect: _ref
                    .read(problemSetProvider.notifier)
                    .state
                    .answerForSelect,
                model: this);
          }).then((value) async {
        if (value == true) {
          Map<String, List> result =
              _ref.read(resultProvider.notifier).state;
          if(result.containsKey('me')){
            result['me']!.add(true);
            result['you']!.add(false);
          }
          else{
            result={'me':[true],'you':[false]};
          }
          var timer = threeTimer();
          await correctOrWrong(context, '正解!!!');
          timer.cancel();

          var myTime = await NTP.now();
          await reference.update({
            myInformation['uid'] + 'correct': true,
            'nextStartTime': myTime.microsecondsSinceEpoch + 12000000,
          });

          toCommentary(myTime.microsecondsSinceEpoch + 12000000, true);
        } else {
          //相手が間違っていなかった場合は、自分の残り時間も考慮して次の問題の時間を設定する。
          if (opponentCorrectOrWrong == null) {
            var myTime = await NTP.now();
            int nextStartTime = myTime.microsecondsSinceEpoch +
                double.parse(countDownNumber).floor() * 1000000 +
                15000000;
            await reference.update({
              myInformation['uid'] + 'correct': false,
              'nextStartTime': nextStartTime,
            });
            _ref.read(startTimeProvider.notifier).state = nextStartTime;
          }

          //共通で、「不正解」のダイアログは出す必要がある。
          var timer = Timer(const Duration(seconds: 1), () {
            Navigator.pop(context);
          });
          await correctOrWrong(context, '不正解');
          timer.cancel();

          //相手が間違っていない場合は、そのままカウントダウンを再開する。(相手が答えられる可能性があるため。)
          if (opponentCorrectOrWrong == null) {
            _ref.read(cdStop.notifier).state = false;
            countDownTimer();
            _soundLogicSub.audioResume();
          }
          //相手も間違っていた場合は画面遷移をする。(待ち続ける必要がないため。)
          else {
            Map<String, List> result =
                _ref.read(resultProvider.notifier).state;
            if(result.containsKey('me')){
              result['me']!.add(false);
              result['you']!.add(false);
            }
            else{
              result={'me':[false],'you':[false]};
            }

            var myTime = await NTP.now();
            int nextStartTime = myTime.microsecondsSinceEpoch + 13000000;
            await reference.update({
              myInformation['uid'] + 'correct': false,
              'nextStartTime': nextStartTime,
            });
            toCommentary(nextStartTime, true);
            return;
          }
        }
      });
    }
  }

  Future<void> questionSet(int index) async {
    _ref.read(problemSetProvider.notifier).state = ProblemSet(
      question: _questionList[index],
      answer: _answerList[index],
      commentary: _commentaryList[index],
      similarAnswer: _similarAnswer[index],
      answerForSelect: _answerForSelect[index],
    );
  }

  //カウントダウンを開始する関数。
  //止めることもできる.0になったら解説ページへ移動
  void countDownTimer() async {
    int cdNumberFirst = _ref.read(countDownTimerProvider.notifier).state;

    int store = cdNumberFirst;

    for (int i = 0; i < cdNumberFirst; i++) {
      if (_ref.read(cdStop.notifier).state) {
        _soundLogicSub.audioStop();
        break;
      }
      int cdNumber = _ref.read(countDownTimerProvider.notifier).state;
      await Future.delayed(const Duration(milliseconds: 100), () {});

      if (i % 10 == 0) {
        _ref.read(countDownTimerProvider.notifier).state = cdNumber - 10;
      }
      if (i == 30 && store == 100) {
        _soundLogicSub.audioPlay('assets/sounds/新カウントダウン.mp3');
      }
      if (_ref.read(cdStop.notifier).state) {
        _soundLogicSub.audioStop();
        break;
      }
      if (i == 88 && store == 100) {
        _soundLogicSub.audioPlay('assets/sounds/ピー.mp3');
      }
      if (_ref.read(cdStop.notifier).state) {
        _soundLogicSub.audioStop();
        break;
      }
    }

    //間違ってしまって時間が過ぎた場合、相手と時間の差の調節はしているから
    if ((buttonTap || opponentCorrectOrWrong != null) &&
        _ref.read(countDownTimerProvider.notifier).state == 0) {
      Map<String, List> result =
          _ref.read(resultProvider.notifier).state;
      if(result.containsKey('me')){
        result['me']!.add(false);
        result['you']!.add(false);
      }
      else{
        result={'me':[false],'you':[false]};
      }

      toCommentary(0, false);
    } else if (!_ref.read(cdStop.notifier).state &&
        _ref.read(countDownTimerProvider.notifier).state == 0) {
      Map<String, List> result =
          _ref.read(resultProvider.notifier).state;
      print('fadfdsfdagrdgdsfgtfh');
      print(result);
      if(result.containsKey('me')){
        result['me']!.add(false);
        result['you']!.add(false);
      }
      else{
        result={'me':[false],'you':[false]};
      }

      int beforeStartTime = _ref.read(startTimeProvider.notifier).state;
      toCommentary(beforeStartTime + 18000000, true);
    }
  }

  commentaryToQuiz() {
    _ref.read(questionNumberProvider.notifier).update((state) => state + 1);
    _ref.read(countDownTimerProvider.notifier).state = 100;
    _ref.read(cdStop.notifier).state = false;
    _ref.read(problemSetProvider.notifier).state = _ref
        .read(problemSetProvider.notifier)
        .state
        .copyWith(question: '第${questionNumber + 1}問');
  }

  void toCommentary(int nextStartTime, bool change) async {
    _ref.read(firstProvider.notifier).state = true;
    if (change) {
      _ref.read(startTimeProvider.notifier).state = nextStartTime;
    }
    Navigator.pushReplacementNamed(context!, '/commentary');
    await Navigator.pushReplacementNamed(context!, '/commentary');
  }

  Future<void> correctOrWrong(context, title) async {
    await showDialog(
        context: context,
        builder: (context) {
          return SizedBox(
            child: AlertDialog(
                contentPadding: EdgeInsets.all(10.sp),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                content: Text(title,style:TextStyle(fontSize:50.sp ))),
          );
        });
  }

  void correctWrongShowDialog(bool correctWrong) async {
    Timer? timer;
    late BuildContext innerContext; // 内部の context を保持しておくためのもの

    showDialog(
      context: context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        innerContext = context;
        return AlertDialog(
          contentPadding: EdgeInsets.all(10.sp),
          title:
          Text(correctWrong ? '$matchIDさんが正解しました。' : '$matchIDさんが間違いました。',style: TextStyle(fontSize: 30.sp),),
        );
      },
    );
    await Future.delayed(const Duration(seconds: 1), () {
      Navigator.pop(innerContext);
    });
    print('fdojsafljkdsalkfj');
    print( _ref.read(resultProvider.notifier).state);


    int nextStartTime = newValueOut.data()!['nextStartTime'];
    if (correctWrong) {
      if(!correctWrong6) {
        correctWrong6 = true;
        Map<String, List> result =
            _ref
                .read(resultProvider.notifier)
                .state;
        print('faesfds');
        print(result);
        if (result.containsKey('me')) {
          result['me']!.add(false);
          result['you']!.add(true);
        }
        else {
          result = {'me': [false], 'you': [true]};
        }

        print('fasdfdsa');
        print(result);
        _ref
            .read(resultProvider.notifier)
            .state = result;
        print(_ref
            .read(resultProvider.notifier)
            .state);
      }
      toCommentary(nextStartTime, true);
    } else {
      wrongProcess(nextStartTime);
    }
  }

  void wrongProcess(int nextStartTime) async {
    if (buttonTap) {
      toCommentary(
        nextStartTime,
        false,
      );
      streamSubscription.cancel();
    } else {
      _ref.read(cdStop.notifier).state = false;
      _ref.read(startTimeProvider.notifier).state = nextStartTime;
      countDownTimer();
      streamSubscription.cancel();
      opponent = false;
      return;
    }
  }
}

class MatchResult {}
