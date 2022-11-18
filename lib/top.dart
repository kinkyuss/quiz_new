import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Top extends StatelessWidget {
  const Top({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceSize = MediaQuery.of(context).textScaleFactor;

    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            InkWell(
              // onTap: ()=>Navigator.pushNamed(context,'/ranking'),
              onTap:()async{
                await FirebaseFirestore.instance
                    .collection('users') // コレクションID
                    .doc('id_abc') // ドキュメントID
                    .set({'name': '鈴木', 'age': 40}); // データ
              },
              child: Container(
                width: double.infinity,
                height: deviceHeight * 0.15,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: FractionalOffset.topLeft,
                      end: FractionalOffset.bottomRight,
                      colors: [
                        Colors.red.withOpacity(0.5),
                        const Color.fromRGBO(255, 165, 0, 0.5)
                      ],
                      stops: const [
                        0.0,
                        1.0,
                      ],
                    ),
                    color: Colors.lightGreenAccent,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(deviceSize * 90),
                      bottomRight: Radius.circular(deviceSize * 90),
                    )),
                child: Column(
                  children: [
                    SizedBox(
                      height: deviceHeight * 0.025,
                    ),
                    Text(
                      '秋の大会開催中！',
                      style: TextStyle(
                          fontSize: deviceSize * 30, fontWeight: FontWeight.bold),
                    ),
                    Text('詳細はここをタップ！',
                        style: TextStyle(
                            fontSize: deviceSize * 30,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: deviceHeight * 0.075,
            ),
            SizedBox(
                height: deviceHeight * 0.35,
                child: Image.asset('assets/images/PQP-logo.png')),
            SizedBox(
              height: deviceHeight * 0.075,
            ),
            InkWell(
              onTap: (){
                Navigator.pushNamed(context,'/choice');
              },
              child: Container(
                height: deviceHeight * 0.1,
                width: deviceWidth * 0.6,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(242, 156, 161, 1),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                    child: Text('クイズを始める',
                        style: TextStyle(
                            color: Colors.white, fontSize: deviceSize * 30))),
              ),
            ),
            SizedBox(
              height: deviceHeight * 0.04,
            ),
            InkWell(
              onTap: ()=>Navigator.pushNamed(context, '/premium'),
              child: Container(
                height: deviceHeight * 0.1,
                width: deviceWidth * 0.6,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(133, 46, 25, 0.8),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                    child: Text('プレミアム機能',
                        style: TextStyle(
                            color: Colors.white, fontSize: deviceSize * 30))),
              ),
            ),
            SizedBox(
              height: deviceHeight * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.settings,color: Colors.grey,size: deviceSize*35,),
                Text('設定',style: TextStyle(color:Colors.grey,fontSize: deviceSize*30),)

              ],
            )


          ],
        ),
      ),
    );
  }
}
