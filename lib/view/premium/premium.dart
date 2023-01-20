import'package:flutter/material.dart';

class PremiumMain extends StatelessWidget {
  const PremiumMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceSize = MediaQuery.of(context).textScaleFactor;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(133, 46, 25, 1),
      body:Center(
        child: Column(
          children: [
            SizedBox(
              height:deviceHeight*0.04
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
  height: deviceHeight*0.015,
),
            Text('プレミアム機能',style:TextStyle(color: Color.fromRGBO(255, 215, 0,1),fontSize: deviceSize*50)),
          InkWell(
            onTap: ()=>Navigator.pushNamed(context, '/review'),
              child: buildContainer('復習する',deviceHeight, deviceWidth, deviceSize)),
          InkWell(
            onTap: ()=>Navigator.pushNamed(context, '/detail'),
            child: buildContainer('データ',deviceHeight, deviceWidth, deviceSize),
          ),
            InkWell(onTap: ()=>Navigator.pushNamed(context, '/'),child: buildContainer('友達対戦',deviceHeight, deviceWidth, deviceSize)),


          ],
        ),
      )
    );

  }

  Container buildContainer(String title,double deviceHeight, double deviceWidth, double deviceSize,) {
    return Container(
         margin: EdgeInsets.only(top:deviceHeight*0.05),
          height: deviceHeight * 0.18,
          width: deviceWidth * 0.7,
          decoration: BoxDecoration(
            color:  Colors.red,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
              child: Text(title,
                  style: TextStyle(
                      color: Colors.white, fontSize: deviceSize * 30))),
        );
  }
}
