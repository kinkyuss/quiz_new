import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_new/view_model/logic/show_test_number.logic.dart';

import '../../model/questions_relation/questions.dart';
import '../../model/questions_relation/questions_list.dart';
import '../logic/count_down_logic.dart';
import '../logic/sound_logic.dart';
import '../provider.dart';

class QuizPopUpViewModel {
  QuizPopUpViewModel({
    required this.context,
  });

  final BuildContext context;
  final CountDownLogic _countDownLogic = CountDownLogic();
  late WidgetRef _ref;
  final SoundLogic _soundLogicMain = SoundLogic();
  final SoundLogic _soundLogicSub = SoundLogic();

  void setRef(WidgetRef ref) {
    _ref = ref;
  }

  late final List<String> _testList = _ref.watch(questionsListProvider.state).state.test;

  late final List<String> _answerList =
      _ref.watch(questionsListProvider.state).state.answer;

  late final List<String> _commentaryList =
      _ref.watch(questionsListProvider.state).state.commentary;

  get test => _ref.watch(questionsProvider.state).state.test;

  get answer => _ref.watch(questionsProvider.state).state.answer;

  get commentary => _ref.watch(questionsProvider.state).state.commentary;

  get countDownNumber => _ref.watch(countDownTimerProvider.state).state;

  firstProcess(
    BuildContext context,
    int index,
  ) async{

    _countDownTimer(context);
  }
  void setList(List<String> test, List<String> answer,
      List<String> commentary) {
    _ref
        .read(questionsListProvider.state)
        .state =
        QuestionsList(test: test, answer: answer, commentary: commentary);
    _ref
        .read(questionsProvider.state)
        .state =
        Questions(
            test: test[0], answer: answer[0], commentary: commentary[0]);
  }
Future<  void> questionSet(int index) async{
    _ref.read(questionsProvider.notifier).state = Questions(
        test: _testList[index],
        answer: _answerList[index],
        commentary: _commentaryList[index]);
  }

  void _countDownTimer(context) async {
    for (int i = 0; i < 10; i++) {
      await _countDownLogic.countDownTimer();
      _ref.read(countDownTimerProvider.notifier).state =
          _ref.read(countDownTimerProvider.notifier).state - 1;

      if (_ref.read(countDownTimerProvider.notifier).state.toString() == '6') {
        sleep(const Duration(seconds: 1));
        _soundLogicSub.audioPlay('assets/sounds/新カウントダウン.mp3');
      }
      if (_ref.read(countDownTimerProvider.notifier).state.toString() == '0') {
        _soundLogicSub.audioPlay('assets/sounds/ピー.mp3');
      }
    }
    Navigator.pushNamed(context, '/commentary');
  }
}
