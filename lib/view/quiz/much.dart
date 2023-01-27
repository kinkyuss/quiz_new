import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_new/component.dart';
import 'package:quiz_new/view/quiz/quiz_pop_up1.dart';
import 'package:quiz_new/view_model/view_model/quiz_pop_up.dart';

import '../../model/device_data.dart';

class Much extends ConsumerStatefulWidget {
  const Much({
    Key? key,
    required this.roomID,
  }) : super(key: key);

  final String roomID;

  @override
  ConsumerState<Much> createState() => _MuchState();
}

class _MuchState extends ConsumerState<Much> {
  //Declare a timer
  Timer? timer;

  @override
  void initState() {
    super.initState();

    // timer = Timer(const Duration(seconds: 3), () {
    //   Navigator.pushNamed(context, '/quiz_pop_up1');
    // });
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
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
              UserInformation(information: quizPopUpViewModel.myInformation,),
              SizedBox(height: size.height * 0.025),
              OftenText(text: 'VS').large(context),
              SizedBox(height: size.height * 0.025),
              UserInformation(information:quizPopUpViewModel.opponentInformation,),
            ],
          ),
        ),
      ]),
    );
  }
}
