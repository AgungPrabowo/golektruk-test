part of 'third_cubit.dart';

class ThirdState {
  final List<QuestionClass> questionA;
  final List<QuestionClass> questionB;
  final String answerA;
  final String answerB;
  final String operandA;
  final String operandB;

  ThirdState({
    required this.questionA,
    required this.questionB,
    required this.answerA,
    required this.answerB,
    required this.operandA,
    required this.operandB,
  });

  ThirdState copyWith({
    List<QuestionClass>? questionA,
    List<QuestionClass>? questionB,
    String? answerA,
    String? answerB,
    String? operandA,
    String? operandB,
  }) =>
      ThirdState(
        questionA: questionA ?? this.questionA,
        questionB: questionB ?? this.questionB,
        answerA: answerA ?? this.answerA,
        answerB: answerB ?? this.answerB,
        operandA: operandA ?? this.operandA,
        operandB: operandB ?? this.operandB,
      );
}

class ThirdInitial extends ThirdState {
  ThirdInitial(
    List<QuestionClass> questionA,
    List<QuestionClass> interestB,
    String answerA,
    String answerB,
    String operandA,
    String operandB,
  ) : super(
          questionA: questionA,
          questionB: interestB,
          answerA: answerA,
          answerB: answerB,
          operandA: operandA,
          operandB: operandB,
        );
}

class QuestionClass {
  final String value;
  final bool isCheck;
  final TextEditingController ctrl;

  QuestionClass(this.value, this.isCheck, this.ctrl);
}
