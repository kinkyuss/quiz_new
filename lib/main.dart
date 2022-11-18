import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quiz_new/premium/detail.dart';
import 'package:quiz_new/premium/premium.dart';
import 'package:quiz_new/premium/review.dart';
import 'package:quiz_new/quiz/chat_room.dart';
import 'package:quiz_new/quiz/quiz_answer.dart';
import 'package:quiz_new/quiz/quiz_pop_up.dart';
import 'package:quiz_new/quiz/vi_or_de.dart';
import 'package:quiz_new/quiz/wait.dart';
import 'package:quiz_new/ranking.dart';
import 'package:quiz_new/settings.dart';
import 'package:quiz_new/top.dart';

import 'quiz/choice.dart';


void main() async {
  // Fireabse初期化
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //
      title: 'Flutter Demo',
      theme: ThemeData(
        // textTheme: GoogleFonts.notoSansJavaneseTextTheme(),
      ),
      // home:const Top(),
      initialRoute: '/top',
      routes: {
        // 画面の名前とWidgetを紐づける

        '/top': (context) => const Top(),
        '/ranking': (context) => const Ranking(),
        '/settings': (context) => const Settings(),
        '/choice': (context) => const Choice(),
        '/wait': (context) => const Wait(),
        '/quiz_pop_up': (context) => const QuizPopUp(),
         '/quiz_answer': (context) => const QuizAnswer(),
         '/chat_room': (context) => const ChatRoom(),
         '/vi_or_de': (context) => const ViOrDe(),
        '/premium': (context) => const PremiumMain(),
         '/detail': (context) => const Detail(),
         '/review': (context) => const Review(),



      },
    );
  }
}

