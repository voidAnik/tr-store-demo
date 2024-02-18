import 'package:flutter_bloc/flutter_bloc.dart';

class TotalMoneyCubit extends Cubit<int> {
  TotalMoneyCubit() : super(0);

  void addValue(int value) {
    emit(state + value);
  }

  void subValue(int value) {
    emit(state - value);
  }
}
