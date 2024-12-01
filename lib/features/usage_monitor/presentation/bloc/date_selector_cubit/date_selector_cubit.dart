import 'package:flutter_bloc/flutter_bloc.dart';

class DateSelectorCubit extends Cubit<DateTime> {
  DateSelectorCubit(super.initialState);

  void onDateChanged(DateTime date) {
    emit(date);
  }
}
