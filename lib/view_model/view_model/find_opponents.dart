import 'dart:convert';
import 'dart:convert' as convert;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_new/view_model/logic/firestore_logic.dart';

import '../logic/sound_logic.dart';
import '../provider.dart';

class FindOpponents {
  late WidgetRef _ref;

  void setRef(WidgetRef ref) {
    print('hairimasita');
    _ref = ref;
  }

  late String _roomID;
  late String _muchID;
  late var myInformation = _ref.read(myInformationProvider.notifier).state;
  final SoundLogic _soundLogicMain = SoundLogic();
  final SoundLogic _soundLogicSub = SoundLogic();
  final FireStoreLogic _fireStoreLogic = FireStoreLogic();

  get muchState => _ref.watch(muchStateProvider.state).state;

  fireStoreWrite(context) async {
    print('fireStoreWrite関数に入りました。');
    _soundLogicSub.audioPlay('assets/sounds/enter.mp3');
    final now = DateTime.now();
    int unixTime = now.millisecondsSinceEpoch;
    await FirebaseFirestore.instance
        .collection('waitingUsers')
        .doc(myInformation.uid)
        .set({'status': 'waiting', 'updateAt': unixTime});
    print('/waitに遷移しました。');
    await Navigator.pushNamed(context, '/wait');
  }

  findStart(context) async {
    print('findStart関数に入りました。');
    print('uid=${myInformation.uid}');
    Stream<dynamic> stream = _fireStoreLogic.readStream(
      'waitingUsers',
      myInformation.uid,
    );
    stream.listen((newValue) {
      bool exit = newValue.data()['matchedID'] == null ? false : true;
      if ((newValue.data() as Map<String, dynamic>).containsKey("matchedID")) {
        _muchID = newValue.data()['matchedID'];
        _roomID = newValue.data()['roomID'];
        writeMyInformation();
        Stream<dynamic> streamMuchID = finalCheck();
        streamMuchID.listen((newValue) {
          if ((newValue.data() as Map<String, dynamic>)
              .containsKey('${_muchID}information')) {
            Map opponent = newValue.data()!['${_muchID}information'];
            print('相手の情報はこちら→$opponent');
            _ref.read(opponentProvider.notifier).state = opponent;
            print('riverpodへ');
            Navigator.pushNamed(context, '/much');
          }
        });
      }
    });
  }

  // Navigator.pop(context);

  finalCheck() {
    print('finalCheck関数に入りました。');
    _ref.read(muchStateProvider.notifier).state = '対戦相手が見つかりました。';
    print(muchState);
    _fireStoreLogic.write('rooms', _roomID, myInformation.uid, '王');
    Stream<dynamic> streamMuchID = _fireStoreLogic.readStream(
      'rooms',
      _roomID,
    );
    return streamMuchID;
  }

  void writeMyInformation() {
    var myInformationJson =
        jsonEncode(_ref.read(myInformationProvider.notifier).state.toJson());
    final myInformationJsonToMap =
        convert.json.decode(myInformationJson) as Map<String, dynamic>;
    _fireStoreLogic.write(
        'rooms', _roomID, '${_muchID}information', myInformationJsonToMap);
  }
}
