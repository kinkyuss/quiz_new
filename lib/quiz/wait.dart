import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quiz_new/quiz/quiz_pop_up.dart';

class Wait extends StatefulWidget {
  Wait({Key? key}) : super(key: key);

  @override
  State<Wait> createState() => _WaitState();
}

class _WaitState extends State<Wait> {
  final userUid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<DocumentSnapshot>(

            //表示したいFiresotreの保存先を指定
            stream: FirebaseFirestore.instance
                .collection('waitingUsers')
                .doc(userUid)
                .snapshots(),
            //streamが更新されるたびに呼ばれる
            builder: (context, snapshot) {
              Text('dfasfdasfd');
              if (snapshot.hasError) {
                return Text("Something went wrongです");
              } else {
                print('対戦相手が見つかりました');
                try {
                  snapshot.data!['roomID'];
                } catch (e) {
                  return Text('対戦相手を探しています...');
                }
                String roomID = snapshot.data!['roomID'];
                FirebaseFirestore.instance
                    .collection('rooms')
                    .doc(roomID)
                    .set({userUid: '王'}, SetOptions(merge: true)).timeout(
                        Duration(seconds: 30),
                        onTimeout: () => Navigator.pushNamed(context, '/top'));

                String matchedID = snapshot.data!['matchedID'];

                return StreamBuilder<DocumentSnapshot>(

                    //表示したいFiresotreの保存先を指定
                    stream: FirebaseFirestore.instance
                        .collection('rooms')
                        .doc(roomID)
                        .snapshots(),
                    //streamが更新されるたびに呼ばれる
                    builder: (context, snapshot) {
                      try {
                        snapshot.data![matchedID];
                      } catch (e) {
                        return Text('roomsの二人が書き込まれていません。');
                      }

                      if (snapshot.hasError) {
                        return Text("Something went wrong");
                      }

                      // if (snapshot.connectionState == ConnectionState.waiting)
                      else {

                        return QuizPopUp();
                      }
                    });
                return Text('baka');
              }
            }));
  }
}
