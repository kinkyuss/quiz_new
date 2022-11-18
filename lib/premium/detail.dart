import 'package:flutter/material.dart';

class Detail extends StatelessWidget {
  const Detail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceSize = MediaQuery.of(context).textScaleFactor;

    return Scaffold(
        backgroundColor: const Color.fromRGBO(133, 46, 25, 1),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: deviceHeight * 0.025,
                ),
                SizedBox(
                  height: deviceHeight * 0.02,
                  child: Row(
                    children: [
                      IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          icon: Icon(Icons.arrow_back,
                              size: deviceSize * 35, color: Colors.brown),
                          onPressed: () => Navigator.pop(context)),
                    ],
                  ),
                  //余白,
                ),
                buildSizedBox('ボタンを押すまでの平均時間', '2.4秒', deviceHeight,
                    deviceWidth, deviceSize),
                buildSizedBox(
                    '正答率', '93％', deviceHeight, deviceWidth, deviceSize),
                buildSizedBox(
                    '得意なジャンル', '地理など', deviceHeight, deviceWidth, deviceSize),
                buildSizedBox(
                    '今月のランク', 'D', deviceHeight, deviceWidth, deviceSize),
                SizedBox(
                    height: deviceHeight * 0.28,
                    width: deviceWidth * 0.9,
                    child: Column(children: [
                      SizedBox(height: deviceHeight * 0.05),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('次のランクに達するには....',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: deviceSize * 25)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('正答率を95%以上にする',
                              style: TextStyle(
                                  fontSize: deviceSize * 30,
                                  color: Colors.white))
                        ],
                      )
                    ]))
              ],
            ),
          ),
        ));
  }

  SizedBox buildSizedBox(String key, String value, double deviceHeight,
      double deviceWidth, double deviceSize) {
    return SizedBox(
        height: deviceHeight * 0.28,
        width: deviceWidth * 0.9,
        child: Column(children: [
          SizedBox(height: deviceHeight * 0.05),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(key,
                  style: TextStyle(
                      color: Colors.white, fontSize: deviceSize * 25)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(value,
                  style:
                      TextStyle(fontSize: deviceSize * 80, color: Colors.white))
            ],
          )
        ]));
  }
}
