import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasawak/model/categories/base_model.dart';
import 'package:tasawak/view_model/cubits/categories/category_cubit.dart';
import 'package:tasawak/view_model/data/local/category_data.dart';
import 'package:tasawak/view_model/utils/app_colors.dart';
import 'package:tasawak/view_model/utils/app_functions.dart';
import 'package:tasawak/view_model/utils/reusable_widgets/reusable_button.dart';
import 'package:tasawak/view_model/utils/reusable_widgets/reusable_rich_text.dart';

import '../../../view_model/cubits/categories/category_state.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key, required this.data, required this.isCameFromMostPopularPart});
  final BaseModel data;
  final bool isCameFromMostPopularPart;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  int selectedSize = 2; // the initial size of clothes,
  int selectedColor = 2; // the initial color of clothes,

  _DetailsScreenState();
  @override
  Widget build(BuildContext context) {
    final categoryCubit = CategoryCubit.get(context);
    BaseModel current = widget.data;

    /// why we used widget.data here ?
    var theme = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;
    return BlocConsumer<CategoryCubit, CategoryState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: AppColors.white,
          appBar: AppBar(
            // surfaceTintColor: AppColors.offwhite,
            elevation: 0,
            backgroundColor: Colors.transparent,
            actions: [
              IconButton(
                onPressed: () {
                  categoryCubit.toggleFavourite(current, context);
                },
                icon: current.isFavourite ? favouriteIcon : notFavouriteIcon,
              )
            ],
            leading: IconButton(
              onPressed: () {
                AppFunctions.navigatePop(context);
              },
              icon: const Icon(Icons.arrow_back_ios),
              color: AppColors.black,
            ),
          ),
          body: SizedBox(
            width: size.width,
            height: size.height,
            child: Column(
              children: [
                // starting the top image ..
                SizedBox(
                  width: size.width,
                  height: size.height * 0.5,
                  child: Stack(
                    children: [
                      /// why we used widget. in the tag..?
                      ///  we used inline If here because in need this hero widget to work in tow places
                      ///  with the same tag .if the user came form favourite section the tag will be (current.imageUrl),
                      ///  else the user came from body section the tag will be (current.id)

                      Hero(
                        // this is example if we can make the detail screen have a tag from 3 different places .
                        // if(widget.isCameFromMostPopularPart){
                        // current.imageUrl
                        // }else if(widget.isCameFromSearch){
                        // current.id
                        // }else{
                        // current.name
                        // }
                        tag: widget.isCameFromMostPopularPart ? current.imageUrl : current.id,
                        child: Container(
                          width: size.width,
                          height: size.height * 0.5,
                          decoration: BoxDecoration(
                              image: DecorationImage(image: AssetImage(current.imageUrl), fit: BoxFit.cover)),
                        ),
                      ),
                      // start of the gradients
                      Positioned(
                        bottom: 0,
                        child: FadeInUp(
                          delay: const Duration(milliseconds: 50),
                          child: Container(
                            width: size.width,
                            height: size.height * 0.12,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: AppColors.gradient,
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter),
                            ),
                          ),
                        ),
                      )
                      // end of the gradient
                    ],
                  ),
                ),
                // end of the top image ..

                // start the product info
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                  ),
                  child: SizedBox(
                    width: size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FadeInUp(
                          delay: const Duration(milliseconds: 100),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(current.name, style: theme.headlineLarge),
                              ReusableRichText(
                                text: current.price.toString(),
                                style1: theme.headlineMedium,
                                style2: theme.headlineMedium
                                    ?.copyWith(color: AppColors.primaryColor, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.001,
                        ),
                        FadeInUp(
                          delay: const Duration(milliseconds: 200),
                          child: Row(
                            children: [
                              const Icon(Icons.star, color: AppColors.primaryColor),
                              SizedBox(width: size.width * 0.003),
                              Text(
                                current.star.toString(),
                                style: theme.titleLarge,
                              ),
                              SizedBox(width: size.width * 0.05),
                              Text(
                                "${current.review}K+ review ",
                                style: theme.titleMedium?.copyWith(color: AppColors.gray),
                              ),
                            ],
                          ),
                        ),
                        ///////////////////////////////////////
                        FadeInUp(
                          delay: const Duration(milliseconds: 300),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Select Size',
                              style: theme.titleLarge,
                            ),
                          ),
                        ),
                        /////////////////////////////////
                        FadeInUp(
                          delay: const Duration(milliseconds: 400),
                          child: SizedBox(
                            width: size.width * 0.9,
                            height: size.height * 0.08,
                            child: FadeInUp(
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: sizesList.length,
                                itemBuilder: (context, index) {
                                  String current = sizesList[index];
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedSize = index;
                                      });
                                    },
                                    child: AnimatedContainer(
                                      duration: const Duration(milliseconds: 200),
                                      margin: const EdgeInsets.all(10),
                                      width: size.width * 0.12,
                                      decoration: BoxDecoration(
                                          color: selectedSize == index
                                              ? AppColors.primaryColor
                                              : Colors.transparent,
                                          border: Border.all(color: AppColors.primaryColor, width: 2),
                                          borderRadius: BorderRadius.circular(15)),
                                      child: Center(
                                        child: Text(
                                          current,
                                          style: theme.titleLarge?.copyWith(
                                              color: selectedSize == index
                                                  ? AppColors.white
                                                  : AppColors.primaryColor2),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        //////////////////////////////////////
                        FadeInUp(
                          delay: const Duration(milliseconds: 500),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Select Color',
                              style: theme.titleLarge,
                            ),
                          ),
                        ),
                        ////////////////////////////////////////
                        FadeInUp(
                          delay: const Duration(milliseconds: 550),
                          child: SizedBox(
                            width: size.width * 0.9,
                            height: size.height * 0.08,
                            child: FadeInUp(
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: AppColors.clothesColorsList.length,
                                itemBuilder: (context, index) {
                                  var current = AppColors.clothesColorsList[index];
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedColor = index;
                                      });
                                    },
                                    child: AnimatedContainer(
                                      duration: const Duration(milliseconds: 200),
                                      margin: const EdgeInsets.all(10),
                                      width: size.width * 0.13,
                                      decoration: BoxDecoration(
                                          color: current,
                                          border: Border.all(
                                              color: selectedColor == index
                                                  ? AppColors.primaryColor
                                                  : Colors.transparent,
                                              width: selectedColor == index ? 2 : 1),
                                          borderRadius: BorderRadius.circular(15)),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.01),
                        // start making (add to cart) button
                        FadeInUp(
                          delay: const Duration(milliseconds: 600),
                          child: Center(
                            child: ReUsableButton(
                              text: current.isOnTheCart? " In the cart": "add to cart"  ,
                              onPressed: () {
                                categoryCubit.toggleCart(current, context);
                              },
                            ),
                          ),
                        )
                        // end of making (add to cart) button
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

var notFavouriteIcon = const Icon(Icons.favorite_outline_sharp);
var favouriteIcon = const Icon(
  Icons.favorite,
  color: AppColors.red,
);



