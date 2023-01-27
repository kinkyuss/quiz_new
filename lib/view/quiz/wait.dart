import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_new/component.dart';
import 'package:quiz_new/view_model/provider.dart';
import 'package:quiz_new/view_model/view_model/find_opponents.dart';

import '../../model/device_data.dart';

class Wait extends HookWidget {
   const Wait({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    FindOpponents model=FindOpponents();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      model.fireStoreWrite(context);
      model.findStart(context);
    });

    final animationController =
        useAnimationController(duration: const Duration(seconds: 7));
    animationController.repeat();

    return Stack(children: [
      const MainBackGround(),
      Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
            const Spacer(flex: 2),
            Consumer(builder:((context,ref,child){
              model.setRef(ref);
              return OftenText(text:model.muchState).small(context);})),
            const Spacer(),
            LoadingAnimation(controller: animationController),
            const Spacer(flex: 2),
            const ColumnFlame()
          ])),
    ]);
  }
}

