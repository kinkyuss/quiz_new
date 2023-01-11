import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
class Top extends StatefulWidget {
  Top();

  @override
  _TopState createState() => _TopState();
}

class _TopState extends State<Top> with SingleTickerProviderStateMixin   {
  late AnimationController _controller;
  late Animation<Offset> _animation;

// audioファイルのpathを指定します。
  @override
  void initState() {

    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 25),
    );

    _controller.repeat();
    _animation = Tween<Offset>(
      begin: Offset(1.0, 0.0),
      end: Offset(-1.0, 0.0),
    ).animate(_controller);


  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceSize = MediaQuery.of(context).textScaleFactor;

    return SafeArea(
        child: Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/images/utyuu 1.png'),
          fit: BoxFit.cover,
        )),
        child: Center(
          child: Column(children: <Widget>[
            Stack(children: [
              Container(
                height: deviceHeight * 0.075,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('assets/images/01_08 1.png'),
                  fit: BoxFit.cover,
                )),
              ),
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return FractionalTranslation(
                        translation: _animation.value,
                        child: child,
                      );
                    },
                    child: Text(
                      '秋の大会開催中！受け付けは設定から！！プレミアムプラン、今なら半額！',
                      style: TextStyle(
                          fontSize: deviceSize * 35, color: Colors.white),
                    ),
                  )),
            ]),
            SizedBox(
              height: deviceHeight * 0.1,
            ),
            Container(
                height: deviceHeight * 0.25,
                width: deviceWidth * 0.4,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('assets/images/globe.png'),
                  fit: BoxFit.cover,
                ))),
            SizedBox(
              height: deviceHeight * 0.08,
            ),
            InkWell(
                onTap: () async {


                  Navigator.pushNamed(context, '/course_choice');
                },
                child: Container(
                    height: deviceHeight * 0.125,
                    width: deviceWidth * 0.8,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 2),
                      color: Colors.white.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: Text(
                        'START',
                        style: TextStyle(
                          color: Colors.white,
                          fontStyle: FontStyle.italic,
                          fontSize: 50,
                        ),
                      ),
                    ))),
            SizedBox(
              height: deviceHeight * 0.04,
            ),
            InkWell(
                onTap: () => Navigator.pushNamed(context, '/premium'),
                child: Container(
                    height: deviceHeight * 0.125,
                    width: deviceWidth * 0.8,
                    decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.orangeAccent),
                      color: Colors.white.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: Text(
                        'PREMIUM',
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.white,
                          fontSize: 50,
                        ),
                      ),
                    ))),
            SizedBox(
              height: deviceHeight * 0.02,
            ),
            SizedBox(
              width: deviceWidth * 0.8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.grey),
                        color: Colors.white.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(30),
                      ),
                  child:Icon(Icons.local_post_office,size: deviceSize*40,color:Colors.white)
                  ),
                  Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.grey),
                        color: Colors.white.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(30),
                      ),
                  child:Icon(Icons.edit,color:Colors.white,size:deviceSize*40)),
                  Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.grey),
                        color: Colors.white.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(30),

                      ),
                      child:Icon(Icons.settings,size: deviceSize*40,color:Colors.white)

                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    ));
  }
}
