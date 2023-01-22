import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../component.dart';
import '../../model/questions_relation/questions.dart';
import '../../model/questions_relation/questions_list.dart';
import '../logic/count_down_logic.dart';
import '../logic/show_test_number.logic.dart';
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

  late int time = 0;


  late final List<String> _testList =
      _ref.watch(questionsListProvider.state).state.test;

  late final List<String> _answerList =
      _ref.watch(questionsListProvider.state).state.answer;

  late final List<String> _commentaryList =
      _ref.watch(questionsListProvider.state).state.commentary;

  get test => _ref.watch(questionsProvider.state).state.test;

  get correct => _ref.watch(questionsProvider.state).state.answer;

  get commentary => _ref.watch(questionsProvider.state).state.commentary;

  get countDownNumber =>
      '${_ref.watch(countDownTimerProvider.state).state / 10}'.substring(0, 1);
  get first => _ref.watch(firstProvider.state).state;

  get questionNumber => _ref.watch(questionNumberProvider.state).state;
  late DocumentReference<Map<String, dynamic>> reference = FirebaseFirestore
      .instance
      .collection('rooms')
      .doc('5BqhH1uf3QwgGiNK1LhG')
      .collection('time')
      .doc('quiz$questionNumber');

  firstProcess(
    BuildContext context,
  ) async {

    questionSet(questionNumber);
    _countDownTimer(context);
    final stream =
        reference.snapshots().map((snapshot) => snapshot.data()!['abc'] ?? 404);

    //ココは変なところで検知される。
    // stream.listen((newValue) {
    //   print('sssssssssssssss');
    //   print(_ref.read(countDownTimerProvider.state).state .runtimeType );
    //   print(newValue.runtimeType);
    //
    //   if (_ref.read(countDownTimerProvider.state).state > newValue) {
    //     if (time == 0) {
    //       reference.update({
    //         'def': true,
    //       });
    //     }
    //     time + 1;
    //   } else if (cdStop) {
    //     print('ここだよ');
    //     //false
    //   }
    //   // do something with the new value
    // });

    _ref.read(firstProvider.notifier).state=false;
  }

  buttonPress(context) async {
    cdStop = true;
    print('adfasfas');
    await reference.set({'def': countDownNumber});
    final stream =
    reference.snapshots().map((snapshot) => snapshot.data()?['check'] ?? false);

    stream.listen((newValue)async {

      if (newValue == true&&time==0) {
        time=time+1;
        await ShowDialog(

            process: (a, answer) async {
              if (answer == correct) {
                await showTestNumber(context, 100, 3);

              Navigator.pushNamed(context, 'commentary');

                return;
              }
              print('fasfdsa');
              a.cdStop = false;
              a._countDownTimer(context);
            },
            a: this,complete:(a, answer) async {
              print('hbjdfask');
          a.cdStop = false;
          print('count=');
          print(_ref.read(countDownTimerProvider.notifier).state);
          a._countDownTimer(context);



        },)
            .build(context);// cdStop = false;
      // }
    }});
    }
  void setList(
      List<String> test, List<String> answer, List<String> commentary) {
    _ref.read(questionsListProvider.state).state =
        QuestionsList(test: test, answer: answer, commentary: commentary);
    _ref.read(questionsProvider.state).state =
        Questions(test: test[0], answer: answer[0], commentary: commentary[0]);
  }

  Future<void> questionSet(int index) async {

    _ref.read(questionsProvider.notifier).state = Questions(
        test: _testList[index],
        answer: _answerList[index],
        commentary: _commentaryList[index]);
  }

  void _countDownTimer(context) async {
    int cdNumberFirst = _ref.watch(countDownTimerProvider.notifier).state;
   print('cdnumber');
    print(cdNumberFirst);
    for (int i = 0; i < cdNumberFirst; i++) {
      int cdNumber = _ref.read(countDownTimerProvider.notifier).state;
      // await _countDownLogic.countDownTimer();
      await Future.delayed(Duration(milliseconds: 100),(){});
     print(i);
      if (i % 10 == 0) {
        print('haitta');
        _ref.read(countDownTimerProvider.notifier).state = cdNumber - 10;
     print(cdNumber);
      }
      if (i == 30) {
        // _soundLogicSub.audioPlay('assets/sounds/新カウントダウン.mp3');
      }
      if (i == 88) {
        // _soundLogicSub.audioPlay('assets/sounds/ピー.mp3');
      }
      if (cdStop) {
        print('haitta?');
        _ref.watch(countDownTimerProvider.notifier).state = 100 - i;
        // _soundLogicSub.audioStop();
        break;
      }
    }
    if (!cdStop) {
      print('kokohaaa');

      Navigator.pushNamed(context, '/commentary');
    }
  }

  commentaryToQuiz() async {
    _ref.read(questionNumberProvider.notifier).update((state) => state + 1);
    _ref.read(countDownTimerProvider.notifier).update((state) => 100);
    _ref.read(firstProvider.notifier).state=true;

    // firstProcess(context1!);
    time = 0;
    return questionNumber;
  }
}
