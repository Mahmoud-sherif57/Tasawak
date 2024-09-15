import 'package:animate_do/animate_do.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:tasawak/view_model/utils/app_colors.dart';

import '../../../view_model/cubits/categories/category_cubit.dart';
import '../../../view_model/utils/app_functions.dart';
import '../cart/cart_screen.dart';
import '../favourite_screen/favourite_screen.dart';
import '../home/home_screen.dart';
import '../profile/profile_screen.dart';
import '../search/search_screen.dart';

class WrapperHomeScreen2 extends StatefulWidget {
  const WrapperHomeScreen2({super.key});

  @override
  _WrapperHomeScreen2State createState() => _WrapperHomeScreen2State();
}

class _WrapperHomeScreen2State extends State<WrapperHomeScreen2> {
  late final List<Widget> _pages = [
    const HomeScreen(), // Home Page
    const SearchScreen(), // Search Page
    const CartScreen(), // cart Page
    const FavouriteScreen(), //FavouriteScreen
    const ProfileScreen(), // Settings Page
  ];
  int _selectedIndex = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: AppColors.offwhite,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          surfaceTintColor: AppColors.offwhite,
          backgroundColor: AppColors.offwhite,
          // leading: IconButton(
          //   iconSize: 30,
          //   color: AppColors.primaryColor2,
          //   onPressed: () {},
          //   icon: const Icon(LineIcons.userCircle),
          // ),
          title: FadeInUp(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    AppFunctions.navigateTo(context, const WrapperHomeScreen2());
                  },
                  child: Text(
                    'tasawak',
                    style: theme.headlineLarge
                        ?.copyWith(fontWeight: FontWeight.bold, color: AppColors.primaryColor),
                  ),
                ),
                ///-------------the item's count in the cart------->
                SizedBox(
                  height: 50,
                  width: 50,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      const Icon(
                        Icons.shopping_cart,
                        color: AppColors.primaryColor2,
                        size: 35,
                      ),
                      Positioned(
                        bottom: size.height * 0.035,
                        left: size.width * 0.08,
                        child: CircleAvatar(
                          radius: 10,
                          backgroundColor: AppColors.primaryColor,
                          child: Center(
                            child: Text(
                              CategoryCubit.get(context).itemsOnCart.length.toString(),
                              style: theme.labelLarge,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
          // isSearchActive
          //     ? FadeIn(
          //         child: Text(
          //           'Search',
          //           style: theme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
          //         ),
          //       )
          //     : FadeIn(
          //         child: Text(
          //           'Home',
          //           style: theme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
          //         ),
          //       )
          ,
          // actions: const [
          //   IconButton(
          //     onPressed: () {
          //       setState(() {
          //         isSearchActive = !isSearchActive;
          //       });
          //     },
          //     icon: isSearchActive
          //         ? const Icon(LineIcons.home, color: AppColors.primaryColor2, size: 30)
          //         : const Icon(LineIcons.search, color: AppColors.primaryColor2, size: 30),
          //   ),
          //   IconButton(
          //     onPressed: () {
          //       AppFunctions.navigateTo(context, const CartScreen());
          //     },
          //     icon: const Icon(LineIcons.shoppingBag, color: AppColors.primaryColor2, size: 30),
          //   ),
          // ],
        ),
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: _selectedIndex,
          height: 55,
          items: const <Widget>[
            Icon(
              Icons.home,
              size: 30,
              color: AppColors.primaryColor2,
            ),
            Icon(
              Icons.search,
              size: 30,
              color: AppColors.primaryColor2,
            ),
            Icon(
              Icons.shopping_cart,
              size: 30,
              color: AppColors.primaryColor2,
            ),
            Icon(
              Icons.favorite,
              size: 30,
              color: AppColors.primaryColor2,
            ),
            Icon(
              Icons.person,
              size: 30,
              color: AppColors.primaryColor2,
            ),
          ],
          color: AppColors.primaryColor,
          buttonBackgroundColor: AppColors.offwhite,
          backgroundColor: AppColors.offwhite,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 450),
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          letIndexChange: (index) => true,
        ),
        body: _pages[_selectedIndex]);
  }
}
