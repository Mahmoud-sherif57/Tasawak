import 'package:advance_notification/advance_notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasawak/model/categories/base_model.dart';
import 'package:tasawak/view_model/cubits/categories/category_state.dart';
import 'package:tasawak/view_model/utils/app_colors.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(InitialCategoryState());

  static CategoryCubit get(context) => BlocProvider.of<CategoryCubit>(context);
  bool favourite = false;
  bool onTheCart = false;
  List<BaseModel> itemsOnCart = [];
  List<BaseModel> itemsOnFavourite = [];



  ///------------------addToCartFunction---------->
  void addToCart(BaseModel data, BuildContext context) {
    // this variable (contains) save a true or false value,
    bool contains = itemsOnCart.contains(data);
    if (contains == true) {
      // the item is added to the cart before,
      const AdvanceSnackBar(
        bgColor: AppColors.red,
        duration: Duration(seconds: 3),
        message: "This item already exists in the cart",
        mode: Mode.ADVANCE,
      ).show(context);
    } else {
      itemsOnCart.add(data);
      const AdvanceSnackBar(
        bgColor: AppColors.green,
        duration: Duration(seconds: 2),
        message: "Successfully added to the cart",
        mode: Mode.ADVANCE,
      ).show(context);
    }
  }

  ///------------------addToFavouriteFunction---------->
  void addToFavourite(BaseModel data, BuildContext context) {
    // this variable (contains) save a true or false value,
    bool contains = itemsOnFavourite.contains(data);
    if (contains) {
      // the item is added to the cart before,
      const AdvanceSnackBar(
        bgColor: AppColors.red,
        duration: Duration(seconds: 3),
        message: "This item already exists in the Favourite",
        mode: Mode.ADVANCE,
      ).show(context);
    } else {
      itemsOnFavourite.add(data);
      const AdvanceSnackBar(
        bgColor: AppColors.green,
        duration: Duration(seconds: 2),
        message: "Successfully added to the Favourite",
        mode: Mode.ADVANCE,
      ).show(context);
    }
  }

  ///------------------delete item from the cart---------->
  void deleteFromCart(BaseModel data) {
    itemsOnCart.removeWhere((element) => element.id == data.id);
    // if i increased the value(quantity) and removed the item from the list the value still increased..
    // to solve this problem when i tap on close. the value will be reset to 1..
    data.value = 1;
    emit(DeletedSuccessfullyState());
  }

  ///------------------delete item from Favourite---------->
  void deleteFromFavourite(BaseModel data) {
    itemsOnCart.removeWhere((element) => element.id == data.id);
    // if i increased the value(quantity) and removed the item from the list the value still increased..
    // to solve this problem when i tap on close. the value will be reset to 1..
    data.value = 1;
    emit(DeletedSuccessfullyState());
  }

  ///------------------increase quantity of item------------>
  void increaseQuantity(BaseModel current) {
    if (current.value! >= 0) {
      current.value = (current.value)! + 1;
      emit(IncreaseValueState());
    }
  }

  ///------------------decrease quantity of item------------>
  void decreaseQuantity(BaseModel current) {
    if (current.value! > 1) {
      current.value = (current.value)! - 1;
      emit(DecreaseValueState());
    } else {
      deleteFromCart(current);
      current.value = 1;
      emit(DecreaseValueState());
    }
  }

  ///------------------calculates the subtotal of the items on the cart------------>

  num getSubtotalCost() {
    num total = 0;

    if (itemsOnCart.isEmpty) {
      total = 0;
      return total;
    } else {
      for (BaseModel items in itemsOnCart) {
        total = total + items.price * items.value!;
      }
    }
    // return (total).round().toDouble();
    return double.parse(total.toStringAsFixed(
        2)); // Safely format to 2 decimals because sometimes the total be like (00.00000000000)
    // return (total).toStringAsFixed(2).toDouble();
  }

  ///------------------calculates the shipping cost of the items on the cart------------>
  num getShippingCost() {
    num shipping = 0;
    if (itemsOnCart.length <= 4 && itemsOnCart.isNotEmpty) {
      shipping = itemsOnCart.length * 10; // the items on the cart *10 $..
      return shipping;
    } else if (itemsOnCart.length > 4) {
      shipping = 80;
    }
    return shipping;
  }

  /// another solution
//   num getShippingCost() {
//     if (itemsOnCart.isEmpty) return 0;
//     return itemsOnCart.length <= 4 ? 25 : 80;
//   }

  ///------------------calculates the total cost------------>
  num getTotalCost() {
    num subtotal = getSubtotalCost();
    num shipping = getShippingCost();
    return double.parse((shipping + subtotal).toStringAsFixed(2));
    // return double.parse((subtotal + shipping).toStringAsFixed(2));
  }

  ///----------toggle favourite--------->
  void toggleFavourite(BaseModel data, BuildContext context) {
    favourite =! favourite;
    if(favourite){
      addToFavourite(data, context);
    }else{
      deleteFromFavourite(data);
    }
    emit(ToggleFavouriteState());
  }
  ///-------------toggle cart------------>
  void toggleCart(BaseModel data, BuildContext context) {
    onTheCart =! onTheCart;
    if(onTheCart){
      addToCart(data, context);
    }else{
      deleteFromCart(data);
    }
    emit(ToggleFavouriteState());
  }


  ///----------animation Controllers------->
  // late PageController? controller;
  // changePageView() {
  //  controller = PageController(initialPage: 2, viewportFraction: 0.7);
  //   emit(ViewPageSuccessState());
  // }



}


