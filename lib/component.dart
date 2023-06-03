import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_new/view_model/view_model/find_opponents.dart';
import 'package:quiz_new/view_model/view_model/quiz_pop_up.dart';
import 'package:sizer/sizer.dart';

import 'model/device_data.dart';
import 'view_model/view_model.dart';

class CorrectOrWrong {
  final String result;

  CorrectOrWrong(
      {required this.result});

  build(BuildContext context) async {

    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              content: Text('正解!!'));
        });

}}


class ShowDialog {
  final Function process;
  final a;
  final complete;
  final context;

  ShowDialog({required this.process, required this.complete,required this.a,required this.context});

  build(BuildContext context) {

    String b='答え';
    DeviceSize size = DeviceSize(context);
    return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (dialogContext) {


        return AlertDialog(


          content: SizedBox(
            height: size.height * 0.14,
            child: Column(
              children: [
                SingleChildScrollView(
                  child: TextField(

                    onChanged: (value) {
                      b = value;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: '答えを入力してください。',
                    ),
                    autofocus: false,
                  ),
                ),
                Row(
                  children: [
                    TextButton(
                      child: const Text('ki'),
                      onPressed: () async {
                Navigator.pop(context);
                      },),

                      TextButton(
                      child: const Text('決定'),
                      onPressed: () async {
                        await process(a, b);

                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    )
        .whenComplete(() {
complete(a,b);
    });
  }
}

class OftenText {
  final String text;
  final double largeFontSize;
  final double mediumFontSize;
  final double smallFontSize;
  final Color color;

  OftenText(
      {required this.text,
      this.largeFontSize = 70,
      this.mediumFontSize = 50,
      this.smallFontSize = 30,
      this.color = Colors.white});

  Widget large(BuildContext context) {
    DeviceSize size = DeviceSize(context);
    return Text(
      text,

      style: TextStyle(
        fontSize: size.textScaleFactor * largeFontSize,

        color: color,
        decoration: TextDecoration.none,
      ),
    );
  }

  Widget medium(BuildContext context) {
    DeviceSize size = DeviceSize(context);
    return Text(
      text,
      style: TextStyle(
        fontSize: size.textScaleFactor * mediumFontSize,
        color: color,
        decoration: TextDecoration.none,
      ),
    );
  }

  Widget small(BuildContext context) {
    DeviceSize size = DeviceSize(context);
    return Text(
      text,
      style: TextStyle(
        fontSize: size.textScaleFactor * smallFontSize,
        color: color,
        decoration: TextDecoration.none,
      ),
    );
  }
}

class MainButton extends StatelessWidget {
  const MainButton({
    Key? key,
    required this.size,
    required this.title,
  }) : super(key: key);

  final String title;
  final DeviceSize size;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () async {
          Navigator.pushNamed(context, '/course_choice');
        },
        child: Container(
            height: size.height * 0.125,
            width: size.width * 0.8,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 4),
              color: Colors.white.withOpacity(0.4),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  fontSize: 35.sp
                ),
              ),
            )));
  }
}

class SubButton extends StatelessWidget {
  const SubButton({
    Key? key,
    required this.size,
    required this.icon,
  }) : super(key: key);

  final DeviceSize size;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: size.width * 0.18,
        width: size.width * 0.18,
        decoration: BoxDecoration(
          border: Border.all(width: 4, color: Colors.grey),
          color: Colors.white.withOpacity(0.4),
          borderRadius: BorderRadius.circular(30),
        ),
        child:
            Icon(icon, size: size.textScaleFactor * 80, color: Colors.white));
  }
}

class MainBackGround extends StatelessWidget {
  const MainBackGround({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage('assets/images/utyuu 1.png'),
        fit: BoxFit.cover,
      )),
    );
  }
}

class QQBackGround extends StatelessWidget {
  const QQBackGround({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage('assets/images/早押しクイズ背景.png'),
        fit: BoxFit.cover,
      )),
    );
  }
}

