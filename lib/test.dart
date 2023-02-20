import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'component.dart';

class Test extends StatefulWidget {
  final List<String> similarAnswer;
  final String answerForSelect;
  final model;

  const Test(
      {Key? key,
      required this.similarAnswer,
      required this.answerForSelect,
      required this.model})
      : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  late Timer _timer;
  double _millisecond = 0.00;
  String answer = '';
  double _countDown = 5.0;
  bool a = true;
  int pressNumber = 0;
  List<List<String>> random = [];

  bool isHiragana(String str) {
    return str.codeUnits.every((int unit) => 0x3040 <= unit && unit <= 0x309F);
  }

  bool isKatakana(String str) {
    return str.codeUnits.every((int unit) => 0x30A0 <= unit && unit <= 0x30FF);
  }

  bool isAlphabet(String str) {
    return str.codeUnits.every((int unit) =>
        (0x41 <= unit && unit <= 0x5A) || (0x61 <= unit && unit <= 0x7A));
  }

  bool isNumber(String str) {
    return str.codeUnits.every((int unit) => 0x30 <= unit && unit <= 0x39);
  }

  @override
  void initState() {
    print('testのinitState');

    String answerForSelect = widget.answerForSelect;
    List similarAnswer = widget.similarAnswer;
    String kana = 'あいうえおかきくけこさしすせそたちつてとなにぬねのはひふへほまみむめもやゆよらりるれろわをん';
    String katakana = 'アイウエオカキクケコサシスセソタチツテトナニヌネノハヒフヘホマミムメモヤユヨラリルレロワヲン';
    String alphabetSmall = 'abcdefghijklmnopqrstuvwxyz';
    String alphabetBig = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    String number = '123456789';
    Random rnd = Random();
    var model = widget.model;

    for (int i = 0; i < answerForSelect.length; i++) {
      List<String> randomIndex = [];
      String str = answerForSelect[i];
      String ranStr;

      bool similar(ranStr) {
        for (var element in similarAnswer) {
          if (element[i] == ranStr) {
            return true;
          }
        }
        return false;
      }

      void randomChar(kind) {
        for (var i = 0; i < 3; i++) {
          do {
            ranStr = kind[rnd.nextInt(kind.length)];
          } while (
              ranStr == str || similar(ranStr) || randomIndex.contains(ranStr));

          randomIndex.add(ranStr);
        }
        randomIndex.insert(rnd.nextInt(3), str);

        random.add(randomIndex);
      }

      if (isHiragana(str)) {
        randomChar(kana);
      } else if (isKatakana(str)) {
        randomChar(katakana);
      } else if (isAlphabet(str)) {
        if (str == str.toUpperCase()) {
          randomChar(alphabetBig);
        } else if (str == str.toLowerCase()) {
          randomChar(alphabetSmall);
        }
      } else if (isNumber(str)) {
        randomChar(number);
      }
    }

    _timer = Timer.periodic(const Duration(milliseconds: 20), (timer) async {
      setState(() {
        _millisecond = _millisecond + 0.004;
        if (((_millisecond * 1000).floor()) % 200 == 0) {
          _countDown = _countDown - 1;
        }
      });
      if (_countDown == 0) {
        Navigator.pop(context, false);
        _timer.cancel();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    print('testがdisposeされました');
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('testがbuildに入りました。');

    return Column(
      children: [
        SizedBox(
          height: 38.h,
        ),
        Container(
          height: 58.h,
          color: Colors.white.withOpacity(0.8),
          child: Column(
            children: [
              AlertDialog(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                content: OftenText(
                  text: answer,
                  color: Colors.black,
                ).medium(context),
              ),
              const Spacer(flex: 1),
              SizedBox(
                  width: 10.h,
                  height: 10.h,
                  child: Stack(fit: StackFit.expand, children: [
                    CircularProgressIndicator(
                        value: _millisecond,
                        valueColor: const AlwaysStoppedAnimation(Colors.red),
                        strokeWidth: 12,
                        backgroundColor: Colors.white),
                    Center(
                      child: OftenText(
                              color: Colors.red,
                              text: _countDown.toString().substring(0, 1))
                          .medium(context),
                    )
                  ])),
              const Spacer(flex: 3),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  button(context, 0, widget.model),
                  button(context, 1, widget.model),
                  button(context, 2, widget.model),
                  button(context, 3, widget.model),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  GestureDetector button(BuildContext context, int buttonNumber, model) {
    String select = random[pressNumber][buttonNumber];
    return GestureDetector(
        onTap: () {
          answer = answer + select;
          if (select != widget.answerForSelect[pressNumber]) {
            pressNumber = 0;

            Navigator.pop(context, false);
          } else if (answer == widget.answerForSelect) {
            pressNumber = 0;
            Navigator.pop(context, true);
          } else {
            pressNumber += 1;
            _countDown = 5;
            _millisecond = 0.00;
            setState(() {});
          }
        },
        child: Container(
          alignment: Alignment.center,
          width: 100.0,
          height: 100.0,
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/utyuu 1.png'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.black),
          child: OftenText(
            text: select,
          ).medium(context),
        ));
  }
}
