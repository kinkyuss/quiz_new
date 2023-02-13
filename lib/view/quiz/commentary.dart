import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_new/component.dart';
import 'package:quiz_new/view_model/logic/show_test_number.logic.dart';
import 'package:quiz_new/view_model/provider.dart';
import 'package:quiz_new/view_model/view_model/quiz_pop_up.dart';

import '../../model/device_data.dart';

class Commentary extends ConsumerWidget {
  const Commentary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    DeviceSize size = DeviceSize(context);
    QuizPopUpViewModel quizPopUpViewModel =
        QuizPopUpViewModel(context1: context);
    quizPopUpViewModel.setRef(ref);
    WidgetsBinding.instance.addPostFrameCallback((_)async {

      await Future.delayed(Duration(seconds: 5), ()async {
                 // await showTestNumber(context, 1, 3);
      });

      await quizPopUpViewModel.commentaryToQuiz();
    Navigator.pushReplacementNamed(context, '/quiz_pop_up1');
    });

    return Material(
      child: SafeArea(
        child: Stack(
          children: [
            const QQBackGround(),
            Column(
              children: [
                Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 4, color: Colors.tealAccent),
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(20),
                        gradient: const LinearGradient(
                          begin: FractionalOffset.topLeft,
                          end: FractionalOffset.bottomRight,
                          colors: [Colors.teal, Colors.tealAccent],
                          stops: [
                            0.0,
                            1.0,
                          ],
                        )),
                    height: size.height * 0.7,
                    width: double.infinity,
                    child: Consumer(builder: (context, ref, child) {
                      quizPopUpViewModel.setRef(ref);
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              OftenText(text: quizPopUpViewModel.correct)
                                  .medium(context),
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.1,
                          ),
                          OftenText(text: quizPopUpViewModel.commentary)
                              .small(context),
                          const Spacer(),
                          Row(
                            children: [
                              const Spacer(),
                              Icon(
                                Icons.favorite_border,
                                size: size.textScaleFactor * 75,
                                color: Colors.red,
                              )
                            ],
                          ),
                        ],
                      );
                    })),
                Spacer(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Column(
                          children: [
                            ClipOval(
                              child: Image.asset(
                                'assets/images/清水翔太.jpg',
                                width: size.height * 0.1,
                                height: size.height * 0.1,
                                fit: BoxFit.fill,
                              ),
                            ),
                            OftenText(text: '清水翔太', smallFontSize: 20)
                                .small(context)
                          ],
                        ),
                        OftenText(text: '😊').medium(context)
                      ],
                    ),
                    ref.watch(pushEmojiProvider.notifier).state
                        ? InkWell(
                            onTap: () => ref
                                .watch(pushEmojiProvider.notifier)
                                .state = false,
                            child: Container(
                              height: size.height * 0.2,
                              width: size.width * 0.4,
                              color: Colors.white.withOpacity(0.6),
                            ),
                          )
                        : InkWell(
                            onTap: () => ref
                                .watch(pushEmojiProvider.notifier)
                                .state = true,
                            child: Container(
                              height: 50,
                              width: 50,
                              color: Colors.white.withOpacity(0.6),
                            ),
                          ),
                    Row(
                      children: [
                        OftenText(text: '😊').medium(context),
                        Column(
                          children: [
                            ClipOval(
                              child: Image.asset(
                                'assets/images/清水翔太.jpg',
                                width: size.height * 0.1,
                                height: size.height * 0.1,
                                fit: BoxFit.fill,
                              ),
                            ),
                            OftenText(text: '清水翔太', smallFontSize: 20)
                                .small(context)
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Spacer(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
