part of 'second_cubit.dart';

class SecondState {
  final List<double> interestA;
  final List<double> interestB;

  SecondState({required this.interestA, required this.interestB});

  SecondState copyWith({List<double>? interestA, List<double>? interestB}) =>
      SecondState(
        interestA: interestA ?? this.interestA,
        interestB: interestB ?? this.interestB,
      );
}

class SecondInitial extends SecondState {
  SecondInitial(List<double> interestA, List<double> interestB)
      : super(interestA: interestA, interestB: interestB);
}
