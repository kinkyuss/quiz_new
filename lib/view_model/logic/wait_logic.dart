import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_new/view_model/provider.dart';

import '../../view/quiz/much.dart';
import '../../view/quiz/wait_test.dart';

class Wait extends ConsumerWidget {
  Wait({Key? key}) : super(key: key);

  String status = '対戦相手を探しています...';

  @override
  Widget build(BuildContext context, ref) {
    var myInformation = ref.read(myInformationProvider.state).state;
    print('uid==');
    print(myInformation.uid);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 30), () async {
        Navigator.pop(context);
      });
    });
    return Scaffold(
        body: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('waitingUsers')
                .doc(myInformation.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text("サーバーに異常があります。");
              } else {
                try {
                  snapshot.data!['roomID'];
                } catch (e) {
                  return WaitTest(status: status);
                }
                String roomID = snapshot.data!['roomID'];
                FirebaseFirestore.instance
                    .collection('rooms')
                    .doc(roomID)
                    .set({myInformation.uid: '王'});
                String matchedID = snapshot.data!['matchedID'];

                return StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('rooms')
                        .doc(roomID)
                        .snapshots(),
                    builder: (context, snapshot) {
                      try {
                        snapshot.data![matchedID];
                      } catch (e) {
                        status = '対戦相手が見つかりました。';
                      }

                      if (snapshot.hasError) {
                        return const Text("サーバーに異常があります。");
                      } else {

                        return Much(
                          roomID: roomID,
                        );
                      }
                    });
              }
            }));
  }
}
