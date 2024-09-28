import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasawak/view/screens/home/widgets/card_view_widget.dart';
import 'package:tasawak/view/screens/home/widgets/the_most_popular.dart';
import '../../../model/categories/categories_model.dart';
import '../../../view_model/cubits/home/home_screen_cubit.dart';
import '../../../view_model/cubits/home/home_screen_state.dart';
import '../../../view_model/data/local/category_data.dart';
import '../../../view_model/utils/app_colors.dart';
import '../../../view_model/utils/app_functions.dart';
import '../detailsScreen/details_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.offwhite,
      body: SafeArea(
        child: BlocBuilder<HomeScreenCubit, HomeScreenState>(
          builder: (context, state) {
            var cubit = context.read<HomeScreenCubit>();
            return SizedBox(
              height: size.height,
              width: size.width,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///-----------------start the top text section---------------->
                    FadeInUp(
                      duration: const Duration(milliseconds: 300),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: "Find your",
                                style: theme.headlineLarge,
                                children: [
                                  TextSpan(
                                    text: " Style",
                                    style: theme.headlineLarge?.copyWith(
                                        color: AppColors.primaryColor, fontSize: 45, fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                text: "Be beautiful with our",
                                style: theme.titleMedium,
                                children: [
                                  TextSpan(
                                    text: " suggestions .",
                                    style: theme.titleMedium,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    ///-----------------start the circleAvatar category section---------------->
                    FadeInUp(
                      duration: const Duration(milliseconds: 450),
                      child: Container(
                        margin: const EdgeInsets.only(top: 10),
                        width: size.width,
                        height: size.height * 0.14,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          // itemCount: CategoryCubit.get(context).categoryList0nFS.length,
                          itemCount: categoriesData.length,
                          itemBuilder: (context, index) {
                            // CategoriesModel data = CategoryCubit.get(context).categoryList0nFS[] ;
                            CategoriesModel data = categoriesData[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: AssetImage(data.imageUrl),
                                    // backgroundImage: AssetImage(CategoryCubit.get(context).categoryList0nFS[0]["imageUrl"]),
                                    radius: 30,
                                  ),
                                  SizedBox(
                                    height: size.height * 0.008,
                                  ),
                                  Text(
                                    // CategoryCubit.get(context).categoryList0nFS[0]["title"],
                                    data.title,
                                    style: theme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    ///-----------------start the body section---------------->
                    FadeInUp(
                      duration: const Duration(milliseconds: 550),
                      child: Container(
                        margin: const EdgeInsets.only(top: 10),
                        width: size.width,
                        height: size.height * 0.34,
                        child: PageView.builder(
                          controller: cubit.controller,
                          physics: const BouncingScrollPhysics(),
                          itemCount: mainListData.length,
                          onPageChanged: (index) {
                            cubit.changePage(index);     //  change the page
                          },
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                AppFunctions.navigateTo(
                                  context,
                                  DetailsScreen(
                                    data: mainListData[index],
                                    isCameFromMostPopularPart: false,
                                  ),
                                );
                              },
                              child: cardViewAnimation(context, index, theme, size),
                            );
                          },
                        ),
                      ),
                    ),

                    ///-----------------start the most popular text---------------->
                    FadeInUp(
                      duration: const Duration(milliseconds: 650),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Most Popular', style: theme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),

                    ///-----------------start the most popular section---------------->
                    FadeInUp(duration: const Duration(milliseconds: 750), child: const TheMostPopularWidget()),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
          ///----------------------start the cardView animation----------------------->
  Widget cardViewAnimation(BuildContext context, int index, TextTheme theme, Size size) {
    var cubit = context.read<HomeScreenCubit>();
    return AnimatedBuilder(
      animation: cubit.controller,
      builder: (context, child) {
        double value = 0;
        if (cubit.controller.position.haveDimensions) {
          value = index.toDouble() - (cubit.controller.page ?? 0);
          value = (value * 0.04).clamp(-1, 1);
        }
        return Transform.rotate(
          angle: 8 * value,
          child: CardViewWidget(
            size: size,
            data: mainListData[index],
            theme: theme,
          ),
        );
      },
    );
  }
}
