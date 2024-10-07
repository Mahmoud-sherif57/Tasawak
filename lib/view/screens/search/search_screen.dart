import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasawak/model/categories/base_model.dart';
import 'package:tasawak/view/screens/detailsScreen/details_screen.dart';
import 'package:tasawak/view_model/cubits/categories/category_cubit.dart';
import 'package:tasawak/view_model/cubits/categories/category_state.dart';
import 'package:tasawak/view_model/cubits/search/search_cubit.dart';
import 'package:tasawak/view_model/cubits/search/search_state.dart';
import 'package:tasawak/view_model/data/local/category_data.dart';
import 'package:tasawak/view_model/utils/app_assets.dart';
import 'package:tasawak/view_model/utils/app_colors.dart';
import 'package:tasawak/view_model/utils/app_functions.dart';
import 'package:tasawak/view_model/utils/reusable_widgets/reusable_rich_text.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});



  @override
  Widget build(BuildContext context) {
    final categoryCubit = CategoryCubit.get(context);
    final searchCubit = SearchCubit.get(context);
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context).textTheme;
    return InkWell(
      /// try to handle this it doesn't work'
      onTap: () => FocusManager.instance.primaryFocus?.unfocus,
      child: Scaffold(
        backgroundColor: AppColors.offwhite,
        body: BlocBuilder<SearchCubit, SearchState>(
          builder: (context, state) {
            return BlocConsumer<CategoryCubit, CategoryState>(
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                return SizedBox(
                  width: size.width,
                  height: size.height,
                  child: FadeInUp(
                    delay: const Duration(milliseconds: 50),
                    child: Column(
                      children: [
                        ///-------------start the searchField section------------>
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: size.height * 0.01, horizontal: size.width * 0.03),
                          child: SizedBox(
                            width: size.width,
                            height: size.height * 0.06,
                            child: TextFormField(
                              controller: searchCubit.searchController,
                              onChanged: (value) => searchCubit.onSearch(value),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                fillColor: AppColors.offwhite,
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: AppColors.primaryColor,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.lightGreen, width: 2),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    searchCubit.canselTheSearch();
                                  },
                                  icon: const Icon(Icons.close),
                                ),
                                hintText: 'e.g.sweat shirt',
                                hintStyle: theme.titleMedium?.copyWith(color: AppColors.darkGray),
                              ),
                            ),
                          ),
                        ),
                        // end of the search section
                        SizedBox(
                          height: size.height * 0.001,
                        ),

                        ///-------------start showing the items on search section------------->
                        Expanded(
                          // flex: 8,
                          child: searchCubit.itemsOnSearch.isNotEmpty
                              ? GridView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: searchCubit.itemsOnSearch.length,
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 0.55, crossAxisCount: 2),
                                  itemBuilder: (context, index) {
                                    BaseModel current = searchCubit.itemsOnSearch[index];
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
                                                style2: theme.titleLarge
                                                    ?.copyWith(color: AppColors.primaryColor)),
                                          ),

                                          ///---------addToCartIcon---------->
                                          Positioned(
                                            bottom: size.height * 0.05,
                                            right: size.width * 0.06,
                                            child: Container(
                                              height: 30,
                                              width: 35,
                                              decoration: BoxDecoration(
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
                                                  icon:
                                                      current.isFavourite ? favouriteIcon : notFavouriteIcon,
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

                              ///-------------start the NotFound on search section-------->
                              : ListView(
                                  children: [
                                    FadeInUp(
                                      delay: const Duration(milliseconds: 100),
                                      child: Image(
                                        image: AssetImage(AppAssets.emptyLogo),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(height: size.height * 0.01),
                                    FadeInUp(
                                        delay: const Duration(milliseconds: 200),
                                        child: Center(
                                          child: Text(
                                            'Oops! , No results found . ',
                                            style: theme.titleLarge,
                                          ),
                                        ))
                                  ],
                                ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

var notFavouriteIcon = const Icon(Icons.favorite_outline_sharp);
var favouriteIcon = const Icon(
  Icons.favorite,
  color: AppColors.red,
);
var notOnTheCartIcon = const Icon(
  Icons.add_shopping_cart_sharp,
  color: AppColors.primaryColor,
);
var onTheCartIcon = const Icon(
  Icons.add_shopping_cart_sharp,
  color: AppColors.green,
);
