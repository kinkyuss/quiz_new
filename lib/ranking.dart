import 'package:flutter/material.dart';

class Ranking extends StatelessWidget {
  const Ranking({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceSize = MediaQuery.of(context).textScaleFactor;

    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Color.fromRGBO(255, 211, 119, 1),
            const Color.fromRGBO(255, 0, 0, 1),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(children: [
              //余白
              SizedBox(
                height: deviceHeight*0.028,
              ),
              SizedBox(
                height: deviceHeight * 0.02,
                child:              Row(
                  children: [
                    IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: Icon(Icons.arrow_back,
                            size: deviceSize * 35, color: Colors.orange),
                        onPressed: () => Navigator.pop(context)),
                  ],
                ),
                //余白,
              ),
              //タイトル
              Text(
                '秋の大会',
                style:
                    TextStyle(color: Colors.white, fontSize: deviceSize * 45),
              ),
              Text(
                '～9/1から11/25までの100日間～',
                style:
                    TextStyle(fontSize: deviceSize * 20, color: Colors.white),
              ),
              SizedBox(
                height: deviceHeight * 0.01,
              ),
              //総合＆大会用
              SizedBox(
                  width: deviceWidth * 0.9,
                  child: Row(
                    children: [
                      Text(
                        '総合',
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: deviceSize * 40),
                      ),
                      Icon(Icons.expand_more),
                      Spacer(),
                      Container(
                        width: deviceWidth * 0.2,
                        decoration: BoxDecoration(
                          color: Colors.orange.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(200),
                        ),
                        child: Center(
                            child: Text('大会用\n掲示板',
                                style: TextStyle(
                                  color: Colors.white,
                                ))),
                      ),
                    ],
                  )), //ジャンル
              SizedBox(
                height: deviceHeight * 0.51,
                child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        Container(
                          height: deviceHeight * 0.16,
                          child: Row(children: [
                            Container(
                              child: Text('${index + 1}',
                                  style: TextStyle(
                                      color: index == 0
                                          ? Color.fromRGBO(227, 171, 0, 1)
                                          : index == 1
                                              ? Color.fromRGBO(201, 202, 202, 1)
                                              : index == 2
                                                  ? Color.fromRGBO(
                                                      186, 110, 64, 1)
                                                  : Colors.grey
                                                      .withOpacity(0.3),
                                      fontSize: deviceSize * 100)),
                              margin: EdgeInsets.only(
                                  left: deviceWidth * 0.05,
                                  right: deviceWidth * 0.05),
                            ),
                            Column(
                              children: [
                                Container(
                                  width: deviceWidth * 0.2,
                                  height: deviceHeight * 0.13,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: AssetImage(
                                              'assets/images/test_icon.jpg'))),
                                ),
                                Text(
                                  'しみしょー',
                                  style: TextStyle(
                                    fontSize: deviceSize * 15,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              width: deviceWidth * 0.05,
                            ),
                            Column(
                              children: [
                                Text(
                                  '正答率',
                                  style: TextStyle(
                                      fontSize: deviceSize * 25,
                                      color: Colors.white54),
                                ),
                                Text(
                                  '解答数',
                                  style: TextStyle(
                                      fontSize: deviceSize * 25,
                                      color: Colors.white54),
                                ),
                                Text(
                                  '参加日',
                                  style: TextStyle(
                                      fontSize: deviceSize * 25,
                                      color: Colors.white54),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: deviceWidth * 0.08,
                            ),
                            Column(
                              children: [
                                Text(
                                  '９５％',
                                  style: TextStyle(
                                      fontSize: deviceSize * 25,
                                      color: Colors.white54),
                                ),
                                Text(
                                  '３０４問',
                                  style: TextStyle(
                                      fontSize: deviceSize * 25,
                                      color: Colors.white54),
                                ),
                                Text(
                                  '10/4から',
                                  style: TextStyle(
                                      fontSize: deviceSize * 25,
                                      color: Colors.white54),
                                ),
                              ],
                            ),
                          ]),
                        ),
                        Divider(
                          color: const Color.fromRGBO(242, 156, 161, 1),
                          height: deviceHeight * 0.001,
                        )
                      ],
                    );
                  },
                ),
              ),
              SizedBox(
                height: deviceHeight * 0.02,
              ),
              Text(
                'もっと見る',
                style: TextStyle(
                    color: Colors.orange.withOpacity(0.6),
                    fontSize: deviceSize * 20),
              ),
              SizedBox(
                height: deviceHeight * 0.02,
              ),

              Container(
                height: deviceHeight * 0.16,
                child: Row(
                  children: [
                    Container(
                      child: Text('153',
                          style: TextStyle(
                              color: Colors.grey, fontSize: deviceSize * 50)),
                      margin: EdgeInsets.only(right: deviceWidth * 0.04),
                    ),
                    Column(
                      children: [
                        Container(
                          width: deviceWidth * 0.2,
                          height: deviceHeight * 0.13,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage(
                                      'assets/images/test_icon.jpg'))),
                        ),
                        Text(
                          'あなた',
                          style: TextStyle(
                            fontSize: deviceSize * 15,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      width: deviceWidth * 0.05,
                    ),
                    Column(
                      children: [
                        Text(
                          '正答率',
                          style: TextStyle(
                              fontSize: deviceSize * 25, color: Colors.white54),
                        ),
                        Text(
                          '解答数',
                          style: TextStyle(
                              fontSize: deviceSize * 25, color: Colors.white54),
                        ),
                        Text(
                          '参加日',
                          style: TextStyle(
                              fontSize: deviceSize * 25, color: Colors.white54),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ])));
  }
}
