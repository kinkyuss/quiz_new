import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_new/component.dart';
import 'package:quiz_new/view_model/provider.dart';
import 'package:quiz_new/view_model/view_model/quiz_pop_up.dart';

import '../../model/device_data.dart';

class Commentary extends ConsumerStatefulWidget {
  const Commentary({Key? key}) : super(key: key);

  @override
  ConsumerState<Commentary> createState() => _CommentaryState();
}

class _CommentaryState extends ConsumerState<Commentary> {
  bool onTap=false;

  @override
  Widget build(BuildContext context) {
    DeviceSize size = DeviceSize(context);
    QuizPopUpViewModel quizPopUpViewModel =
        QuizPopUpViewModel(context1: context);
    quizPopUpViewModel.setRef(ref);


    bool containsFive(List list) {
      int count = 0;
      for (bool s in list) {
        if (s ) {
          count++;
        }
      }
      print(list);
      print(list);
      print(count >= 3);
      return count >= 3;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(Duration(seconds: 5), () async {
        // await showTestNumber(context, 1, 3);
      });

      print(ref.read(resultProvider.notifier).state!);
      if (containsFive(ref.read(resultProvider.notifier).state['you']!) ||
          containsFive(ref.read(resultProvider.notifier).state['me']!) ||
          ref.read(resultProvider.notifier).state['me']!.length >=
              ref
                  .read(problemSetsListProvider.notifier)
                  .state
                  .question
                  .length) {

        Navigator.pushReplacementNamed(context, '/result');
      }
      else {
        await quizPopUpViewModel.commentaryToQuiz();
        Navigator.pushReplacementNamed(context, '/quiz_pop_up1');
      }

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
                              OftenText(text: quizPopUpViewModel.answer)
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
Spacer()  ,
                              InkWell(

                            
                                onTap:() {
                                  print('af');
                                  setState(() {
                                    onTap=!onTap;
                                  });

                                },
                                child: Icon(
                                  onTap?Icons.favorite:Icons.favorite_border,
                                  size: size.textScaleFactor * 75,
                                  color: Colors.red,
                                ),
                              )
                            ],
                          ),
                        ],
                      );
                    })),
                // Spacer(),
                // Row(
                //   crossAxisAlignment: CrossAxisAlignment.end,
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Row(
                //       children: [
                //         Column(
                //           children: [
                //             ClipOval(
                //               child: Image.asset(
                //                 'assets/images/清水翔太.jpg',
                //                 width: size.height * 0.1,
                //                 height: size.height * 0.1,
                //                 fit: BoxFit.fill,
                //               ),
                //             ),
                //             OftenText(text: '清水翔太', smallFontSize: 20)
                //                 .small(context)
                //           ],
                //         ),
                //         OftenText(text: '😊').medium(context)
                //       ],
                //     ),
                //     ref.watch(pushEmojiProvider.notifier).state
                //         ? InkWell(
                //             onTap: () => ref
                //                 .watch(pushEmojiProvider.notifier)
                //                 .state = false,
                //             child: Container(
                //               height: size.height * 0.2,
                //               width: size.width * 0.4,
                //               color: Colors.white.withOpacity(0.6),
                //             ),
                //           )
                //         : InkWell(
                //             onTap: () => ref
                //                 .watch(pushEmojiProvider.notifier)
                //                 .state = true,
                //             child: Container(
                //               height: 50,
                //               width: 50,
                //               color: Colors.white.withOpacity(0.6),
                //             ),
                //           ),
                //     Row(
                //       children: [
                //         OftenText(text: '😊').medium(context),
                //         Column(
                //           children: [
                //             ClipOval(
                //               child: Image.asset(
                //                 'assets/images/清水翔太.jpg',
                //                 width: size.height * 0.1,
                //                 height: size.height * 0.1,
                //                 fit: BoxFit.fill,
                //               ),
                //             ),
                //             OftenText(text: '清水翔太', smallFontSize: 20)
                //                 .small(context)
                //           ],
                //         ),
                //       ],
                //     ),
                //   ],
                // ),
                // Spacer(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
