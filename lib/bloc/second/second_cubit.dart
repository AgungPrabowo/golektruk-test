import 'package:bloc/bloc.dart';

part 'second_state.dart';

class SecondCubit extends Cubit<SecondState> {
  SecondCubit() : super(SecondInitial([], []));

  countA(double input) => emit(state.copyWith(interestA: count(input)));
  countB(double input, int totalMounth) =>
      emit(state.copyWith(interestB: count(input, totalMounth: totalMounth)));

  List<double> count(double input, {int totalMounth = 6}) {
    List<double> interestList = [];
    double interest;
    int adminFee;

    if (input <= 500000) {
      interest = 0.02;
      adminFee = 1500;
    } else if (input <= 10000000) {
      interest = 0.03;
      adminFee = 2000;
    } else if (input <= 50000000) {
      interest = 0.04;
      adminFee = 2500;
    } else {
      interest = 0.05;
      adminFee = 3000;
    }

    for (var i = 0; i < totalMounth; i++) {
      double currentTotal = i == 0 ? input : interestList[i - 1];
      final total = ((currentTotal * interest) + currentTotal) - adminFee;
      interestList.add(total);
    }
    return interestList;
  }
}
