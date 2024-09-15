// import 'package:animate_do/animate_do.dart';
// import 'package:bottom_bar_matu/bottom_bar/bottom_bar_bubble.dart';
// import 'package:bottom_bar_matu/bottom_bar_item.dart';
// import 'package:flutter/material.dart';
// import 'package:tasawak/view/screens/cart/cart_screen.dart';
// import 'package:tasawak/view/screens/home/home_screen.dart';
// import 'package:tasawak/view/screens/profile/profile_screen.dart';
// import 'package:tasawak/view/screens/search/search_screen.dart';
// import 'package:tasawak/view_model/utils/app_colors.dart';
// import 'package:tasawak/view_model/utils/app_functions.dart';
//
// class WrapperHomeScreen extends StatefulWidget {
//   const WrapperHomeScreen({super.key});
//
//   @override
//   State<WrapperHomeScreen> createState() => _WrapperHomeScreenState();
// }
//
// class _WrapperHomeScreenState extends State<WrapperHomeScreen> {
//   // Define a list of pages corresponding to the bottom bar items
//   final List<Widget> _pages = [
//     const HomeScreen(), // Home Page
//     const SearchScreen(), // Search Page
//     const CartScreen(), // cart Page
//     const ProfileScreen(), // Settings Page
//   ];
//
//   int _selectedIndex = 0; // Track selected index
//   // bool isSearchActive = false;
//   @override
//   Widget build(BuildContext context) {
//     // var size = MediaQuery.of(context).size;
//     var theme = Theme.of(context).textTheme;
//     return Scaffold(
//       backgroundColor: AppColors.offwhite,
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         elevation: 0,
//         surfaceTintColor: AppColors.offwhite,
//         backgroundColor: AppColors.offwhite,
//         // leading: IconButton(
//         //   iconSize: 30,
//         //   color: AppColors.primaryColor2,
//         //   onPressed: () {},
//         //   icon: const Icon(LineIcons.userCircle),
//         // ),
//         title: FadeInUp(
//           child: TextButton(
//             onPressed: () {
//               AppFunctions.navigateTo(context, const WrapperHomeScreen());
//             },
//             child: Text(
//               'tasawak',
//               style:
//                   theme.headlineLarge?.copyWith(fontWeight: FontWeight.bold, color: AppColors.primaryColor),
//             ),
//           ),
//         )
//         // isSearchActive
//         //     ? FadeIn(
//         //         child: Text(
//         //           'Search',
//         //           style: theme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
//         //         ),
//         //       )
//         //     : FadeIn(
//         //         child: Text(
//         //           'Home',
//         //           style: theme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
//         //         ),
//         //       )
//         ,
//         // actions: const [
//         //   IconButton(
//         //     onPressed: () {
//         //       setState(() {
//         //         isSearchActive = !isSearchActive;
//         //       });
//         //     },
//         //     icon: isSearchActive
//         //         ? const Icon(LineIcons.home, color: AppColors.primaryColor2, size: 30)
//         //         : const Icon(LineIcons.search, color: AppColors.primaryColor2, size: 30),
//         //   ),
//         //   IconButton(
//         //     onPressed: () {
//         //       AppFunctions.navigateTo(context, const CartScreen());
//         //     },
//         //     icon: const Icon(LineIcons.shoppingBag, color: AppColors.primaryColor2, size: 30),
//         //   ),
//         // ],
//       ),
//       body: _pages[_selectedIndex],
//       // body: isSearchActive ? const SearchScreen() : const HomeScreen(),
//       bottomNavigationBar: BottomBarBubble(
//         color: AppColors.primaryColor,
//         backgroundColor: AppColors.offwhite,
//         selectedIndex: _selectedIndex,
//         onSelect: (index) {
//           setState(() {
//             _selectedIndex = index;
//           });
//         },
//         items: [
//           BottomBarItem(iconData: Icons.home),
//           BottomBarItem(iconData: Icons.search),
//           BottomBarItem(iconData: Icons.shopping_cart),
//           BottomBarItem(iconData: Icons.person),
//         ],
//       ),
//     );
//   }
// }
