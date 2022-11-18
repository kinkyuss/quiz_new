import 'package:flutter/material.dart';

class QuizPopUp extends StatelessWidget {
  const QuizPopUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceSize = MediaQuery.of(context).textScaleFactor;

    return Scaffold(
        body: Center(
      child: Column(children: [
        SizedBox(
          height: deviceHeight*0.01,
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.end,
      children:[
        SizedBox(
          height: deviceHeight*0.12,
        ),
        CircleAvatar(
          radius: 30,

          backgroundColor: const Color.fromRGBO(244, 179, 194, 1),
          child:Text('5',style: TextStyle(color:const Color.fromRGBO(177, 29,44,1),fontSize:deviceSize*40 ),),

        ),

      ]),
        SizedBox(
        width: deviceWidth * 0.6,
          height: deviceHeight*0.2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('1/5',style: TextStyle(fontSize: deviceSize*40,fontWeight: FontWeight.bold,),),
              Text('世界で一番高い山の',style: TextStyle(fontSize: deviceSize*30,fontWeight: FontWeight.bold,),),
          Text('名前を答えよ',style: TextStyle(fontSize: deviceSize*30,fontWeight: FontWeight.bold,),),

            ],
          ),

        ),

        InkWell(

          highlightColor: Colors.transparent,
          onTap: ()=>Navigator.pushNamed(context,'/quiz_answer'),
          child: Container(
            height: deviceHeight * 0.6,
            width: deviceWidth * 0.6,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Colors.red, Colors.pinkAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
      ]),
    ));
  }
}
