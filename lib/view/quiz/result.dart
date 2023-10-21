import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:quiz_new/component.dart';
import 'package:sizer/sizer.dart';

class Result extends StatelessWidget {
  const Result({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        MainBackGround(),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 10.h),
            Container(
              child: BorderedText(
                  strokeWidth: 2.0.w,
                  //縁の太さ
                  strokeColor: Colors.blue,
                  child: Text('勝者',
                      style: TextStyle(fontSize: 45.sp, color: Colors.white))),
            ),
            Row(
              children: [
                Container(
                  width: 30.w,
                  height: 30.w,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage('assets/images/test_icon.jpg'))),
                ),
                Text('しみしょー',
                    style: TextStyle(fontSize: 25.sp, color: Colors.white))
              ],
            ),
            Container(
              child: BorderedText(
                  strokeWidth: 2.0.w,
                  //縁の太さ
                  strokeColor: Colors.red,
                  child: Text('敗者',
                      style: TextStyle(fontSize: 45.sp, color: Colors.white))),
            ),
            Row(
              children: [
                Container(
                  width: 30.w,
                  height: 30.w,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage('assets/images/test_icon.jpg'))),
                ),
                Text('しみしょー',
                    style: TextStyle(fontSize: 25.sp, color: Colors.white))
              ],
            ),
            Spacer(),
            Text(
              'チャットを行いますか？',
              style: TextStyle(color: Colors.white, fontSize: 20.sp),
            ),
            SizedBox(height: 2.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                EnterButton(
                  tap: (){     Navigator.of(context).pushNamedAndRemoveUntil('/top', (Route<dynamic> route) => false);

                  },

                  text: '拒否',
                  color: Colors.white.withOpacity(0.4),
                ),
                SizedBox(width: 5.w),
                EnterButton(
                  tap: (){Navigator.of(context).pushNamedAndRemoveUntil('/chat_room', (Route<dynamic> route) => false);

                  },

                  text: '承諾',
                ),
              ],
            ),
            Spacer(),
          ],
        ),
      ]),
    );
  }
}
