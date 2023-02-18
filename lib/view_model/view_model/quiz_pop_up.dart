import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ntp/ntp.dart';
import 'package:quiz_new/view_model/provider.dart';

import '../../model/questions_relation/questions.dart';
import '../../test.dart';
import '../logic/count_down_logic.dart';
import '../logic/sound_logic.dart';
import '../provider.dart';

class QuizPopUpViewModel {
  QuizPopUpViewModel({
    this.context,
    this.context1,
  });

  final BuildContext? context;
  final BuildContext? context1;

  final CountDownLogic _countDownLogic = CountDownLogic();
  late WidgetRef _ref;

  final SoundLogic _soundLogicMain = SoundLogic();
  final SoundLogic _soundLogicSub = SoundLogic();

  void setRef(WidgetRef ref) {
    _ref = ref;
  }

  late final List<String> _testList =
      _ref.read(questionsListProvider.state).state.test;

  late final List<String> _answerList =
      _ref.read(questionsListProvider.state).state.answer;

  late final List<String> _commentaryList =
      _ref.read(questionsListProvider.state).state.commentary;

  late final List<String> _answerForSelect =
      _ref.read(questionsListProvider.state).state.answerForSelect;

  late final List<List<String>> _similarAnswer =
      _ref.read(questionsListProvider.state).state.similarAnswer;

  get commentary => _ref.read(questionsProvider.state).state.commentary;

  get test => _ref.watch(questionsProvider.state).state.test;

  get correct => _ref.read(questionsProvider.state).state.answer;

  get myInformation => {
        'uid': _ref.read(myInformationProvider).uid,
        'consecutive': _ref.read(myInformationProvider).consecutive,
        'name': _ref.read(myInformationProvider).name
      };

  get opponentInformation => _ref.watch(opponentProvider.state).state;

  get countDownNumber =>
      '${(_ref.watch(countDownTimerProvider.state).state / 10)}';

  get first => _ref.read(firstProvider.state).state;

  get roomID => _ref.read(matchInformationProvider.state).state['roomID'];

  get matchID => _ref.read(matchInformationProvider.state).state['matchID'];

  get questionNumber => _ref.watch(questionNumberProvider.state).state;
  late DocumentReference<Map<String, dynamic>> reference = FirebaseFirestore
      .instance
      .collection('rooms')
      .doc(roomID)
      .collection('time')
      .doc('quiz$questionNumber');
  var opponent = false;
  bool buttonTap = false;
  int time = 404;

  var streamSubscription;

  bool countDownStart=false;
  firstProcess(
    BuildContext context,
  ) async {
    print('入っている？');
    if (_ref.read(firstProvider.notifier).state) {
      _ref.read(firstProvider.notifier).state = false;
      var myTime = await NTP.now();
      int startTime = _ref.read(startTimeProvider.notifier).state;
      int offset = startTime - myTime.microsecondsSinceEpoch;
      print(offset);
      await Future.delayed(Duration(microseconds: offset), () async {});
      questionSet(questionNumber);
      countDownTimer(context);
       countDownStart=true;

      final stream = reference.snapshots();

      bool streamProcess = false;
      bool sentCorrect = false;

      streamSubscription = stream.listen((newValue) async {
        print('ajfdk');
        time = newValue.data()?[matchID] ?? 404;
        if (time != 404) {
          opponent = true;
          _ref.read(cdStop.notifier).state = true;

          bool? correct;

          while (!sentCorrect) {
            if (newValue.data()?['correct'] != null) {
              correct = newValue.data()?['correct'];
              print('はいった');
              sentCorrect = true;
              Navigator.pop(context);
              break;
            }
            print('jafj');
            await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) {
                return AlertDialog(
                  title: Text(matchID + 'さんが解答中です。'),
                  content: Text("This is the content"),
                );
              },
            );
          }

          bool showDialogCorrect = false;
          Timer threeTimer() {
            var timer = Timer(const Duration(seconds: 3), () {
              Navigator.pop(context);
            });
            return timer;
          }

          if (correct != null && correct) {
            print(correct);
            print('njfakdl');
            //timesを見直す;
            bool showDialogAppear = false;

         var timer = Timer(const Duration(seconds: 1), () {
              Navigator.pop(context);
            });
            await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) {
                showDialogAppear = true;
                return AlertDialog(
                  title: Text(matchID + 'さんが会っていました。'),
                  content: Text("This is the content"),
                );
              },
            );
            if (newValue.data()?['nextStartTime'] == null) {
              while (newValue.data()?['nextStartTime'] == null) {}
            }
            if (newValue.data()?['nextStartTime'] != null && showDialogAppear) {
              showDialogCorrect = true;
              timer.cancel();
            }

            if (showDialogCorrect) {
              print('jfdlkfjn');
              int nextStartTime = newValue.data()!['nextStartTime'];
              print('kdsfsfsdfsadita');
              toCommentary(nextStartTime, true, context);
              print('dabhsk');
              streamSubscription.cancel();
            }
          } else if (correct != null && !correct) {
            bool showDialogAppear = false;

            var timer = threeTimer();
            await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) {
                showDialogAppear = true;
                return AlertDialog(
                  title: Text(matchID + 'さんが間違っていました。'),
                  content: Text("This is the content"),
                );
              },
            );
            if (newValue.data()?['nextStartTime'] == null) {
              while (newValue.data()?['nextStartTime'] == null) {}
            }
            if (newValue.data()?['nextStartTime'] != null && showDialogAppear) {
              showDialogCorrect = true;
              timer.cancel();
            }

