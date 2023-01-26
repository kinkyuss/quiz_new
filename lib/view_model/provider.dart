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
final countDownTimerProvider=StateProvider <int>((ref) =>100);

final questionsListProvider = StateProvider <QuestionsList>((ref) =>
    const QuestionsList(test: ['まだ問題は登録されていません。','日本で一番高い山は？,','日本で一番高い山は？,','日本で一番高い山は？,','日本で一番高い山は？,'],
      answer: ['エベレスト','富士山','富士山','富士山','富士山','富士山','富士山','富士山'],
      commentary: ['まだ解説は登録されていません。','富士山や','富士山','富士山','富士山'],));
final questionsProvider = StateProvider<Questions>((ref) {return const Questions(test:'',answer:'',commentary: '', );});
final firstProvider = StateProvider<bool>((ref) {return true;});
final cdStop= StateProvider<bool>((ref) {return false;});
final pushEmojiProvider = StateProvider<bool>((ref) {return false;});
final questionNumberProvider = StateProvider<int>((ref) =>0);
final muchStateProvider = StateProvider<String>((ref) =>'対戦相手を探しています。');
final opponentProvider =StateProvider<Map>((ref) =>{});

