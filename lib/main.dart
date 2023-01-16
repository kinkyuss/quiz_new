import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_new/course_choice.dart';
import 'package:quiz_new/premium/detail.dart';
import 'package:quiz_new/premium/premium.dart';
import 'package:quiz_new/premium/review.dart';
import 'package:quiz_new/quiz/chat_room.dart';
import 'package:quiz_new/quiz/much.dart';
import 'package:quiz_new/quiz/quiz_answer.dart';
import 'package:quiz_new/quiz/quiz_pop_up.dart';
import 'package:quiz_new/quiz/quiz_pop_up1.dart';
import 'package:quiz_new/quiz/vi_or_de.dart';
import 'package:quiz_new/quiz/wait.dart';
import 'package:quiz_new/quiz/wait_test.dart';
import 'package:quiz_new/ranking.dart';
import 'package:quiz_new/settings.dart';
import 'package:quiz_new/top.dart';

import 'firebase_options.dart';
import 'quiz/choice.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await _initializeFirebaseAuth();
  runApp(   const ProviderScope(
    child: MyApp(),
  ),);
}

Future<void> _initializeFirebaseAuth() async {
  await Firebase.initializeApp();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? user = _firebaseAuth.currentUser;
  if (user == null) {
    await _firebaseAuth.signInAnonymously();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //
      title: 'Flutter Demo',
      theme: ThemeData(
          // textTheme: GoogleFonts.notoSansJavaneseTextTheme(),
          ),
      // home:const Top(),
      initialRoute: '/top',
      routes: {
        // 画面の名前とWidgetを紐づける

        '/top': (context) => Top(),
        '/ranking': (context) => const Ranking(),
        '/settings': (context) => const Settings(),
        '/course_choice': (context) => const CourseChoice(),
        '/choice': (context) => Choice(),
        '/wait': (context) => Wait(),
        '/wait_test': (context) => WaitTest(
              key: key,
              value: '',
            ),
        '/much': (context) => Much(key),

        '/quiz_pop_up': (context) => const QuizPopUp(),
        '/quiz_pop_up1': (context) => QuizPopUp1(),

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
