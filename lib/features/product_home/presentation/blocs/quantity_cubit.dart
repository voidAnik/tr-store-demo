import 'package:flutter_bloc/flutter_bloc.dart';

class QuantityCubit extends Cubit<int> {
  QuantityCubit() : super(1);

  void increase() {
    emit(state + 1);
  }

  void decrease() {
    if (state > 1) {
      emit(state - 1);
    }
  }
}