class EnterButton extends ConsumerWidget {
  const EnterButton({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final ViewModel viewModel;

  @override
  Widget build(BuildContext context,ref) {
    DeviceSize size = DeviceSize(context);
    FindOpponents model=FindOpponents();
    model.setRef(ref);

    return InkWell(
      enableFeedback: false,
      onTap: () => Navigator.pushNamed(context, '/wait'),

    child: Container(
          height: size.height * 0.08,
          width: size.width * 0.4,
          decoration: BoxDecoration(
            border: Border.all(width: 2, color: Colors.grey),
            color: viewModel.enterTileColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
              child: Text(
            'GO!',
            style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 25.sp,
                color: Colors.white),
          ))),
    );
  }
}

class ColumnFlame extends StatelessWidget {
  const ColumnFlame({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DeviceSize size = DeviceSize(context);
    return Stack(clipBehavior: Clip.none, children: [
      Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: HexColor('#E6B422'), width: 4)),
          color: HexColor('#342C3C').withOpacity(0.8),
        ),
        height: size.height * 0.35,
        width: size.width,
        child: Column(
          children: [
            SizedBox(height: size.height * 0.06),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OftenText(text: 'Q', smallFontSize: 20).small(context),
                OftenText(text: '月まで不眠不休で歩くとどれくらいかかる？\n', smallFontSize: 20)
                    .small(context)
              ],
            ),
            Flexible(
              child: OftenText(
                  text:
                  '人間の平均歩行時速を４kmとし、月から地球の距離を３８万kmとすると、約１１年かかります。ちなみに、時速１０００ｋｍのジェット旅客機であれば、約１５．８日かかります。',
                  smallFontSize: 20)
                  .small(context),
            )
          ],
        ),
      ),
      Positioned(
        top: -30,
        child: Container(
          height: size.height * 0.075,
          width: size.width * 0.4,
          decoration: BoxDecoration(
              border: Border.all(color: HexColor('#E6B422'), width: 3),
              borderRadius: BorderRadius.circular(30),
              color: HexColor('#887c66')),
          child: Center(
            child: Text('Column',
                style: TextStyle(
                  fontSize: size.textScaleFactor * 30,
                  color: Colors.white,
                  decoration: TextDecoration.none,
                  fontStyle: FontStyle.italic,
                )),
          ),
        ),
      ),
    ]);
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}


class LoadingAnimation extends StatelessWidget {
  const LoadingAnimation({
    Key? key,
    required AnimationController controller,
  })  : _controller = controller,
        super(key: key);

  final AnimationController _controller;
  @override
  Widget build(BuildContext context) {
    DeviceSize size=DeviceSize(context);
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: _controller.value * 2.0 * 3.141592,
          child: child,
        );
      },
      child: Image.asset("assets/images/地球.png",
          scale: size.textScaleFactor / 1),
    );
  }
}

class UserInformation extends StatelessWidget {


  const UserInformation({
    Key? key,
     required this.information,
  }) : super(key: key);

  final Map information;

  @override
  Widget build(BuildContext context) {
    DeviceSize size=DeviceSize(context);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 1),
        color: Colors.white.withOpacity(0.2),
      ),
      height: size.height * 0.2,
      width: size.width * 0.75,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Container(
                  height: 120,
                  width: 120,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('assets/images/guest_icon.png'),
                        fit: BoxFit.cover,
                      ))),
              Text(information['name'],
                  style: TextStyle(
                    fontSize: size.textScaleFactor * 20,
                    color: Colors.white,
                    decoration: TextDecoration.none,
                  ))
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('正答率:93％',
                  style: TextStyle(
                    fontSize: size.textScaleFactor * 20,
                    color: Colors.white,
                    decoration: TextDecoration.none,
                  )),
              Text('勝率:52％',
                  style: TextStyle(
                    fontSize: size.textScaleFactor * 20,
                    color: Colors.white,
                    decoration: TextDecoration.none,
                  )),
              Text('${information['consecutive']}連勝中!!',
                  style: TextStyle(
                    fontSize: size.textScaleFactor * 20,
                    color: Colors.red,
                    decoration: TextDecoration.none,
                  )),
            ],
          )
        ],
      ),
    );
  }
}


