import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_new/component.dart';
import 'package:quiz_new/model/device_data.dart';
import 'package:quiz_new/view_model/logic/show_test_number.logic.dart';
import 'package:quiz_new/view_model/view_model/quiz_pop_up.dart';

class QuizPopUp1 extends StatelessWidget {
  QuizPopUp1({Key? key}) : super(key: key);

  bool check = false;

  @override
  Widget build(BuildContext context) {
    QuizPopUpViewModel quizPopUpViewModel =
        QuizPopUpViewModel(context: context);
    DeviceSize size = DeviceSize(context);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      print('bakababababa');
      if (quizPopUpViewModel.first) {
        print('ighafdkjijbkdf');
        await showTestNumber(context, quizPopUpViewModel.questionNumber, 1);
        quizPopUpViewModel.firstProcess(context);
      }
    });
var b;
    return Scaffold(
      body: Stack(children: [
        const QQBackGround(),
        SingleChildScrollView(
          child: SizedBox(
            height: size.height,
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
                      height: size.height * 0.4,
                      width: double.infinity,
                      child: FittedBox(
                          child: Consumer(builder: (context, ref, child) {
                        quizPopUpViewModel.setRef(ref);
                        return Text(quizPopUpViewModel.test);
                      }))),
                  InkWell(
                    onTap: () {

                      quizPopUpViewModel.buttonPress(context);
                    },
                    child: Container(
                        height: size.width * 0.5,
                        width: size.width * 0.5,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/早押しクイズ.png'),
                                fit: BoxFit.cover))),
                  ),
                  Container(
                    height: size.height * 0.1,
                    width: size.height * 0.1,
                    color: Colors.red,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Consumer(builder:
                          (BuildContext context, WidgetRef ref, child) {
                        quizPopUpViewModel.setRef(ref);
                        return Text(
                          quizPopUpViewModel.countDownNumber.toString(),
                          style: TextStyle(color: Colors.white),
                        );
                      }),
                    ),
                  ),
                  Table(
                    border: TableBorder.all(color: Colors.black),
                    columnWidths: const <int, TableColumnWidth>{},
                    defaultVerticalAlignment: TableCellVerticalAlignment.top,
                    children: [
                      TableRow(children: [
                        tableContainer(size.height, size.textScaleFactor, ''),
                        tableContainer(
                            size.height, size.textScaleFactor, '1回目'),
                        tableContainer(
                            size.height, size.textScaleFactor, '2回目'),
                        tableContainer(
                            size.height, size.textScaleFactor, '3回目'),
                        tableContainer(
                            size.height, size.textScaleFactor, '4回目'),
                        tableContainer(
                            size.height, size.textScaleFactor, '5回目'),
                      ]),
                      TableRow(children: [
                        tableContainer(
                            size.height, size.textScaleFactor, 'あなた'),
                        tableContainer(size.height, size.textScaleFactor, '〇'),
                        tableContainer(size.height, size.textScaleFactor, ''),
                        tableContainer(size.height, size.textScaleFactor, ''),
                        tableContainer(size.height, size.textScaleFactor, ''),
                        tableContainer(size.height, size.textScaleFactor, ''),
                      ]),
                      TableRow(children: [
                        tableContainer(
                            size.height, size.textScaleFactor, 'しみしょー'),
                        tableContainer(size.height, size.textScaleFactor, '×'),
                        tableContainer(size.height, size.textScaleFactor, ''),
                        tableContainer(size.height, size.textScaleFactor, ''),
                        tableContainer(size.height, size.textScaleFactor, ''),
                        tableContainer(size.height, size.textScaleFactor, ''),
                      ]),
                    ],
                  ),
                ]),
          ),
        ),
      ]),
    );
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

  AnimatedText({required this.text, this.delay = 0});

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
