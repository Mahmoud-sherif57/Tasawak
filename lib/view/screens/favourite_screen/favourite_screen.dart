import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasawak/view_model/cubits/categories/category_cubit.dart';
import 'package:tasawak/view_model/cubits/categories/category_state.dart';
import 'package:tasawak/view_model/utils/app_assets.dart';
import 'package:tasawak/view_model/utils/app_colors.dart';
import 'package:tasawak/view_model/utils/reusable_widgets/reusable_rich_text.dart';
import '../../../model/categories/base_model.dart';
import '../../../view_model/utils/app_functions.dart';
import '../detailsScreen/details_screen.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryCubit = CategoryCubit.get(context);
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: AppColors.offwhite,
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: BlocConsumer<CategoryCubit, CategoryState>(
          listener: (context, state) {
            // if (state is DeletedSuccessfullyState) {
            //   const AdvanceSnackBar(
            //     bgColor: AppColors.green,
            //     duration: Duration(seconds: 2),
            //     message: "Successfully removed from favourite",
            //     mode: Mode.ADVANCE,
            //   ).show(context);
            // }
          },
          builder: (context, state) {
            return Stack(
              children: [
                SizedBox(
                  width: size.width,
                  height: size.height ,
                  child: categoryCubit.itemsOnFavourite.isNotEmpty
                      ?
                      /// List Of favourite is not empty
                      GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: categoryCubit.itemsOnFavourite.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 0.55, crossAxisCount: 2),
                          itemBuilder: (context, index) {
                            BaseModel current = categoryCubit.itemsOnFavourite[index];
                            return InkWell(
                              onTap: () {
                                AppFunctions.navigateTo(
                                  context,
                                  DetailsScreen(
                                    data: current,
                                    isCameFromMostPopularPart: false,
                                  ),
                                );
                              },
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Positioned(
                                    top: size.height * 0.02,
                                    left: size.width * 0.01,
                                    right: size.width * 0.01,
                                    child: Container(
                                      width: size.width * 0.5,
                                      height: size.height * 0.28,
                                      margin: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage(current.imageUrl),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: size.height * 0.06,
                                    left: size.width * 0.05,
                                    child: Text(
                                      current.name,
                                      style: theme.titleMedium,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: size.height * 0.04,
                                    left: size.width * 0.05,
                                    child: ReusableRichText(
                                      text: current.price.toString(),
                                      style1: theme.titleLarge,
                                      style2: theme.titleLarge?.copyWith(color: AppColors.primaryColor),
                                    ),
                                  ),

                                  ///---------addToCartIcon---------->
                                  Positioned(
                                    bottom: size.height * 0.05,
                                    right: size.width * 0.06,
                                    child: Container(
                                      height: 30,
                                      width: 35,
                                      decoration:  BoxDecoration(
                                        color: current.isOnTheCart ? AppColors.green : AppColors.gray,
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10),
                                        ),
                                      ),
                                      child: IconButton(
                                        onPressed: () {
                                          categoryCubit.toggleCart(current, context);
                                        },
                                        icon: const Icon(
                                          Icons.add_shopping_cart_sharp,
                                          color: AppColors.offwhite,
                                        ),
                                        iconSize: 20,
                                      ),
                                    ),
                                  ),
                                  ///---------addToFavouriteIcon---------->
                                  Positioned(
                                    top: size.height * 0.04,
                                    left: size.width * 0.05,
                                    child: CircleAvatar(
                                      radius: 17,
                                      backgroundColor: AppColors.offwhite,
                                      child: Center(
                                        child: IconButton(
                                          onPressed: () {
                                            categoryCubit.toggleFavourite(current, context);
                                          },
                                          icon: SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: current.isFavourite ? favouriteIcon : notFavouriteIcon,
                                          ),
                                          iconSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            );
                          },
                        )
                      :

                      /// List  of favourite is empty..
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
                                "Oops.!  Your Favorite is empty right now",
                                style: theme.titleMedium
                                    ?.copyWith(color: AppColors.olive2, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}



