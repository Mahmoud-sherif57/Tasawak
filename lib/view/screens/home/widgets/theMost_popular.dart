import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../model/categories/base_model.dart';
import '../../../../view_model/cubits/categories/category_cubit.dart';
import '../../../../view_model/cubits/categories/category_state.dart';
import '../../../../view_model/data/local/category-data.dart';
import '../../../../view_model/utils/app_colors.dart';
import '../../../../view_model/utils/app_functions.dart';
import '../../../../view_model/utils/reusable_widgets/reusable_richText.dart';
import '../../detailsScreen/details_screen.dart';

class TheMostPopularWidget extends StatelessWidget {
  const TheMostPopularWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryCubit = CategoryCubit.get(context);

    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context).textTheme;
    return SizedBox(
      width: size.width,
      // height: size.height ,    //0.44
      child: BlocConsumer<CategoryCubit, CategoryState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: mainListData.length,
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(childAspectRatio: 0.5, crossAxisCount: 2),
            itemBuilder: (context, index) {
              BaseModel current = mainListData[index];
              return InkWell(
                onTap: () {
                  AppFunctions.navigateTo(
                    context,
                    DetailsScreen(
                      data: mainListData[index],
                      isCameFromMostPopularPart:
                          true, // so the tag in the details screen will be (current.imageUrl)
                    ),
                  );
                },
                child: Stack(
                  children: [
                    ///---------the image---------->
                    Hero(
                      tag: current.imageUrl,
                      child: Container(
                        width: size.width * 0.5,
                        height: size.height * 0.3,
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

                    ///---------addToFavouriteIcon---------->
                    Positioned(
                      top: size.height * 0.02,
                      left: size.width * 0.05,
                      child: CircleAvatar(
                        radius: 17,
                        backgroundColor: AppColors.offwhite,
                        child: Center(
                          child: IconButton(
                            onPressed: () {
                              // categoryCubit.addToFavourite(current, context);
                              categoryCubit.toggleFavourite( current, context);
                            },
                            icon: SizedBox(
                              width: 20,
                              height: 20,
                              child: categoryCubit.favourite ? favouriteIcon : notFavouriteIcon,
                            ),
                            iconSize: 20,
                          ),
                        ),
                      ),
                    ),

                    ///---------add price of the item---------->
                    Positioned(
                      bottom: size.height * 0.07,
                      left: size.width * 0.05,
                      child: ReusableRichText(
                          text: current.price.toString(),
                          style1: theme.titleMedium,
                          style2: theme.titleMedium?.copyWith(color: AppColors.primaryColor)),
                    ),

                    ///---------add name of the item---------->
                    Positioned(
                      bottom: size.height * 0.1,
                      left: size.width * 0.05,
                      child: Text(
                        current.name,
                        style: theme.titleMedium,
                      ),
                    ),

                    ///---------addToCartIcon---------->
                    Positioned(
                      bottom: size.height * 0.09,
                      right: size.width * 0.06,
                      child: Container(
                        height: 30,
                        width: 35,
                        decoration: BoxDecoration(
                          color: categoryCubit.onTheCart? AppColors.green: AppColors.red,
                          // color: AppColors.primaryColor,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                        child: IconButton(
                          onPressed: () {
                            // categoryCubit.addToCart(current, context);
                            categoryCubit.toggleCart(current, context);
                          },
                          icon:
                          // categoryCubit.onTheCart? onTheCartIcon: notOnTheCartIcon,
                          const Icon(
                            Icons.add_shopping_cart_sharp,
                            color: AppColors.offwhite,
                          ),
                          iconSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

var notFavouriteIcon = const Icon(Icons.favorite_outline_sharp);
var favouriteIcon = const Icon(Icons.favorite,color: AppColors.red,);
var notOnTheCartIcon = const Icon(Icons.add_shopping_cart_sharp,color: AppColors.red,);
var onTheCartIcon = const Icon(Icons.add_shopping_cart_sharp,color: AppColors.green,);