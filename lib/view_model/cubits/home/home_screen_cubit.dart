import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'home_screen_state.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  late PageController controller;
static HomeScreenCubit get (context) => BlocProvider.of<HomeScreenCubit>(context);

  HomeScreenCubit() : super(HomeScreenInitial()) {

    controller = PageController(initialPage: 1, viewportFraction: 0.7);
  }

  void changePage(int page) {
    emit(HomePageChanged(page));
  }

  @override
  Future<void> close() {
    controller.dispose();
    return super.close();
  }
}
