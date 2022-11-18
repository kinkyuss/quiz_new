import 'package:flutter/material.dart';

class ViOrDe extends StatelessWidget {
  const ViOrDe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceSize = MediaQuery.of(context).textScaleFactor;

    return Scaffold(
        body: Center(
          child: Column(
            children: [
              SizedBox(
                child: Text('勝利',
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: deviceSize * 200,
                        fontWeight: FontWeight.bold)),
                width: deviceWidth * 0.5,
              ),
              SizedBox(
                height: deviceHeight * 0.05,
              ),
              InkWell(
                onTap: ()=>Navigator.pushNamed(context,'/chat_room'),
                child: Container(
                  height: deviceHeight * 0.1,
                  width: deviceWidth * 0.6,
                  margin: EdgeInsets.only(bottom: deviceHeight * 0.02),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(133, 46, 25, 0.8),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                      child: Text('チャット依頼',
                          style: TextStyle(
                              color: Colors.white, fontSize: deviceSize * 30))),
                ),
              ),
              Text(
                'このまま終了',
                style: TextStyle(color: Colors.grey, fontSize: deviceSize * 15),
              )
            ],
        ),
    ));
  }
}
