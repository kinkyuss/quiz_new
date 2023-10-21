import 'dart:async';
import 'dart:convert';
import 'dart:convert' as convert;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ntp/ntp.dart';
import 'package:quiz_new/view_model/logic/firestore_logic.dart';

import '../../model/questions_relation/problem_sets_list.dart';
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
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.currentUser!.updateDisplayName('基本');
    await FirebaseFirestore.instance
        .collection('waitingUsers')
        .doc(myInformation.uid)
        .set({'status': 'waiting', 'updateAt': _myTime.microsecondsSinceEpoch,'uid':auth.currentUser!.displayName});

  }

  findStart(context) async {
    print('findStart関数に入りました。');
    print('uid=${myInformation.uid}');
    Stream<dynamic> stream = _fireStoreLogic.readStream(
      'waitingUsers',
      myInformation.uid,
    );

    bool process = false;
    stream.timeout(const Duration(seconds: 30)).listen((newValue) async {
      bool exit = newValue.data()['matchedID'] == null ? false : true;
      if ((newValue.data() as Map<String, dynamic>).containsKey("matchedID")) {

        _ref.read(muchStateProvider.notifier).state = '対戦相手が見つかりました。';
        _matchID = newValue.data()['matchedID'];
        _roomID = newValue.data()['roomID'];
        List <dynamic>questionDynamics= newValue.data()['questionNumbers'];
        List<int> questionNumbers = questionDynamics.map((item) => int.parse(item.toString())).toList();
        var startTime = newValue.data()['startTime'];
        writeMyInformation();
        Stream<dynamic> streamMuchID = finalCheck();
        List <String>questions=[];
        List <String>answers=[];
        List <String > commentarys=[];

        List <List<String>> similarAnswers=[];
        List <String >answerForSelects=[];


        for (dynamic questionNumber in questionNumbers) {

          final snapshot = await FirebaseFirestore.instance.collection('quiz').doc(questionNumber.toString()).get();
          final data=snapshot.data();
          questions.add(data!['question']);
          answers.add(data['answer']);
          commentarys.add(data['commentary']);
          similarAnswers.add(List<String>.from(data['similarAnswer'].map<String>((item) => item.toString())));
          answerForSelects.add(data['answerForSelect']);
        }
        ProblemSetsList set=ProblemSetsList(
          question:  questions,
          answerForSelect: answerForSelects,
          similarAnswer: similarAnswers,
          commentary: commentarys,
          answer: answers
        );
        _ref.read(problemSetsListProvider.notifier).state=set;
        var _streamSubscription = streamMuchID.listen((newValue) async {
          if ((newValue.data() as Map<String, dynamic>)
              .containsKey('${_matchID}information')) {
            print('hdddaitta');
            Map opponent = newValue.data()!['${_matchID}information'];
            print(opponent);
            _ref.read(opponentProvider.notifier).state = opponent;
            _ref.read(matchInformationProvider.notifier).state = {
              'matchID': _matchID,
              'roomID': _roomID
            };
            _ref.read(startTimeProvider.notifier).state = startTime;

            print('kita');
            process = true;
            Navigator.pushReplacementNamed(context, '/much');
          }
        });
        print('kokoni');
        // if(process) {
        //   _streamSubscription.cancel();
        // }
      }
    }, onError: (e) {
      // if (e is TimeoutException) {
      //   Navigator.pop(context);
      // }
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
    _fireStoreLogic.write('rooms', _roomID, '${myInformation.uid}information',
        myInformationJsonToMap);
  }
}
