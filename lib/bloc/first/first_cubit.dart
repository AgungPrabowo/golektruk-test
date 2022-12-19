import 'package:bloc/bloc.dart';

part 'first_state.dart';

class FirstCubit extends Cubit<FirstState> {
  FirstCubit() : super(FirstInitial("0"));

  count(int input) {
    int total = 0;
    final oneWeek = 7;
    final oneMounth = 30;
    final oneDayFee = 10000;
    final oneWeekFee = 50000;
    final oneMounthFee = 180000;

    if (input < oneWeek)
      total = input * oneDayFee;
    else if (input < oneMounth) {
      final modulus = input % oneWeek;
      total = (modulus * oneDayFee) + ((input / oneWeek).floor() * oneWeekFee);
    } else {
      final modulus = input % oneMounth;
      int rest = 0;
      if (modulus != 0) {
        if (modulus < oneWeek)
          rest = modulus * oneDayFee;
        else {
          final modulusWeek = modulus % oneWeek;
          rest = (modulusWeek * oneDayFee) +
              ((input / oneWeek).floor() * oneWeekFee);
        }
      }
      total = rest + (input / oneMounth).floor() * oneMounthFee;
    }
    emit(FirstInitial("$total"));
  }
}
