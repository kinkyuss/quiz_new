import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ntp/ntp.dart';
import 'package:quiz_new/component.dart';
import 'package:quiz_new/view_model/view_model/quiz_pop_up.dart';
import 'package:quiz_new/model/questions_relation/problem_set.dart';
import '../../model/device_data.dart';
import '../../view_model/provider.dart';

class Much extends ConsumerWidget {
  const Much({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(seconds:3), () async {
        ref.read(problemSetProvider.notifier).state =  ProblemSet(question: '問題1' ,answer:'',commentary: '',answerForSelect:'',similarAnswer: [], );
        ref.read(muchStateProvider.notifier).state = '対戦相手を探しています...';
        ref.read(firstProvider.notifier).state = true;

        ref.read(resultProvider.notifier).state={'me':[],'you':[]};
        Navigator.pushNamed(context, '/quiz_pop_up1');
      });
    });
    DeviceSize size = DeviceSize(context);
    QuizPopUpViewModel quizPopUpViewModel =
        QuizPopUpViewModel(context: context);
    quizPopUpViewModel.setRef(ref);

    return Scaffold(
      body: Stack(children: [
        const MainBackGround(),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              UserInformation(
                information: quizPopUpViewModel.myInformation,
              ),
              SizedBox(height: size.height * 0.025),
              OftenText(text: 'VS').large(context),
              SizedBox(height: size.height * 0.025),
              UserInformation(
                information: quizPopUpViewModel.opponentInformation,
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
