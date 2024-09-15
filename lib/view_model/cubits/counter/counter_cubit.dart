import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasawak/view_model/cubits/counter/counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(InitialCounterState());

  static CounterCubit get(context) => BlocProvider.of<CounterCubit>(context);

  num counter = 0;

  void initial() {
    counter = 0;
    emit(InitialCounterState());
  }

  void reset() {
    counter = 0;
    emit(ResetCounterState());
  }

  void increment() {
    counter++;
    emit(IncrementCounterState());
  }

  void decrement() {
    if (counter > 0) {
      counter--;
      emit(DecrementCounterState());
    }
  }

  List<String> inputsList = [];
  TextEditingController inputController = TextEditingController();

  void addInput() {
    inputsList.add(inputController.text);
    inputController.clear();
    emit(AddingNewInput());
  }

  void clearCounter() {
    inputsList.remove(inputController.text);
    emit(RemovingCounter());
  }

  void clearInputs(index) {
    inputsList.removeAt(index);
    emit(RemovingInputs());
  }
}
