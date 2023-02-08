import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_new/view/course_choice.dart';
import 'package:quiz_new/view/premium/detail.dart';
import 'package:quiz_new/view/premium/premium.dart';
import 'package:quiz_new/view/premium/review.dart';
import 'package:quiz_new/view/quiz/chat_room.dart';
import 'package:quiz_new/view/quiz/choice.dart';
import 'package:quiz_new/view/quiz/commentary.dart';
import 'package:quiz_new/view/quiz/much.dart';
import 'package:quiz_new/view/quiz/quiz_answer.dart';
import 'package:quiz_new/view/quiz/quiz_pop_up1.dart';
import 'package:quiz_new/view/quiz/vi_or_de.dart';
import 'package:quiz_new/view/quiz/wait.dart';
import 'package:quiz_new/view/ranking.dart';
import 'package:quiz_new/view/settings.dart';
import 'package:quiz_new/view/top.dart';
import 'package:quiz_new/view_model/logic/wait_logic.dart';
import 'package:quiz_new/view_model/provider.dart';
import 'firebase_options.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await _initializeFirebaseAuth();
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

Future<void> _initializeFirebaseAuth() async {
  await Firebase.initializeApp();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? user = _firebaseAuth.currentUser;
  if (user == null) {
    await _firebaseAuth.signInAnonymously();
  }
}

class MyApp extends ConsumerWidget {
  MyApp({Key? key}) : super(key: key);

  final userUid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context, ref) {

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(myInformationProvider.notifier)
          .state =
          ref
              .read(myInformationProvider.state)
              .state
              .copyWith(uid: userUid);
    });
    return MaterialApp(
      useInheritedMediaQuery: true,
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

        '/top': (context) =>  const Top(),
        '/ranking': (context) => const Ranking(),
        '/settings': (context) => const Settings(),
        '/course_choice': (context) => CourseChoice(),
        '/choice': (context) => Choice(),
        '/wait_logic': (context) => WaitLogic(),
        '/wait': (context) => const Wait(),
        '/much': (context) => const Much(),

        '/quiz_pop_up1': (context) => QuizPopUp1(),
        '/commentary':(context)=>const Commentary(),

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
