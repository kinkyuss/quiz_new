import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_new/view_model/view_model.dart';

import '../component.dart';
import '../model/device_data.dart';

class CourseChoice extends ConsumerWidget {
  CourseChoice({Key? key}) : super(key: key);

  final viewModel = ViewModel();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    viewModel.openCourseChoiceDart();
    viewModel.setRef(ref);
    DeviceSize size = DeviceSize(context);

    return SafeArea(
        child: Scaffold(
            body: Stack(children: [
      const MainBackGround(),
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
              color: Colors.black,
              height: size.height * 0.6,
              child: Column(children: [
                OftenText(text: 'コースの選択').small(context),
                customTile('早押しクイズ', 'assets/images/火星.png', 0, size,context),
                customTile('選択クイズ', 'assets/images/土星.png', 1, size,context)
              ])),
          EnterButton(
            viewModel: viewModel,
          ),
        ],
      )
    ])));
  }

  customTile(String title, String imageFile, int index, DeviceSize size,BuildContext context) {
    return Column(
      children: [
        //区切り線
        Divider(
          color: Colors.grey,
          height: size.height * 0.02,
        ),
        //押したら赤くなるようにしている。
        InkWell(
          enableFeedback: false,
          onTap: () => viewModel.chosenTile(index),
          child: Container(
            height: size.height * 0.25,
            color: viewModel.chosenTileColors[index],
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: size.width * 0.3,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage(imageFile),
                  )),
                ),
                OftenText(text: title,mediumFontSize: 40).medium(context),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
