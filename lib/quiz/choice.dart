import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Choice extends StatelessWidget {
   Choice({Key? key}) : super(key: key);

  final userUid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceSize = MediaQuery.of(context).textScaleFactor;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(242, 156, 161, 1),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: deviceHeight * 0.0275,
            ),
            Row(
              children: [
                IconButton(
                    icon: Icon(Icons.arrow_back,
                        size: deviceSize * 35, color: Colors.redAccent),
                    onPressed: () => Navigator.pop(context)),
              ],
            ),
            Text(
              'あなたが得意なジャンルを\n選択してください\n(複数選択可)',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: deviceSize * 30),
            ),
            SizedBox(
              height: deviceHeight * 0.05,
            ),
            Container(
                margin: EdgeInsets.only(bottom: deviceSize * 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: deviceHeight * 0.2,
                      width: deviceWidth * 0.25,
                      color: Colors.black54,
                    ),
                    Container(
                      height: deviceHeight * 0.2,
                      width: deviceWidth * 0.25,
                      color: Colors.black54,
                    ),
                    Container(
                      height: deviceHeight * 0.2,
                      width: deviceWidth * 0.25,
                      color: Colors.black54,
                    ),
                  ],
                )),
            Container(
                margin: EdgeInsets.only(bottom: deviceSize * 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: deviceHeight * 0.2,
                      width: deviceWidth * 0.25,
                      color: Colors.black54,
                    ),
                    Container(
                      height: deviceHeight * 0.2,
                      width: deviceWidth * 0.25,
                      color: Colors.black54,
                    ),
                    Container(
                      height: deviceHeight * 0.2,
                      width: deviceWidth * 0.25,
                      color: Colors.black54,
                    ),
                  ],
                )),
            Row(
              children: [
                SizedBox(width: deviceWidth * 0.7),
                Opacity(
                  opacity: 0.6,
                  child: Text('すべて選択',
                      style: TextStyle(
                          color: Colors.pinkAccent, fontSize: deviceSize * 20)),
                ),
              ],
            ),
            InkWell(
              onTap: () async {
                print('s');
                final now = DateTime.now();
                int unixtime = now.millisecondsSinceEpoch;
                await  FirebaseFirestore.instance
                    .collection('waitingUsers')
                    .doc(userUid)
                    .set({'status':'waiting','updateAt':unixtime});



                Navigator.pushNamed(context, '/wait');
              },
              child: Container(
                margin: EdgeInsets.only(
                    bottom: deviceHeight * 0.015, top: deviceHeight * 0.0275),
                height: deviceHeight * 0.1,
                width: deviceWidth * 0.6,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(250, 128, 114, 1),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                    child: Text('OK',
                        style: TextStyle(
                            color: Colors.white, fontSize: deviceSize * 30))),
              ),
            ),
            Opacity(
              opacity: 0.75,
              child: Text('スキップ',
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: deviceSize * 20)),
            )
          ],
        ),
      ),
    );
  }
}
