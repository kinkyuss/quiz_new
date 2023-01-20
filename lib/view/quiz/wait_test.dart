import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:quiz_new/component.dart';

import '../../model/device_data.dart';



class WaitTest extends HookWidget {
  const WaitTest( {super.key, required this.status,});

final String status;

  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController(
        duration:  const Duration(seconds: 7)
    );
    animationController.repeat();
    DeviceSize size = DeviceSize(context);

    return Stack(
      children:[
        const MainBackGround(),
        Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
            Text(status,
                style: TextStyle(
                  fontSize: size.textScaleFactor * 30,
                  color: Colors.white,
                  decoration: TextDecoration.none,
                )),
            SizedBox(
              height: size.height * 0.05,
            ),
            LoadingAnimation(controller: animationController, size: size),

            SizedBox(height: size.height * 0.15),
            Stack(clipBehavior: Clip.none, children: [
              Container(
                decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(color: HexColor('#E6B422'), width: 4)),
                  color: HexColor('#342C3C').withOpacity(0.8),
                ),
                height: size.height * 0.35,
                width: size.width,
                child: Column(
                  children: [
                    SizedBox(height: size.height * 0.06),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                        Text('Q ',                              style: TextStyle(
                      fontSize: size.textScaleFactor * 20,
                      color: Colors.white,
                      decoration: TextDecoration.none,
                    )),
                        Text('月まで不眠不休で歩くとどれくらいかかる？\n',
                            style: TextStyle(
                              fontSize: size.textScaleFactor * 20,
                              color: Colors.white,
                              decoration: TextDecoration.none,
                            )),
                      ],
                    ),
                    Flexible(
                        child: Text(
                            '人間の平均歩行時速を４kmとし、月から地球の距離を３８万kmとすると、約１１年かかります。ちなみに、時速１０００ｋｍのジェット旅客機であれば、約１５．８日かかります。',
                            style: TextStyle(
                              fontSize: size.textScaleFactor * 20,
                              color: Colors.white,
                              decoration: TextDecoration.none,
                            ))),
                  ],
                ),
              ),
              Positioned(
                top: -30,
                child: Container(
                  height: size.height * 0.075,
                  width: size.width * 0.4,
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: HexColor('#E6B422'), width: 3),
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
            ])
          ])),
 ]
    );
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
