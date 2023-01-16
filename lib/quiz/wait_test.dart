import 'package:flutter/material.dart';

class WaitTest extends StatefulWidget {
  final String value;
  WaitTest( {Key? key,v, required this.value}) : super(key: key);

  @override
  State<WaitTest> createState() => _WaitTestState();
}

class _WaitTestState extends State<WaitTest>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 7));
    _controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceSize = MediaQuery.of(context).textScaleFactor;

    return Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/images/utyuu 1.png'),
          fit: BoxFit.cover,
        )),
        child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
              Text(widget.value,
                  style: TextStyle(
                    fontSize: deviceSize * 30,
                    color: Colors.white,
                    decoration: TextDecoration.none,
                  )),
              SizedBox(
                height: deviceHeight * 0.05,
              ),
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _controller.value * 2.0 * 3.141592,
                    child: child,
                  );
                },
                child: Image.asset("assets/images/globe.png",
                    scale: deviceSize / 1.25),
              ),

              SizedBox(height: deviceHeight * 0.15),
              Stack(clipBehavior: Clip.none, children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(color: HexColor('#E6B422'), width: 4)),
                    color: HexColor('#342C3C').withOpacity(0.8),
                  ),
                  height: deviceHeight * 0.35,
                  width: deviceWidth,
                  child: Column(
                    children: [
                      SizedBox(height: deviceHeight * 0.06),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                      children:  [
                          Text('Q ',                              style: TextStyle(
                        fontSize: deviceSize * 20,
                        color: Colors.white,
                        decoration: TextDecoration.none,
                      )),
                          Text('月まで不眠不休で歩くとどれくらいかかる？\n',
                              style: TextStyle(
                                fontSize: deviceSize * 20,
                                color: Colors.white,
                                decoration: TextDecoration.none,
                              )),
                        ],
                      ),
                      Flexible(
                          child: Text(
                              '人間の平均歩行時速を４kmとし、月から地球の距離を３８万kmとすると、約１１年かかります。ちなみに、時速１０００ｋｍのジェット旅客機であれば、約１５．８日かかります。',
                              style: TextStyle(
                                fontSize: deviceSize * 20,
                                color: Colors.white,
                                decoration: TextDecoration.none,
                              ))),
                    ],
                  ),
                ),
                Positioned(
                  top: -30,
                  child: Container(
                    height: deviceHeight * 0.075,
                    width: deviceWidth * 0.4,
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: HexColor('#E6B422'), width: 3),
                        borderRadius: BorderRadius.circular(30),
                        color: HexColor('#887c66')),
                    child: Center(
                      child: Text('Column',
                          style: TextStyle(
                            fontSize: deviceSize * 30,
                            color: Colors.white,
                            decoration: TextDecoration.none,
                            fontStyle: FontStyle.italic,
                          )),
                    ),
                  ),
                ),
              ])
              //   Stack(
              //     children: [Container(
              //         height: deviceHeight * 0.4,
              //         width: double.infinity,
              //         decoration: const BoxDecoration(
              //             image: DecorationImage(
              //               image: AssetImage('assets/images/Column.png'),
              //               fit: BoxFit.cover,
              //             ))),
              // Align(
              //     alignment: const Alignment(-0.8, 100),
              //     child: Text('月まで不眠不休で歩くとどれくらいかかる？',style: TextStyle(color: Colors.white, decoration: TextDecoration.none,fontSize: deviceSize*20),))
              //     ]  ),
            ])));
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
