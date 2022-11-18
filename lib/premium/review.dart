import 'package:flutter/material.dart';

class Review extends StatefulWidget {
  const Review({Key? key}) : super(key: key);

  @override
  State<Review> createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  List tapIndex = [];

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceSize = MediaQuery.of(context).textScaleFactor;

    return Scaffold(
        backgroundColor: const Color.fromRGBO(133, 46, 25, 1),
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: deviceHeight * 0.025,
              ),
              SizedBox(
                height: deviceHeight * 0.015,
                child: Row(
                  children: [
                    IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: Icon(
                          color: Colors.black45,
                          Icons.arrow_back,
                          size: deviceSize * 35,
                        ),
                        onPressed: () => Navigator.pop(context)),
                  ],
                ),
                //余白,
              ),
              SizedBox(
                height: deviceHeight * 0.03,
              ),
              SizedBox(
                  width: deviceWidth * 0.9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Opacity(
                          opacity: 0.6,
                          child: Icon(
                            Icons.tune,
                            size: deviceSize * 50,
                          )),
                      Text(
                        'テストする',
                        style: TextStyle(
                            color: Colors.white, fontSize: deviceSize * 25),
                      )
                    ],
                  )),
              SizedBox(
                height: deviceHeight * 0.866,
                width: deviceWidth * 0.9,
                child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                          margin: EdgeInsets.only(bottom: deviceHeight * 0.05),
                          height: tapIndex.contains(index)
                              ? deviceHeight * 0.6
                              : deviceHeight * 0.37,
                          color: index % 2 == 0
                              ? Color.fromRGBO(242, 156, 161, 1)
                              : Colors.lightBlueAccent,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        child: Text(
                                          '問題',
                                          style: TextStyle(
                                              fontSize: deviceSize * 35),
                                        ),
                                        height: deviceHeight * 0.15,
                                      ),
                                      Text(
                                        '解答',
                                        style: TextStyle(
                                            fontSize: deviceSize * 25),
                                      ),
                                      Text(
                                        '正答',
                                        style: TextStyle(
                                            fontSize: deviceSize * 30),
                                      )
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      //文字数overの場合リストみたいな感じで開けるようにする
                                      SizedBox(
                                        child: Text(
                                          '世界で一番高い山は\nどこでしょうか？',
                                          style: TextStyle(
                                              fontSize: deviceSize * 35),
                                        ),
                                        height: deviceHeight * 0.15,
                                      ),

                                      Text('富士山',
                                          style: TextStyle(
                                              fontSize: deviceSize * 25,
                                              decoration: index % 2 == 0
                                                  ? null
                                                  : TextDecoration
                                                      .lineThrough)),
                                      Text('エベレスト',
                                          style: TextStyle(
                                              fontSize: deviceSize * 30)),
                                    ],
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    '正答率 93%',
                                    style: TextStyle(
                                        fontSize: deviceSize * 30,
                                        color: Colors.red),
                                  ),
                                ],
                              ),
                              tapIndex.contains(index)
                                  ? InkWell(
                                      child: Opacity(
                                        opacity: 0.6,
                                        child: Row(children: [
                                          Text('解説を非表示'),
                                          Icon(Icons.arrow_circle_up),
                                          SizedBox(
                                            width: deviceWidth * 0.5,
                                          )
                                        ]),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          tapIndex.remove(index);
                                        });
                                      },
                                    )
                                  : InkWell(
                                      child: Opacity(
                                        opacity: 0.6,
                                        child: Row(children: [
                                          Text('解説を表示'),
                                          Icon(Icons.arrow_circle_down),
                                          SizedBox(
                                            width: deviceWidth * 0.5,
                                          )
                                        ]),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          tapIndex.add(index);
                                        });
                                      },
                                    ),
                              textJudge(index, deviceSize)
                            ],
                          ));
                    }),
              ),
            ],
          ),
        ));
  }

  textJudge(index, deviceSize) {
    if (tapIndex.contains(index)) {
      return Text(
        'エベレストは世界一高い山で、標高は約8848.86mといわれています。\nちなみに、日本一高い山は富士山で約3,776mです。',
        style: TextStyle(fontSize: deviceSize * 25),
      );
    } else {
      return SizedBox.shrink();
    }
  }
}
