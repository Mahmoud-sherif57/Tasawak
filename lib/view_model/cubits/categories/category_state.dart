abstract class CategoryState {}

class InitialCategoryState extends CategoryState {}

class ViewPageSuccessState extends CategoryState {}
      /// -------- the count of items in the cart -------->
class InitialValueState extends CategoryState {}

class IncreaseValueState extends CategoryState {}

class DecreaseValueState extends CategoryState {}

class GetItemsCountOnCart extends CategoryState {}
    ///------------in the favourite state ----------->
class AddedToFavoritesState extends CategoryState {}

class RemovedFromFavoritesState extends CategoryState {}

class FavouriteLoadingState extends CategoryState {
  final String id;
  FavouriteLoadingState({ required this.id});

}
    ///------------in the cart state ----------->

class AddedToTheCartState extends CategoryState {}

class RemovedFromTheCartState extends CategoryState {}

///------------ switch state ----------->

class SwitchedState extends CategoryState {}
