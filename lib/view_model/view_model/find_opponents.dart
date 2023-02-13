import 'dart:async';
import 'dart:convert';
import 'dart:convert' as convert;
import 'package:ntp/ntp.dart';

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
  late String _matchID;
  late var myInformation = _ref.read(myInformationProvider.notifier).state;
  final SoundLogic _soundLogicMain = SoundLogic();
  final SoundLogic _soundLogicSub = SoundLogic();
  final FireStoreLogic _fireStoreLogic = FireStoreLogic();

  get muchState => _ref.watch(muchStateProvider.state).state;

  fireStoreWrite(context) async {
    print('fireStoreWrite関数に入りました。');
    _soundLogicSub.audioPlay('assets/sounds/enter.mp3');
    var _myTime = await NTP.now();
    await FirebaseFirestore.instance
        .collection('waitingUsers')
        .doc(myInformation.uid)
        .set({'status': 'waiting', 'updateAt': _myTime.microsecondsSinceEpoch});
  }

  findStart(context) async {
    print('findStart関数に入りました。');
    print('uid=${myInformation.uid}');
    Stream<dynamic> stream = _fireStoreLogic.readStream(
      'waitingUsers',
      myInformation.uid,
    );
   stream.timeout(const Duration(seconds: 30)).listen((newValue) async{
      bool exit = newValue.data()['matchedID'] == null ? false : true;
      if ((newValue.data() as Map<String, dynamic>).containsKey("matchedID")) {
        _ref.read(muchStateProvider.notifier).state = '対戦相手が見つかりました。';
        _matchID = newValue.data()['matchedID'];
        _roomID = newValue.data()['roomID'];
        var startTime=newValue.data()['startTime'];
        writeMyInformation();
        Stream<dynamic> streamMuchID = finalCheck();
        print('kita');
        streamMuchID.listen((newValue) async{

          if ((newValue.data() as Map<String, dynamic>)
              .containsKey('${_matchID}information')) {
            print('haitta');
            Map opponent = newValue.data()!['${_matchID}information'];
            print(opponent);
            _ref.read(opponentProvider.notifier).state = opponent;
            _ref.read(matchInformationProvider.notifier).state={'matchID':_matchID,'roomID':_roomID};
            _ref.read(startTimeProvider.notifier).state=startTime;
            print('kita');
             Navigator.pushNamed(context, '/much');
          }
        });
      }
    }, onError: (e) {
     if (e is TimeoutException) {
       Navigator.pop(context);
     }
   });
  }

  // Navigator.pop(context);

  finalCheck() {
    print('finalCheck関数に入りました。');
    print(muchState);
    _fireStoreLogic.write('rooms', _roomID, myInformation.uid, '王');
    Stream<dynamic> streamMuchID = _fireStoreLogic.readStream(
      'rooms',
      _roomID,
    );
    print(streamMuchID);
    return streamMuchID;
  }

  void writeMyInformation() {
    var myInformationJson =
        jsonEncode(_ref.read(myInformationProvider.notifier).state.toJson());
    final myInformationJsonToMap =
        convert.json.decode(myInformationJson) as Map<String, dynamic>;
    _fireStoreLogic.write(
        'rooms', _roomID, '${myInformation.uid}information', myInformationJsonToMap);
  }
}
