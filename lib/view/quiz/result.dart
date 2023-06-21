import 'package:flutter/material.dart';
import 'package:quiz_new/component.dart';
import 'package:sizer/sizer.dart';
import 'package:bordered_text/bordered_text.dart';
class Result extends StatelessWidget {
  const Result({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

       body: Stack(
         children:[
           MainBackGround(),
           Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Container(
               child: BorderedText(strokeWidth: 2.0.w, //縁の太さ
                 strokeColor: Colors.blue, child: Text('勝者',style:TextStyle(fontSize:45.sp ,color: Colors.white))),
         ),
               Row(
                 children: [
                   Container(
                     width:30.w,
                     height: 30.w,
                     decoration: BoxDecoration(
                         shape: BoxShape.circle,
                         image: DecorationImage(
                             fit: BoxFit.fill,
                             image: AssetImage(
                                 'assets/images/test_icon.jpg'))),
                   ),
                   Text('しみしょー',style:TextStyle(fontSize:25.sp ,color: Colors.white)
                   )],
               ),


               Container(
                 child: BorderedText(strokeWidth: 2.0.w, //縁の太さ
                     strokeColor: Colors.red, child: Text('敗者',style:TextStyle(fontSize:45.sp ,color: Colors.white))),
               ),
               Row(
                 children: [
                   Container(
                     width:30.w,
                     height: 30.w,
                     decoration: BoxDecoration(
                         shape: BoxShape.circle,
                         image: DecorationImage(
                             fit: BoxFit.fill,
                             image: AssetImage(
                                 'assets/images/test_icon.jpg'))),
                   ),
                   Text('しみしょー',style:TextStyle(fontSize:25.sp ,color: Colors.white)
                   )],
               ),
               Text('チャットを行いますか？',style: TextStyle(color: Colors.white,fontSize: 20.sp),),
               Row(
                 children: [
                   EnterButton(
                   text:   '承諾',
                   ),
                   EnterButton(
                     text:   '拒否',
                   ),
                 ],
               ),




             ],


           ),]
       ),
    );
  }
}
