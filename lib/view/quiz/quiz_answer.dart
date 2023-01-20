import 'package:flutter/material.dart';

class QuizAnswer extends StatelessWidget {
  const QuizAnswer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceSize = MediaQuery.of(context).textScaleFactor;

    return Scaffold(
        body: SingleChildScrollView(
      child: Center(
          child: Column(children: [
        SizedBox(
          height: deviceHeight * 0.01,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          SizedBox(
            height: deviceHeight * 0.12,
          ),
          CircleAvatar(
            radius: 30,
            backgroundColor: const Color.fromRGBO(244, 179, 194, 1),
            child: Text(
              '5',
              style: TextStyle(
                  color: const Color.fromRGBO(177, 29, 44, 1),
                  fontSize: deviceSize * 40),
            ),
          ),
        ]),
        SizedBox(
          width: deviceWidth * 0.6,
          height: deviceHeight * 0.2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '1/5',
                style: TextStyle(
                  fontSize: deviceSize * 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '世界で一番高い山の',
                style: TextStyle(
                  fontSize: deviceSize * 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '名前を答えよ',
                style: TextStyle(
                  fontSize: deviceSize * 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: deviceHeight * 0.1,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: ()=>Navigator.pushNamed(context,'/vi_or_de'),
              child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.black26,
                  child: Text(
                    'あ',
                    style:
                        TextStyle(color: Colors.white, fontSize: deviceSize * 45),
                  )),
            ),
            CircleAvatar(
                radius: 50,
                backgroundColor: Colors.black26,
                child: Text(
                  'あ',
                  style:
                      TextStyle(color: Colors.white, fontSize: deviceSize * 45),
                )),
            CircleAvatar(
                radius: 50,
                backgroundColor: Colors.black26,
                child: Text(
                  'あ',
                  style:
                      TextStyle(color: Colors.white, fontSize: deviceSize * 45),
                )),
          ],
        ),
        SizedBox(
          height: deviceHeight * 0.025,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          CircleAvatar(
              radius: 50,
              backgroundColor: Colors.black26,
              child: Text(
                'あ',
                style:
                    TextStyle(color: Colors.white, fontSize: deviceSize * 45),
              )),
          CircleAvatar(
              radius: 50,
              backgroundColor: Colors.black26,
              child: Text(
                'あ',
                style:
                    TextStyle(color: Colors.white, fontSize: deviceSize * 45),
              )),
          CircleAvatar(
              radius: 50,
              backgroundColor: Colors.black26,
              child: Text(
                'あ',
                style:
                    TextStyle(color: Colors.white, fontSize: deviceSize * 45),
              )),
        ]),
        SizedBox(
            height: deviceHeight * 0.15,
            child: TextFormField(
              maxLength: 100,
              decoration: const InputDecoration(
                filled: false,
                hintText: '回答入力',
                labelText: '回答',
              ),
            ))
      ])),
    ));
  }
}
