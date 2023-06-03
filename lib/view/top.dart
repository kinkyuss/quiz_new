import 'package:flutter/material.dart';
import 'package:ntp/ntp.dart';
import 'package:quiz_new/component.dart';
import 'package:quiz_new/model/device_data.dart';
import 'package:sizer/sizer.dart';

class Top extends StatefulWidget {
  const Top({super.key});

  @override
  State<Top> createState() => _TopState();
}

class _TopState extends State<Top> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 25),
    );
    _controller.repeat();
    _animation = Tween<Offset>(
      begin: const Offset(0.3, 0.0),
      end: const Offset(-1.0, 0.0),
    ).animate(_controller);
  }

  Future<void> getNetworkTime() async {
    DateTime _myTime;
    DateTime _ntpTime;

    /// Or you could get NTP current (It will call DateTime.now() and add NTP offset to it)
    _myTime = await NTP.now();

    /// Or get NTP offset (in milliseconds) and add it yourself
    final int offset = await NTP.getNtpOffset(localTime: DateTime.now());
    _ntpTime = _myTime.add(Duration(milliseconds: offset));

    print('My time: ${_myTime.millisecondsSinceEpoch}');
    print('NTP time: $_ntpTime');
    print('Difference: ${_myTime.difference(_ntpTime).inMilliseconds}ms');
  }

  @override
  Widget build(BuildContext context) {
    DeviceSize size = DeviceSize(context);
    return SafeArea(
        child: Scaffold(
      body: Stack(children: [
        const MainBackGround(),
        Column(children: <Widget>[
          Stack(children: [
            Container(
              height: 7.h,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('assets/images/01_08 1.png'),
                fit: BoxFit.cover,
              )),
            ),
            FittedBox(
              fit: BoxFit.contain,
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return FractionalTranslation(
                    translation: _animation.value,
                    child: child,
                  );
                },
                child: SizedBox(
                  height: 50.h,
                  child: Column(
                    children: [
                      Spacer(),
                      Text(
                        '秋の大会開催中！受け付けは設定から！！プレミアムプラン、今なら半額！',
                        style: TextStyle(fontSize: 80.sp, color: Colors.white),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
            ),
          ]),
          const Spacer(flex: 3),
          Container(
            height: size.height * 0.25,
            width: size.height * 0.25,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      'assets/images/地球.png',
                    ),
                    fit: BoxFit.cover)),
          ),
          const Spacer(flex: 3),
          MainButton(size: size, title: 'START'),
          const Spacer(),
          MainButton(size: size, title: 'PREMIUM'),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                  onTap: () async {
                    var myTime = await NTP.now();
                    print('fdadsaf');
                    print(myTime.microsecondsSinceEpoch);
                  },
                  child: SubButton(size: size, icon: Icons.local_post_office)),
              SubButton(size: size, icon: Icons.edit),
              SubButton(size: size, icon: Icons.settings)
            ],
          ),
          const Spacer(),
        ]),
      ]),
    ));
  }
}
