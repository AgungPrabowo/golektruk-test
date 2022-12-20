import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

part 'third_state.dart';

class ThirdCubit extends Cubit<ThirdState> {
  ThirdCubit()
      : super(ThirdInitial(
          [
            QuestionClass("", false, TextEditingController()),
            QuestionClass("", false, TextEditingController()),
            QuestionClass("", false, TextEditingController())
          ],
          [
            QuestionClass("", false, TextEditingController()),
            QuestionClass("", false, TextEditingController()),
            QuestionClass("", false, TextEditingController()),
            QuestionClass("", false, TextEditingController()),
          ],
          "",
          "",
          "",
          "",
        ));

  countA() {
    final listValue = state.questionA
        .where((e) => e.value.isNotEmpty)
        .map((e) => double.parse(e.value));
    final count = listValue.reduce((value, element) {
      double total = 0;
      switch (state.operandA) {
        case "+":
          total = value + element;
          break;
        case "-":
          total = value - element;
          break;
        case "x":
          total = value * element;
          break;
        case "/":
          total = value / element;
          break;
      }
      return total;
    });
    emit(state.copyWith(answerA: "$count"));
  }

  countB() {
    final listValue = state.questionB
        .where((e) => e.value.isNotEmpty)
        .map((e) => double.parse(e.value));
    final count = listValue.reduce((value, element) {
      double total = 0;
      switch (state.operandB) {
        case "+":
          total = value + element;
          break;
        case "-":
          total = value - element;
          break;
        case "x":
          total = value * element;
          break;
        case "/":
          total = value / element;
          break;
      }
      return total;
    });
    emit(state.copyWith(answerB: "$count"));
  }

  onCheckA(bool value, int idx) {
    final questionA = state.questionA;
    final item = questionA[idx];
    questionA[idx] = QuestionClass(item.value, value, item.ctrl);
    emit(state.copyWith(questionA: questionA));
  }

  onCheckB(bool value, int idx) {
    final questionB = state.questionB;
    final item = questionB[idx];
    questionB[idx] = QuestionClass(item.value, value, item.ctrl);
    emit(state.copyWith(questionB: questionB));
  }

  onChangeRadioA(String value) => emit(state.copyWith(operandA: value));
  onChangeRadioB(String value) => emit(state.copyWith(operandB: value));

  onChangeValueA(String value, int idx) {
    final questionA = state.questionA;
    final item = questionA[idx];
    questionA[idx] = QuestionClass(value, item.isCheck, item.ctrl);
    emit(state.copyWith(questionA: questionA));
  }

  onChangeValueB(String value, int idx) {
    final questionB = state.questionB;
    final item = questionB[idx];
    questionB[idx] = QuestionClass(value, item.isCheck, item.ctrl);
    emit(state.copyWith(questionB: questionB));
  }

  addField() {
    final questionList = [
      ...state.questionB,
      QuestionClass("", false, TextEditingController())
    ];
    emit(state.copyWith(questionB: questionList));
  }

  removeField(int idx) {
    final questionList = state.questionB;
    questionList.removeAt(idx);
    emit(state.copyWith(questionB: questionList));
  }
}
