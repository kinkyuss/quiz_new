import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_new/component.dart';
import 'package:sizer/sizer.dart';

import '../../model/device_data.dart';
import '../../view_model/provider.dart';
import '../../view_model/view_model/quiz_pop_up.dart';

class QuizPopUp1 extends StatelessWidget {
  QuizPopUp1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    QuizPopUpViewModel quizPopUpViewModel =
        QuizPopUpViewModel(context: context);
    DeviceSize size = DeviceSize(context);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      quizPopUpViewModel.firstProcess(context);
    });
    return Scaffold(
      body: Stack(children: [
        const QQBackGround(),
        SizedBox(
          height: 100.h,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    decoration: BoxDecoration(
                        border:
                            Border.all(width: 4, color: Colors.tealAccent),
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
                    height: 40.h,
                    width: double.infinity,
                    child: FittedBox(
                      child: Consumer(builder: (context, ref, child) {
                        quizPopUpViewModel.setRef(ref);
                        return Text(quizPopUpViewModel.test);
                      }),
                    )),
                Row(
                  children: [
                    SizedBox(
                        width: 10.h,
                        height: 10.h,
                        child: Consumer(builder: (context, ref, child) {
                          quizPopUpViewModel.setRef(ref);
                          String count = quizPopUpViewModel.countDownNumber
                              .toString()
                              .substring(
                                  0,
                                  quizPopUpViewModel.countDownNumber.length -
                                      2);

                          return Stack(fit: StackFit.expand, children: [
                            CircularProgressIndicator(
                                value: (100 -
                                        ref
                                            .watch(countDownTimerProvider
                                                .notifier)
                                            .state) /
                                    100,
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.red),
                                strokeWidth: 12,
                                backgroundColor: Colors.white),
                            Container(
                              height: 8.h,
                              width: 8.h,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                  child: Text(
                                count == '-0' ? '0' : count,
                                style: TextStyle(
                                    fontSize: 50,
                                    color: double.parse(count).floor() > 5
                                        ? Colors.white
                                        : Colors.red),
                              )),
                            )
                          ]);
                        })),
                    Spacer(),
                  ],
                ),
                InkWell(
                  onTap: () {
                    quizPopUpViewModel.buttonPress(context);
                  },
                  child: Container(
                      height: 30.h,
                      width: 30.h,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/早押しクイズ.png'),
                              fit: BoxFit.cover))),
                ),
                Consumer(builder: (context, ref, child) {
                  return Table(
                      border: TableBorder.all(color: Colors.black),
                      columnWidths: const <int, TableColumnWidth>{},
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.top,
                      children: tableContents(size ,ref));
                }),
              ]),
        ),
      ]),
    );
  }

  tableContents(DeviceSize size, WidgetRef ref) {
    print('result!!');
    Map <String,List>result= ref.read(resultProvider.notifier).state;
    print(result);
    List<Widget> myWinOrLoss = [
      tableContainer(size.height, size.textScaleFactor, 'あなた'),
    ];
    List<Widget> opponentWinOrLoss = [
      tableContainer(size.height, size.textScaleFactor, ref.read(opponentProvider.notifier).state['name']!
      ) ];
    List<Widget> title = [
      tableContainer(size.height, size.textScaleFactor, ''),
    ];
    for (bool bo in result['me']!) {
      myWinOrLoss.add(
          tableContainer(size.height, size.textScaleFactor, bo ? '〇' : '×'));
    }
    for (bool bo in  result['you']!) {
      opponentWinOrLoss.add(
          tableContainer(size.height, size.textScaleFactor, bo ? '〇' : '×'));
    }
    int times=0;
    while(myWinOrLoss.length-1>times){
      title.add(
          tableContainer(size.height, size.textScaleFactor, '${times + 1}回目'));
   times++;
    }
    print('fasdfsad');
    print(title);
    print(myWinOrLoss);
    print(opponentWinOrLoss);

    return [
      TableRow(children: title),
      TableRow(children: myWinOrLoss),
      TableRow(children: opponentWinOrLoss),
    ];
  }
}

Container tableContainer(double height, double textScaleFactor, String title) {
  return Container(
    color: Colors.green,
    height: height * 0.05,
    child: FittedBox(
        child: Text(title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              decoration: TextDecoration.none,
            ))),
  );
}

class AnimatedText extends StatelessWidget {
  final String text;
  final double delay;

  const AnimatedText({super.key, required this.text, this.delay = 0});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: text.length.toDouble()),
      duration: Duration(seconds: 2),
      builder: (BuildContext context, double animationValue, Widget) {
        return Text(
          text.substring(0, animationValue.floor()),
          style: Theme.of(context).textTheme.headline1,
        );
      },
    );
  }
}
