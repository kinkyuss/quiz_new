import 'package:flutter/material.dart';

class CourseChoice extends StatefulWidget {
  const CourseChoice({Key? key}) : super(key: key);

  @override
  State<CourseChoice> createState() => _CourseChoiceState();
}

class _CourseChoiceState extends State<CourseChoice> {
  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceSize = MediaQuery.of(context).textScaleFactor;

    return SafeArea(
      child: Scaffold(
        body: Stack(children: [
          Container(
            height: deviceHeight * 1,
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/images/utyuu 1.png'),
              fit: BoxFit.cover,
            )),
          ),
          Column(
            children: [
              SizedBox(
                height: deviceHeight * 0.15,
              ),
              Container(
                width: deviceWidth * 1,
                color: Colors.black,
                height: deviceHeight * 0.6,
                child: Column(
                  children: [
                    Text('コースの選択',
                        style: TextStyle(
                            color: Colors.white, fontSize: deviceSize * 30)),
                    Divider(
                      color: Colors.grey,
                      height: deviceHeight * 0.01,
                    ),
                    Container(
                      height: deviceHeight * 0.25,
                      color: Colors.red,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: deviceWidth * 0.3,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage('assets/images/火星.png'),
                            )),
                          ),
                          Text(
                            '早押しクイズ',
                            style: TextStyle(
                                color: Colors.white, fontSize: deviceSize * 40),
                          )
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.grey,
                      height: deviceHeight * 0.01,
                    ),
                Container(
                  height: deviceHeight * 0.25,

                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: deviceWidth * 0.3,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/土星.png'),
                            )),
                      ),
                      Text(
                        '選択クイズ',
                        style: TextStyle(
                            color: Colors.white, fontSize: deviceSize * 40),
                      )
                    ],
                  ),
                ),
                  ],
                ),
              ),
              SizedBox(
                height: deviceHeight*0.075,
              ),
              Container(
                  height: deviceHeight*0.08,
                  width:deviceWidth*0.4,
                  decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.grey),
                    color: Colors.orangeAccent,
                    borderRadius: BorderRadius.circular(20),

                  ),
                  child:Center(child: Text('GO!',style: TextStyle(                          fontStyle: FontStyle.italic,
                      fontSize: deviceSize*40,color:Colors.white),))

              ),

            ],
          )
        ]),
      ),
    );
  }
}
