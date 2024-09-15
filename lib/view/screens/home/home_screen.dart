import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:tasawak/model/categories/categories_model.dart';
import 'package:tasawak/view/screens/detailsScreen/details_screen.dart';
import 'package:tasawak/view/screens/home/widgets/theMost_popular.dart';
import 'package:tasawak/view_model/data/local/category-data.dart';
import 'package:tasawak/view_model/utils/app_colors.dart';
import 'package:tasawak/view_model/utils/app_functions.dart';

import 'widgets/card_view_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // this initState function to handle the size of the category card..
  late PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController(
      initialPage: 1, // the index of the category appear in the ui
      viewportFraction: 0.7,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: AppColors.offwhite,
      body: SafeArea(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: SingleChildScrollView(
            // physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///-----------------start the the top text section---------------->
                FadeInUp(
                  duration: const Duration(milliseconds: 300),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: (Column(
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
                    )),
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
                      itemCount: categoriesData.length,
                      itemBuilder: (context, index) {
                        CategoriesModel data = categoriesData[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              CircleAvatar(
                                backgroundImage: AssetImage(data.imageUrl),
                                radius: 30,
                              ),
                              SizedBox(
                                height: size.height * 0.008,
                              ),
                              Text(
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
                      controller: _controller,
                      physics: const BouncingScrollPhysics(),
                      itemCount: mainListData.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                            onTap: () {
                              AppFunctions.navigateTo(
                                context,
                                DetailsScreen(
                                  data: mainListData[index],
                                  isCameFromMostPopularPart:
                                      false, // so tag in the details screen will be (current.id)
                                ),
                              );
                            },
                            child: cardViewAnimation(index, theme, size));
                      },
                    ),
                  ),
                ),

                ///-----------------start the most popular text---------------->

                FadeInUp(
                  duration: const Duration(milliseconds: 650),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                    child: (Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Most Popular', style: theme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                        // Text('See all', style: theme.titleSmall?.copyWith(color: AppColors.blue)),
                      ],
                    )),
                  ),
                ),

                ///-----------------start the most popular section---------------->

                FadeInUp(duration: const Duration(milliseconds: 750), child: const TheMostPopularWidget()),
              ],
            ),
          ),
        ),
      ),
    );
  }

//
//
//
//
//
//
//
//
//
//
  // this widget is used to handle the animation of the cardView ..
  /// custom this widget
  Widget cardViewAnimation(int index, TextTheme theme, Size size) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        double value = 0;
        if (_controller.position.haveDimensions) {
          value = index.toDouble() - (_controller.page ?? 0);
          value = (value * 0.04).clamp(-1, 1);
        }
        return Transform.rotate(
          angle: 8 * value,
          // angle: 3.14 * value,
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