            if (showDialogCorrect) {
              opponent=false;
              streamProcess = true;
              _ref.read(startTimeProvider.notifier).state =
                  newValue.data()!['nextStartTime'];
              _ref.read(cdStop.notifier).state = false;
              countDownTimer(context);

              streamSubscription.cancel();
            }
          }
        }

        // else if (!correct) {
        //
        //   print('jbhskaf');
        //   int times=0;
        //    while(newValue.data()?['nextStartTime'] == null||times<3) {
        //      print(newValue.data()?['nextStartTime'] );
        //      print('jnnaf');
        //      await showDialog(
        //        context: context,
        //        barrierDismissible: false,
        //        builder: (_) {
        //          return AlertDialog(
        //            title: Text(matchID + 'さんが間違っていました。'),
        //            content: Text("This is the content"),
        //          );
        //        },
        //      );
        //      times++;
        //    }
        //    Navigator.pop(context);
        //
        //      streamProcess = true;
        //      _ref.read(startTimeProvider.notifier).state =
        //      newValue.data()!['nextStartTime'];
        //      cdStop = false;
        //      countDownTimer(context);
        //      return ;
        //    }
      });
    }
  }

  buttonPress(context) async {
    if (!buttonTap&&!opponent&&countDownStart) {


      _ref.read(cdStop.notifier).state = true;

      print('if文に入りました');
      await reference.set({
        myInformation['uid']: _ref.read(countDownTimerProvider.state).state
      });
      buttonTap = true;
      print('さらにif文に入りました');

      print('cdStop=');
      print(cdStop);
      Timer threeTimer() {
        var timer = Timer(const Duration(seconds: 3), () {
          Navigator.pop(context);
        });
        return timer;
      }

      print('3分のタイマーが始まりました。');
      print('cdStop==');

      await showDialog(
          context: context,
          builder: (context) {
            return Test(
                similarAnswer: ['まつむら'],
                answerForSelect: 'まつむら',
                correct: correct,
                model: this);
          }).then((value) async {
        print('showDialogが閉じられました');
        if (value == true) {
          print('cdStop=');
          print(cdStop);
          print('正解に入りました。');
          var timer = threeTimer();
          await correctOrWrong(context, '正解!!!');
          if (timer != null && timer!.isActive) {
            timer!.cancel();
          }

          var myTime = await NTP.now();
          await reference.update({
            'correct': true,
            'nextStartTime': myTime.microsecondsSinceEpoch + 12000000,
          });
          print('正解2');
          toCommentary(myTime.microsecondsSinceEpoch + 12000000, true, context);
          print('正解が終わりました。');
        } else {
          print('不正解に入りました、');
          var myTime = await NTP.now();
          int nextStartTime = myTime.millisecondsSinceEpoch +
              double.parse(countDownNumber).floor() * 1000000 +
              13000000;
          await reference.update({
            'correct': false,
            'nextStartTime': nextStartTime,
          });
          _ref.read(startTimeProvider.notifier).state = nextStartTime;

          var timer = Timer(const Duration(seconds: 3), () {
            Navigator.pop(context);
          });
          await correctOrWrong(context, '不正解');
          timer.cancel();


          print('不正解でpopされｍした。');
          _ref.read(cdStop.notifier).state = false;
          countDownTimer(context);
          _soundLogicSub.audioResume();
          print('不正解が終わりました。');
        }
      });
    }
  }

  Future<void> questionSet(int index) async {
    _ref.read(questionsProvider.notifier).state = Questions(
      test: _testList[index],
      answer: _answerList[index],
      commentary: _commentaryList[index],
      similarAnswer: _similarAnswer[index],
      answerForSelect: _answerForSelect[index],
    );
  }

  void countDownTimer(
    context,
  ) async {
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

    if (buttonTap&&_ref.read(countDownTimerProvider.notifier).state==0) {
      print('無事buttonTapはtrueだよ！');
      toCommentary(0, false, context);
    } else if (!_ref.read(cdStop.notifier).state&&_ref.read(countDownTimerProvider.notifier).state==0) {
      print('buttonTapはtrueでない');
      int beforeStartTime = _ref.read(startTimeProvider.notifier).state;

      toCommentary(beforeStartTime + 20000000, true, context);
    }
  }

  commentaryToQuiz() {
    _ref.read(questionNumberProvider.notifier).update((state) => state + 1);
    _ref.read(countDownTimerProvider.notifier).state = 100;
    _ref.read(cdStop.notifier).state = false;
    _ref.read(questionsProvider.notifier).state = _ref
        .read(questionsProvider.notifier)
        .state
        .copyWith(test: '第$questionNumber問');
    print('a');
    print({_ref.read(questionNumberProvider.notifier).state});

  }

  void toCommentary(
      int nextStartTime, bool change, BuildContext context) async {
    _ref.read(firstProvider.notifier).state = true;

    if (change) {
      _ref.read(startTimeProvider.notifier).state = nextStartTime;
    }
    print('ds');
    print({_ref.read(questionNumberProvider.notifier).state});
    await Navigator.pushReplacementNamed(context, '/commentary');
  }

  Future<void> correctOrWrong(context, title) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              content: Text(title));
        });
  }
}
