import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_new/model/questions_relation/questions_list.dart';
import 'package:quiz_new/view_model/provider.dart';

import '../../model/questions_relation/questions.dart';
//
// class QuizReady{
//   late WidgetRef _ref;
//   void setRef(WidgetRef ref) {
//     _ref = ref;
//   }
//
//   void setList(List<String> test, List<String> answer,
//       List<String> commentary) {
//     _ref
//         .read(questionsListProvider.state)
//         .state =
//         QuestionsList(test: test, answer: answer, commentary: commentary);
//     _ref
//         .read(questionsProvider.state)
//         .state =
//         Questions(
//             test: test[0], answer: answer[0], commentary: commentary[0]);
//   }
//
//
// }