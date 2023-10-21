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
import 'package:quiz_new/view/quiz/result.dart';
import 'package:quiz_new/view/quiz/vi_or_de.dart';
import 'package:quiz_new/view/quiz/wait.dart';
import 'package:quiz_new/view/ranking.dart';
import 'package:quiz_new/view/test.dart';
import 'package:quiz_new/view/top.dart';
import 'package:quiz_new/view_model/logic/wait_logic.dart';
import 'package:quiz_new/view_model/provider.dart';
import 'package:sizer/sizer.dart';

import 'firebase_options.dart';
import 'model/chosen_data.dart';
import 'model/my_information.dart';
import 'model/questions_relation/problem_set.dart';
import 'model/questions_relation/problem_sets_list.dart';

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
    print('user is null') ;
    await _firebaseAuth.signInAnonymously();
  }
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp>  with WidgetsBindingObserver {


  final userUid = FirebaseAuth.instance.currentUser!.uid;


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }
  @override
  void dispose() {
    print("dispose");
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }
  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async{
    //Point②
//didChangeAppLifecycleState()が状態の変更があった時に呼び出されるメソッドなのでその中で状態を出力。
// 引数のAppLifecycleStateは状態に対応する以下の4つのいずれかを返します。
    print("stete = $state");//状態を詳しく出す
    switch (state) {
      case AppLifecycleState.inactive:
        print('非アクティブになったときの処理');
        break;
      case AppLifecycleState.paused:
        print('停止されたときの処理');
        break;
      case AppLifecycleState.resumed:

        if(ref.read(muchStateProvider.notifier).state == '対戦相手が見つかりました。') {
          resetProviders(ref);
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) {
              return AlertDialog(
                content: Text("接続が途切れました。\n最初からやり直してください。"),
                actions: [
                  ElevatedButton(
                    child: Text("OK"),
                    onPressed: () =>Navigator.push(context, MaterialPageRoute(builder: (context) => Top())
                  ),
                  )],
              );
            },
          );

          print('再開されたときの処理');
        }
        break;
      case AppLifecycleState.detached:
        resetProviders(ref);
        print('破棄されたときの処理');
        break;
    }
  }

  void resetProviders(WidgetRef container) {
    container.read(chosenProvider.notifier).state = ChosenData();
    container.read(myInformationProvider.notifier).state = MyInformation(name: '青汁王子', uid: 'Uidが登録されていません。', consecutive: 4, winRate: 0.5);
    container.read(countDownTimerProvider.notifier).state = 100;
    container.read(iProvider.notifier).state = 0;
    container.read(problemSetsListProvider.notifier).state = ProblemSetsList(
      question: [
        'まだ問題は登録されていません。',
        '日本で一番高い山は？',
        '日本で一番高い山は？',
        '日本で一番高い山は？',
        '日本で一番高い山は？',
      ],
      answer: ['エベレスト', '富士山', '富士山', '富士山', '富士山'],
      answerForSelect: ['エベレスト', 'ふじさん', 'ふじさん', 'ふじさん', 'ふじさん'],
      commentary: ['まだ解説は登録されていません。', '富士山や', '富士山', '富士山', '富士山'],
      similarAnswer: [['チョモランマ', 'エヴェレスト'], [], [], [], []],
    );
    container.read(problemSetProvider.notifier).state = ProblemSet(
      question: '問題1',
      answer: '',
      commentary: '',
      answerForSelect: '',
      similarAnswer: [],
    );
    container.read(firstProvider.notifier).state = true;
    container.read(cdStop.notifier).state = false;
    container.read(pushEmojiProvider.notifier).state = false;
    container.read(questionNumberProvider.notifier).state = 0;
    container.read(muchStateProvider.notifier).state = '対戦相手を探しています...';
    container.read(opponentProvider.notifier).state = {};
    container.read(matchInformationProvider.notifier).state = {};
    container.read(startTimeProvider.notifier).state = 0;
    container.read(answerProvider.notifier).state = '';
    container.read(buttonTimerProvider.notifier).state = '';
    container.read(resultProvider.notifier).state = {
      'me': [],
      'you': [],
    };
  }

  @override
  Widget build(BuildContext context,) {

    FirebaseAuth auth = FirebaseAuth.instance;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(myInformationProvider.notifier).state = ref
          .read(myInformationProvider.state)
          .state
          .copyWith(
              uid: userUid, name: auth.currentUser?.displayName ?? '名称未設定');
    });

    return Sizer(
        builder: (context, orientation, deviceType) {
      return MaterialApp(
        debugShowCheckedModeBanner: false, // これを追加するだけ

        useInheritedMediaQuery: true,


        //
        title: 'Flutter Demo',
        theme: ThemeData(
            // textTheme: GoogleFonts.notoSansJavaneseTextTheme(),
            ),
        home:const Top(),
        initialRoute: '/top',
showSemanticsDebugger: false,
debugShowMaterialGrid: false,
        routes: {
          // 画面の名前とWidgetを紐づける
          '/premium': (context) => const PremiumMain(),
          '/test': (context) => Test(),
          '/top': (context) => const Top(),
          '/ranking': (context) => const Ranking(),
          // '/settings': (cotntext) => const Settings(),

          '/course_choice': (context) => CourseChoice(),
          '/choice': (context) => Choice(),
          '/wait_logic': (context) => WaitLogic(),
          '/wait': (context) => const Wait(),
          '/much': (context) => const Much(),

          '/quiz_pop_up1': (context) => QuizPopUp1(),
          '/commentary': (context) => const Commentary(),
          '/result': (context) => const Result(),

          '/quiz_answer': (context) => const QuizAnswer(),
          '/chat_room': (context) => const ChatRoom(),
          '/vi_or_de': (context) => const ViOrDe(),
          '/premium': (context) => const PremiumMain(),
          '/detail': (context) => const Detail(),
          '/review': (context) => const Review(),
        },
      );
    });
  }
}
