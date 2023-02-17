import 'package:firebase_database/firebase_database.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_new/model/chosen_data.dart';
import 'package:quiz_new/model/my_information.dart';
import 'package:quiz_new/model/questions_relation/questions.dart';
import 'package:quiz_new/model/questions_relation/questions_list.dart';


final chosenProvider = StateProvider <ChosenData>((ref) => ChosenData());
final myInformationProvider = StateProvider <MyInformation>((ref) => const MyInformation(name:'青汁王子', uid:'Uidが登録されていません。', consecutive:4));
final countDownTimerProvider=StateProvider <int>((ref) =>100);
final iProvider=StateProvider <int>((ref) =>0);


final questionsListProvider = StateProvider <QuestionsList>((ref) =>
    const QuestionsList(test: ['まだ問題は登録されていません。','日本で一番高い山は？,','日本で一番高い山は？,','日本で一番高い山は？,','日本で一番高い山は？,'],
      answer: ['エベレスト','富士山','富士山','富士山','富士山','富士山','富士山','富士山'],
      answerForSelect: ['エベレスト','ふじさん','ふじさん','ふじさん','ふじさん'],
      commentary: ['まだ解説は登録されていません。','富士山や','富士山','富士山','富士山'],
        similarAnswer: [['チョモランマ','エヴェレスト'],[],[],[],[]]
    ));
final questionsProvider = StateProvider<Questions>((ref) {return const Questions(test:'問題',answer:'',commentary: '',answerForSelect:'',similarAnswer: [] );});
final firstProvider = StateProvider<bool>((ref) {return true;});
final cdStop= StateProvider<bool>((ref) {return false;});
final pushEmojiProvider = StateProvider<bool>((ref) {return false;});
final questionNumberProvider = StateProvider<int>((ref) =>0);
final muchStateProvider = StateProvider<String>((ref) =>'対戦相手を探しています。');
final opponentProvider =StateProvider<Map>((ref) =>{});
final matchInformationProvider=StateProvider<Map>((ref) =>{});
final startTimeRef = FirebaseDatabase.instance.reference().child("startTime");
final winnerProvider = Provider<Map>((ref) => Map());
final nextQuestionTimeProvider = Provider<int>((ref) => 0);
final startTimeProvider = StateProvider<int>((ref) => 0);
final answerProvider = StateProvider<String>((ref) =>'');
final buttonTimerProvider = StateProvider<String>((ref) =>'');
