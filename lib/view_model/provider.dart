import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_new/model/chosen_data.dart';
import 'package:quiz_new/model/my_information.dart';
import 'package:quiz_new/model/questions_relation/questions.dart';
import 'package:quiz_new/model/questions_relation/questions_list.dart';

import '../model/device_data.dart';
import '../model/questios_relation.dart';

final chosenProvider = StateProvider <ChosenData>((ref) => ChosenData());
final myInformationProvider = StateProvider <MyInformation>((ref) => const MyInformation(name:'松村千里', uid:'Uidが登録されていません。', consecutive: 1));
final countDownTimerProvider=StateProvider <int>((ref) =>10);
final questionsListProvider = StateProvider <QuestionsList>((ref) =>
    const QuestionsList(test: ['まだ問題は登録されていません。'],
      answer: ['まだ問題は登録されていません。'],
      commentary: ['まだ問題は登録されていません。'],));
final questionsProvider = StateProvider<Questions>((ref) {return const Questions(test:'',answer:'',commentary: '', );});
final first = StateProvider<bool>((ref) {return true;});
