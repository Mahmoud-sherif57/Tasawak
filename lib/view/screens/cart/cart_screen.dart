import 'package:advance_notification/advance_notification.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasawak/view_model/cubits/categories/category_cubit.dart';
import 'package:tasawak/view_model/cubits/categories/category_state.dart';
import 'package:tasawak/view_model/data/local/category_data.dart';
import 'package:tasawak/view_model/utils/app_assets.dart';
import 'package:tasawak/view_model/utils/app_colors.dart';
import 'package:tasawak/view_model/utils/reusable_widgets/reusable_button.dart';
import 'package:tasawak/view_model/utils/reusable_widgets/reusable_rich_text.dart';
import 'package:tasawak/view_model/utils/reusable_widgets/reusable_row_for_cart.dart';


class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryCubit = CategoryCubit.get(context);
    // var current = categoryCubit.itemsOnCart;
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: AppColors.offwhite,

      // appBar: AppBar(
      //   surfaceTintColor: Colors.transparent,
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   centerTitle: true,
      //   leading: IconButton(
      //     iconSize: 30,
      //     color: AppColors.primaryColor2,
      //     onPressed: () {
      //       AppFunctions.navigateTo(context, const WrapperHomeScreen2());
      //     },
      //     icon: const Icon(
      //       Icons.home_outlined,
      //       weight: 10,
      //     ),
      //   ),
      //   actions: [
      //     IconButton(
      //       iconSize: 30,
      //       color: AppColors.primaryColor2,
      //       onPressed: () {},
      //       icon: const Icon(LineIcons.user),
      //     ),
      //   ],
      //   title: Text(
      //     "My Cart",
      //     style: theme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
      //   ),
      // ),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: BlocConsumer<CategoryCubit, CategoryState>(
          listener: (context, state) {
            if (state is RemovedFromTheCartState) {
              const AdvanceSnackBar(
                bgColor: AppColors.green,
                duration: Duration(seconds: 1),
                message: "Removed from the cart",
                mode: Mode.ADVANCE,
              ).show(context);
            }
            else if (state is AddedToTheCartState) {
              const AdvanceSnackBar(
                bgColor: AppColors.green,
                duration: Duration(seconds: 1),
                message: "Successfully added to the cart",
                mode: Mode.ADVANCE,
              ).show(context);
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                SizedBox(
                  width: size.width,
                  height: size.height * 0.53,
                  child: categoryCubit.itemsOnCart.isNotEmpty
                      ?

                      /// List is not empty
                      ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: categoryCubit.itemsOnCart.length,
                          itemBuilder: (
                            context,
                            index,
                          ) {
                            var current = categoryCubit.itemsOnCart[index];
                            return FadeInUp(
                              //every row in the listView will calculate its duration (100*[0]+50),(100*[1]+50),(100*[2]+50)
                              delay: Duration(milliseconds: (100 * index + 50)),
                              child: Container(
                                margin: const EdgeInsets.all(5),
                                width: size.width,
                                height: size.height * 0.25,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //  start making product image ...
                                    Container(
                                      margin: const EdgeInsets.all(5),
                                      width: size.width * 0.4,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        image: DecorationImage(
                                            image: AssetImage(current.imageUrl), fit: BoxFit.cover),
                                        boxShadow: const [
                                          BoxShadow(
                                            offset: Offset(4, 4),
                                            blurRadius: 4,
                                          ),
                                        ],
                                      ),
                                    ),
                                    // end of making product image ...
                                    SizedBox(
                                      width: size.width * 0.02,
                                    ),
                                    // start making the product details
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: size.width * 0.52,
                                          child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  current.name,
                                                  style: theme.headlineSmall,
                                                ),
                                                IconButton(
                                                    onPressed: () {
                                                      categoryCubit.toggleCart(current,context);
                                                    },
                                                    icon: const Icon(Icons.close))
                                              ]),
                                        ),
                                        ReusableRichText(
                                          text: current.price.toString(),
                                          style1: theme.headlineSmall?.copyWith(color: AppColors.olive),
                                          style2: theme.headlineSmall?.copyWith(color: AppColors.orange),
                                        ),
                                        SizedBox(height: size.height * 0.03),
                                        Text(
                                          "Size :${sizesList[3]}",
                                          style: theme.titleLarge,
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: size.height * 0.04),
                                          width: size.width * 0.4,
                                          height: size.height * 0.04,
                                          child: Row(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  CategoryCubit.get(context).decreaseQuantity(current,context);
                                                },
                                                child: Container(
                                                  margin: const EdgeInsets.all(4.0),
                                                  width: size.width * 0.07,
                                                  height: size.height * 0.055,
                                                  decoration: BoxDecoration(
                                                    color: AppColors.primaryColor2,
                                                    borderRadius: BorderRadius.circular(30),
                                                    border: Border.all(color: AppColors.primaryColor2),
                                                  ),
                                                  child: const Icon(
                                                    Icons.remove,
                                                    color: AppColors.white,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                                child: Text(
                                                  current.value.toString(),
                                                  style: theme.headlineSmall,
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  CategoryCubit.get(context).increaseQuantity(current);
                                                },
                                                child: Container(
                                                  margin: const EdgeInsets.all(4.0),
                                                  width: size.width * 0.07,
                                                  height: size.height * 0.055,
                                                  decoration: BoxDecoration(
                                                    color: AppColors.primaryColor2,
                                                    borderRadius: BorderRadius.circular(30),
                                                    border: Border.all(color: AppColors.primaryColor2),
                                                  ),
                                                  child: const Icon(
                                                    Icons.add,
                                                    color: AppColors.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    // end of making the product details
                                  ],
                                ),
                              ),
                            );
                          })
                      :

                      /// List is empty..
                      FadeInUp(
                          delay: const Duration(milliseconds: 200),
                          child: Column(
                            children: [
                              Image(
                                image: AssetImage(AppAssets.emptyLogo),
                                fit: BoxFit.cover,
                              ),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              Text(
                                "Oops.!  Your cart is empty right now",
                                style: theme.titleMedium
                                    ?.copyWith(color: AppColors.olive2, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                ),

                // start making the pricing field ..
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: size.width,
                    height: size.height * 0.28  ,
                    color: AppColors.offwhite,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          // FadeInUp(
                          //   delay: const Duration(milliseconds: 350),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     children: [
                          //       Text('Smile i am here for you ',
                          //           style: theme.titleLarge),
                          //       const Icon(
                          //         Icons.arrow_forward_ios_rounded,
                          //         color: AppColors.gray,
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          FadeInUp(
                            delay: const Duration(milliseconds: 400),
                            child: ReusableRowForCart(
                              text: 'SubTotal',
                              price: CategoryCubit.get(context).getSubtotalCost(),
                            ),
                          ),
                          FadeInUp(
                            delay: const Duration(milliseconds: 450),
                            child: ReusableRowForCart(
                              text: 'Shipping',
                              price: CategoryCubit.get(context).getShippingCost(),
                            ),
                          ),
                          FadeInUp(
                            delay: const Duration(milliseconds: 500),
                            child: const Divider(
                              thickness: 1.5,
                              color: AppColors.gray,
                            ),
                          ),
                          FadeInUp(
                            delay: const Duration(milliseconds: 550),
                            child: ReusableRowForCart(
                              text: 'Total ',
                              price: CategoryCubit.get(context).getTotalCost(),
                            ),
                          ),
                          FadeInUp(
                            delay: const Duration(milliseconds: 600),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: ReUsableButton(
                                  text: "Buy now",
                                  onPressed: () {


                                  }),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // end of making the pricing field ..
              ],
            );
          },
        ),
      ),
    );
  }
}
