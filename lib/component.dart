import 'package:flutter/material.dart';

import 'model/device_data.dart';
import 'view_model/view_model.dart';

class OftenText  {
  final String text;
  final double largeFontSize;
  final double mediumFontSize;
  final double smallFontSize;
  final Color color;

  OftenText({
    required this.text,
    this.largeFontSize = 70,
    this.mediumFontSize = 50,
    this.smallFontSize = 30,
    this.color =Colors.white
  });

  Widget large(BuildContext context) {
    DeviceSize size=DeviceSize(context);
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
    DeviceSize size=DeviceSize(context);
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
    DeviceSize size=DeviceSize(context);
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
                  fontSize: size.textScaleFactor * 50,
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
        Icon(icon, size: size.textScaleFactor * 40, color: Colors.white));
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


class EnterButton extends StatelessWidget {
  const EnterButton({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final ViewModel viewModel;

  @override
  Widget build(BuildContext context) {
   DeviceSize size = DeviceSize(context);

    return InkWell(
      enableFeedback: false,
      onTap: () => viewModel.findOpponents(context),
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
                    fontSize: size.textScaleFactor * 40,
                    color: Colors.white),
              ))),
    );
  }
}

class LoadingAnimation extends StatelessWidget {
  const LoadingAnimation({
    Key? key,
    required AnimationController controller,
    required this.size,
  }) : _controller = controller, super(key: key);

  final AnimationController _controller;
  final DeviceSize size;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: _controller.value * 2.0 * 3.141592,
          child: child,
        );
      },
      child: Image.asset("assets/images/globe.png",
          scale: size.textScaleFactor / 1.25),
    );
  }
}

class UserInformation extends StatelessWidget {
  const UserInformation({
    Key? key,
    required this.size,
  }) : super(key: key);

  final DeviceSize size;

  @override
  Widget build(BuildContext context) {
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
                        image:
                        AssetImage('assets/images/guest_icon.png'),
                        fit: BoxFit.cover,
                      ))),
              Text('あなた',
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
              Text('11連勝中!!',
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

//211
