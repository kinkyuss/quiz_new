import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_new/view_model/view_model.dart';
import 'package:sizer/sizer.dart';

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
                OftenText(text: 'コースの選択').medium(context),
                SizedBox(height: 1.h),
                customTile('早押しクイズ', 'assets/images/火星.png', 0, size, context),
                customTile('選択クイズ　', 'assets/images/土星.png', 1, size, context)
              ])),
          EnterButton(
            viewModel: viewModel,
          ),
        ],
      )
    ])));
  }

  customTile(String title, String imageFile, int index, DeviceSize size,
      BuildContext context) {
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                      child: Image.asset(
                    imageFile,
                    fit: BoxFit.cover,
                  )),
                ),
                SizedBox(width: 20.w),

                OftenText(text: title).large(context),
                SizedBox(width: 15.w),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
