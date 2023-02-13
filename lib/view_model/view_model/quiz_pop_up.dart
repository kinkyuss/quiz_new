import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ntp/ntp.dart';
import 'package:quiz_new/component.dart';

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
  bool cdStop = false;
  final SoundLogic _soundLogicMain = SoundLogic();
  final SoundLogic _soundLogicSub = SoundLogic();

  void setRef(WidgetRef ref) {
    _ref = ref;
  }


  late final List<String> _testList =
      _ref
          .read(questionsListProvider.state)
          .state
          .test;

  late final List<String> _answerList =
      _ref
          .read(questionsListProvider.state)
          .state
          .answer;

  late final List<String> _commentaryList =
      _ref
          .read(questionsListProvider.state)
          .state
          .commentary;

  late final List<String> _answerForSelect =
      _ref
          .read(questionsListProvider.state)
          .state
          .answerForSelect;

  late final List<List<String>> _similarAnswer =
      _ref
          .read(questionsListProvider.state)
          .state
          .similarAnswer;
  late int startTime = _ref
      .read(startTimeProvider.notifier)
      .state;

  get commentary =>
      _ref
          .watch(questionsProvider.state)
          .state
          .commentary;

  get test =>
      _ref
          .watch(questionsProvider.state)
          .state
          .test;

  get correct =>
      _ref
          .watch(questionsProvider.state)
          .state
          .answer;

  get myInformation =>
      {
        'uid': _ref
            .read(myInformationProvider)
            .uid,
        'consecutive': _ref
            .read(myInformationProvider)
            .consecutive,
        'name': _ref
            .read(myInformationProvider)
            .name
      };

  get opponentInformation =>
      _ref
          .watch(opponentProvider.state)
          .state;

  get countDownNumber =>
      '${(_ref
          .watch(countDownTimerProvider.state)
          .state / 10)}';

  get first =>
      _ref
          .read(firstProvider.state)
          .state;

  get roomID =>
      _ref
          .read(matchInformationProvider.state)
          .state['roomID'];

  get matchID =>
      _ref
          .read(matchInformationProvider.state)
          .state['matchID'];


  get questionNumber =>
      _ref
          .watch(questionNumberProvider.state)
          .state;
  late DocumentReference<Map<String, dynamic>> reference = FirebaseFirestore
      .instance
      .collection('rooms')
      .doc(roomID)
      .collection('time')
      .doc('quiz$questionNumber');
  var opponent = false;
  bool buttonTap = false;
  int time=0;


  firstProcess(BuildContext context,) async {
    if (_ref
        .read(firstProvider.notifier)
        .state) {
      _ref
          .read(firstProvider.notifier)
          .state = false;
      print('dfajios');
      var myTime = await NTP.now();
      int offset = startTime - myTime.microsecondsSinceEpoch;
      print(offset);
      await Future.delayed(Duration(seconds:offset), () async {});
      questionSet(questionNumber);
      buttonTap = true;
      print('hbrfiadjoks');
      countDownTimer(context);

      final stream = reference
          .snapshots();

      stream.listen((newValue) {
        time=newValue.data()![matchID] ?? 404;
        String status=newValue.data()!['status'] ?? matchID + 'さんが解答中です。。。';
        if (time != 404) {
          opponent = true;
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) {
              return AlertDialog(
                title: Text(status),
                content: Text("This is the content"),
              );
            },
          );
        }
        }
      );

    }
  }

  buttonPress(context) async {
    if (opponent == false && buttonTap) {
      await reference.set({myInformation['uid']: _ref.read(countDownTimerProvider.state).state});
      if(time>_ref.read(countDownTimerProvider.state).state ){
      cdStop = true;
      Timer threeTimer(){
        var timer = Timer(
            const Duration(seconds: 3),
        () {

          Navigator.pop(context);
        });
        return timer;
      }
      showDialog(
          context: context,
          builder: (context) {
            return Test(
                similarAnswer: ['エヴェレスト'],
                answerForSelect: 'エベレスト',
                correct: correct,
                model: this);
          }).then((value) async{
        if (value == true) {
          var timer = threeTimer();
          await correctOrWrong(context,'正解!!!');
          // if (_timer != null && _timer!.isActive) {
          //   _timer!.cancel();
          // }
           timer.cancel();
           toCommentary();
        } else {
          var timer = threeTimer();
          await correctOrWrong(context,'不正解');
          timer.cancel();
          cdStop = false;
          countDownTimer(context);
          _soundLogicSub.audioResume();
        }

      });
    }}
    buttonTap=false;
  }


      Future<void> questionSet(int index) async {
    _ref
        .read(questionsProvider.notifier)
        .state = Questions(
      test: _testList[index],
      answer: _answerList[index],
      commentary: _commentaryList[index],
      similarAnswer: _similarAnswer[index],
      answerForSelect: _answerForSelect[index],
    );
  }

  void countDownTimer(context,) async {
    int cdNumberFirst = _ref
        .read(countDownTimerProvider.notifier)
        .state;

    int store=cdNumberFirst;

    for (int i = 0; i < cdNumberFirst; i++) {
      int cdNumber = _ref
          .read(countDownTimerProvider.notifier)
          .state;
      await Future.delayed(const Duration(milliseconds: 100), () {});

      if (i % 10 == 0) {
        _ref
            .read(countDownTimerProvider.notifier)
            .state = cdNumber - 10;
      }
      if (i == 30&&store==100) {
        _soundLogicSub.audioPlay('assets/sounds/新カウントダウン.mp3');
      }
      if (i == 88&&store==100) {
        _soundLogicSub.audioPlay('assets/sounds/ピー.mp3');
      }
      if (cdStop) {
        _soundLogicSub.audioStop();
        _ref
            .read(countDownTimerProvider.notifier)
            .state = 100 - i;
        break;
      }
    }
    if (!cdStop) {
      _ref
          .read(questionsProvider.notifier)
          .state = _ref
          .read(questionsProvider.notifier)
          .state
          .copyWith(test: '第${questionNumber + 1}問');
      _ref
          .read(startTimeProvider.notifier)
          .state = startTime + 30000000;
      Navigator.pushNamed(context, '/commentary');
    }
  }

  commentaryToQuiz() async {
    _ref.read(questionNumberProvider.notifier).update((state) => state + 1);
    _ref.read(countDownTimerProvider.notifier).update((state) => 100);
    _ref
        .read(firstProvider.notifier)
        .state = true;
    time = 0;
    return questionNumber;
  }

  void toCommentary() {
    Navigator.pushReplacementNamed(context!, '/commentary');

    _ref.read(questionsProvider.notifier).state = _ref
        .read(questionsProvider.notifier)
        .state
        .copyWith(test: '第${questionNumber + 1}問');
    _ref.read(startTimeProvider.notifier).state = startTime + 30000000;

  }

  Future<void> correctOrWrong(context,title)async {
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
