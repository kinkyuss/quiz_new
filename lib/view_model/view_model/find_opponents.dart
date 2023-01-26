import 'dart:convert';
import 'dart:convert' as convert;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_new/model/my_information.dart';
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
  late var myInformation= _ref.read(myInformationProvider.notifier).state;
  final SoundLogic _soundLogicMain = SoundLogic();
  final SoundLogic _soundLogicSub = SoundLogic();
  final FireStoreLogic _fireStoreLogic = FireStoreLogic();
  get muchState => _ref.watch(muchStateProvider.notifier).state;

  fireStoreWrite(context) async {

    _soundLogicSub.audioPlay('assets/sounds/enter.mp3');
    final now = DateTime.now();
    int unixTime = now.millisecondsSinceEpoch;
    await FirebaseFirestore.instance
        .collection('waitingUsers')
        .doc(myInformation.uid)
        .set({'status': 'waiting', 'updateAt': unixTime});
    await Navigator.pushNamed(context, '/wait');
  }

  findStart(context) async {
   await Future.delayed(const Duration(seconds: 1000), () async {
     Stream<dynamic> stream = _fireStoreLogic.readStream(
       'waitingUsers',
       myInformation.uid,
     );

     stream.listen((newValue) {
       print('newValue='+newValue.data());
       _muchID = newValue.data()['matchedID'];
       _roomID = newValue.data()['roomID'];
       Stream<dynamic> streamMuchID = finalCheck();
       writeMyInformation();
       streamMuchID.listen((newValue) {
         _ref.read(muchStateProvider.notifier).state = 'まもなく開始いたします。';
         try {
           newValue.data()!['${_muchID}information'];
         } catch (e) {
           print('main() finished handling ${e.runtimeType}.');
         }
         Map opponent=newValue.data()!['${_muchID}information'];
         _ref.read(opponentProvider.notifier).state=opponent;
         Navigator.pushNamed(context,'/much');
       });
     });


     Navigator.pop(context);
    });
  }

  finalCheck() {
    _ref.read(muchStateProvider.notifier).state = '対戦相手が見つかりました。';
    _fireStoreLogic.write('rooms', _roomID, myInformation.uid, '王');
    Stream<dynamic> streamMuchID =
        _fireStoreLogic.readStream('rooms', _roomID, );
    return streamMuchID;
  }

  void writeMyInformation() {
    var myInformationJson =
        jsonEncode(_ref.read(myInformationProvider.notifier).state.toJson());
    final myInformationJsonToMap =
        convert.json.decode(myInformationJson) as Map<String, dynamic>;
    _fireStoreLogic.write(
        'rooms', _roomID, myInformation.uid, myInformationJsonToMap);
  }
}
