import 'dart:convert';
import 'dart:convert' as convert;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_new/view_model/logic/count_down_logic.dart';
import 'package:quiz_new/view_model/provider.dart';

import '../model/chosen_data.dart';
import '../model/questions_relation/problem_set.dart';
import '../model/questios_relation.dart';
import 'logic/sound_logic.dart';

class ViewModel {

   late WidgetRef _ref;
   final SoundLogic _soundLogicMain = SoundLogic();
   final SoundLogic _soundLogicSub = SoundLogic();

   void setRef(WidgetRef ref) {
     _ref = ref;
   }

   get chosenTileColors => _ref.watch(chosenProvider.state).state.chosenTilesColors;
   get enterTileColor=> _ref.watch(chosenProvider.state).state.enter;

   openCourseChoiceDart(){
   }

  chosenTile(int index){
   _soundLogicSub.audioPlay('assets/sounds/chosen.mp3');
    ChosenData chosenData=ChosenData();
    chosenData.colorChange(index);
    _ref.read(chosenProvider.state).state = chosenData;
    }
  }

