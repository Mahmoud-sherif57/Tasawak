import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasawak/model/categories/base_model.dart';
import 'package:tasawak/view_model/cubits/search/search_state.dart';
import 'package:tasawak/view_model/data/local/category_data.dart';

class SearchCubit extends Cubit<SearchState>{
  // SearchCubit(super.initialState);
  SearchCubit() : super(InitialSearchState());

  static SearchCubit get (context) => BlocProvider.of<SearchCubit>(context);

  TextEditingController searchController =TextEditingController();
  List<BaseModel> itemsOnSearch = mainListData;

 // List itemsOnSearch = mainListData;

///-----------------------onSearchFunction------->
void onSearch(String search) {
  emit(ItemsOnSearchState());
  itemsOnSearch = mainListData.where((element)=> element.name.toLowerCase().contains(search)).toList();
}

///-----------------------clearController------->
void canselTheSearch(){
  searchController.clear();
  itemsOnSearch = mainListData;
}

















}
