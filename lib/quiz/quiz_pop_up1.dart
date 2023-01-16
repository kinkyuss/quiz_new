import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class QuizPopUp1 extends StatelessWidget {
  QuizPopUp1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceSize = MediaQuery.of(context).textScaleFactor;
    FocusNode _focusNode = FocusNode();
    String roomID = ModalRoute.of(context)!.settings.arguments as String;
 print(roomID);

   return  StreamBuilder<DocumentSnapshot>(

      //表示したいFiresotreの保存先を指定
        stream: FirebaseFirestore.instance
            .collection('rooms')
            .doc(roomID)
            .snapshots(),
        //streamが更新されるたびに呼ばれる
        builder: (context, snapshot) {
    if (snapshot.hasError) {
    return Text("Something went wrongです");
    }

      final room = snapshot.data;
    try {
print(room!['showDialog']);
    } catch (e) {
      return SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Stack(children: [
              Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/早押しクイズ背景.png'),
                      fit: BoxFit.cover,
                    )),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border:
                            Border.all(width: 4, color: Colors.tealAccent),
                            color: Colors.teal,
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                              begin: FractionalOffset.topLeft,
                              end: FractionalOffset.bottomRight,
                              colors: [Colors.teal, Colors.tealAccent],
                              stops: const [
                                0.0,
                                1.0,
                              ],
                            )),
                        height: deviceHeight * 0.4,
                        width: double.infinity,
                        child: FittedBox(
                          child: Text(     '世界で一番高い山の名前をこたえよ',
                               style: TextStyle(
                                  color: Colors.white,
                                   fontSize: deviceSize * 20,
                                    decoration: TextDecoration.none,
                          ),
                          // child: AnimatedTextKit(
                          //   animatedTexts: [
                          //     TyperAnimatedText(
                          //       '世界で一番高い山の名前をこたえよ',
                          //       textStyle: TextStyle(
                          //         color: Colors.white,
                          //         fontSize: deviceSize * 20,
                          //         decoration: TextDecoration.none,
                          //       ),
                          //       speed: const Duration(milliseconds: 200),
                          //     ),
                          //   ],
                          //   totalRepeatCount: 1,
                          // ),
                        ),
                      )),
                      SizedBox(
                        height: deviceHeight * 0.07,
                      ),
                      // TextField(focusNode: _focusNode),
                      InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: SizedBox(
                                  height: deviceHeight * 0.14,
                                  child: Column(
                                    children: [
                                      TextField(
   //                                     autofocus: true,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: '答えを入力してください。',
                                        ),
                                      ),
                                      TextButton(
                                        child: Text('決定'),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },

                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                            height: deviceWidth * 0.5,
                            width: deviceWidth * 0.5,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/早押しクイズ.png'),
                                    fit: BoxFit.cover))),
                      ),
                      SizedBox(
                        height: deviceHeight * 0.06,
                      ),
                      Table(
                        border: TableBorder.all(color: Colors.black),
                        columnWidths: const <int, TableColumnWidth>{},
                        defaultVerticalAlignment: TableCellVerticalAlignment
                            .top,
                        children: [
                          TableRow(children: [
                            tableContainer(deviceHeight, deviceSize, ''),
                            tableContainer(deviceHeight, deviceSize, '1回目'),
                            tableContainer(deviceHeight, deviceSize, '2回目'),
                            tableContainer(deviceHeight, deviceSize, '3回目'),
                            tableContainer(deviceHeight, deviceSize, '4回目'),
                            tableContainer(deviceHeight, deviceSize, '5回目'),
                          ]),
                          TableRow(children: [
                            tableContainer(deviceHeight, deviceSize, 'あなた'),
                            tableContainer(deviceHeight, deviceSize, '〇'),
                            tableContainer(deviceHeight, deviceSize, ''),
                            tableContainer(deviceHeight, deviceSize, ''),
                            tableContainer(deviceHeight, deviceSize, ''),
                            tableContainer(deviceHeight, deviceSize, ''),
                          ]),
                          TableRow(children: [
                            tableContainer(deviceHeight, deviceSize, 'しみしょー'),
                            tableContainer(deviceHeight, deviceSize, '×'),
                            tableContainer(deviceHeight, deviceSize, ''),
                            tableContainer(deviceHeight, deviceSize, ''),
                            tableContainer(deviceHeight, deviceSize, ''),
                            tableContainer(deviceHeight, deviceSize, ''),
                          ]),
                        ],
                      ),
                    ]),
              ),
            ]),
          ),
        ),
      );
    }



        SchedulerBinding.instance.addPostFrameCallback((_) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Dialog Title'),
                content: Text('Dialog Content'),
                actions: [
                  ElevatedButton(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        });
      return Container(

      );










        });}


  Container tableContainer(
      double deviceHeight, double deviceSize, String title) {
    return Container(
      color: Colors.green,
      height: deviceHeight * 0.05,
      child: FittedBox(
          child: Text(title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                decoration: TextDecoration.none,
              ))),
    );
  }
}
