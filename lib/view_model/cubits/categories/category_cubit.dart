import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasawak/model/categories/base_model.dart';
import 'package:tasawak/view_model/cubits/categories/category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(InitialCategoryState());

  static CategoryCubit get(context) => BlocProvider.of<CategoryCubit>(context);
  bool isThemeSwitched = false;
  bool isLanguageSwitched = false;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth fireAuth = FirebaseAuth.instance;
  TextEditingController searchController =TextEditingController ();


  // bool favourite = false;
  // bool onTheCart = false;
  List<BaseModel> itemsOnCart = [];
  List<BaseModel> itemsOnFavourite = [];
  List<QueryDocumentSnapshot> categoryList0nFS = [];

  ///------------------addToCartFunction---------->
  void addToCart(BaseModel data, BuildContext context) {
    itemsOnCart.add(data);
    emit(AddedToTheCartState());
    // this variable (contains) save a true or false value,
    // bool contains = itemsOnCart.contains(data);
    // if (contains == true) {
    //   // the item is added to the cart before,
    //   // const AdvanceSnackBar(
    //   //   bgColor: AppColors.green,
    //   //   duration: Duration(seconds: 1),
    //   //   message: "Removed from the the cart",
    //   //   mode: Mode.ADVANCE,
    //   // ).show(context);
    // } else {
      // const AdvanceSnackBar(
      //   bgColor: AppColors.green,
      //   duration: Duration(seconds: 1),
      //   message: "Successfully added to the cart",
      //   mode: Mode.ADVANCE,
      // ).show(context);
    // }
  }

  ///------------------delete item from the cart---------->
  void deleteFromCart(BaseModel data) {
    itemsOnCart.removeWhere((element) => element.id == data.id);
    // if i increased the value(quantity) and removed the item from the list the value still increased..
    // to solve this problem when i tap on close. the value will be reset to 1..
    data.value = 1;
    emit(RemovedFromTheCartState());
    // emit(DeletedSuccessfullyState());
  }

  ///-------------toggle cart------------>
  void toggleCart(BaseModel data, BuildContext context) {
    data.isOnTheCart = !data.isOnTheCart;
    if (data.isOnTheCart) {
      addToCart(data, context);
    } else {
      deleteFromCart(data);
    }
  }

  ///------------------addToFavouriteFunction---------->
  void addToFavourite(BaseModel data, BuildContext context) {
    itemsOnFavourite.add(data);
    emit(AddedToFavoritesState());
    // this variable (contains) save a true or false value,
    // bool contains = itemsOnFavourite.contains(data);
    // if (contains) {
      // the item is added to the cart before,
      // emit(AddedToFavoritesState());
      // const AdvanceSnackBar(
      //   bgColor: AppColors.green,
      //   duration: Duration(seconds: 3),
      //   message: "removed from the Favourite",
      //   mode: Mode.ADVANCE,
      // ).show(context);
    // } else {

      // emit(RemovedFromFavoritesState());
      // const AdvanceSnackBar(
      //   bgColor: AppColors.green,
      //   duration: Duration(seconds: 2),
      //   message: "Successfully added to the Favourite",
      //   mode: Mode.ADVANCE,
      // ).show(context);
    // }
  }

  ///------------------delete item from Favourite---------->
  void deleteFromFavourite(BaseModel data) {
    itemsOnFavourite.removeWhere((element) => element.id == data.id);
    // if i increased the value(quantity) and removed the item from the list the value still increased..
    // to solve this problem when i tap on close. the value will be reset to 1..
    emit(RemovedFromFavoritesState());
  }

  ///----------toggle favourite--------->
  toggleFavourite(BaseModel data, BuildContext context) {
    // favourite = !favourite;
    emit(FavouriteLoadingState(id: data.id.toString()));
    data.isFavourite = !data.isFavourite;
    if (data.isFavourite) {
      addToFavourite(data, context);
    } else {
      deleteFromFavourite(data);
    }
  }

  ///------------------increase quantity of item------------>
  void increaseQuantity(BaseModel current) {
    if (current.value! >= 0) {
      current.value = (current.value)! + 1;
      emit(IncreaseValueState());
    }
  }

  ///------------------decrease quantity of item------------>
  void decreaseQuantity(BaseModel current ,BuildContext context) {
    if (current.value! > 1) {
      current.value = (current.value)! - 1;
      emit(DecreaseValueState());
    } else {
      toggleCart(current,context);
      // current.value = 1;
      emit(RemovedFromTheCartState());
    }
  }

  ///------------------GET ITEMS COUNT IN THE CART ------------>
  getItemsCountOnCart() {
    emit(GetItemsCountOnCart());
    return itemsOnCart.length.toString();
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

  ///----------animation Controllers------->
  // late PageController? controller;
  // changePageView() {
  //  controller = PageController(initialPage: 2, viewportFraction: 0.7);
  //   emit(ViewPageSuccessState());
  // }

  ///-----------switch theme mode------->
  void switchThemeMode(value) {
    isThemeSwitched = value;
    emit(SwitchedState());
  }

  ///-----------switch language ------->
  void switchLanguage(value) {
    isLanguageSwitched = value;
    emit(SwitchedState());
  }

  ///---------------------Save categories to fireStore---------------->
  void getCategoriesFromFS() async {
    QuerySnapshot querySnapshot = await firestore.collection("categories").get();
    categoryList0nFS.addAll(querySnapshot.docs);
    // print(userDataList[5]);
    // print(userDataList.length);
  }

  // Future<void> saveCategoriesToFirestore() async {
  //   await firestore.collection(FirebaseKeys.categories).doc(fireAuth.currentUser?.email).set();
  // }





}
