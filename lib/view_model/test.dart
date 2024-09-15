
// the main file from groceries app



// import 'package:easy_localization/easy_localization.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:groceries_app/view/screens/splash/splash_screen.dart';
// import 'package:groceries_app/view_model/data/local/shared_helper.dart';
//
// import 'cubits/auth/auth_cubit.dart';
// import 'cubits/counter/counter_cubit.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await EasyLocalization.ensureInitialized();
//   await SharedHelper.init();
//
//
//   runApp(
//     EasyLocalization(
//       supportedLocales: const [Locale('en'), Locale('ar')],
//       path: "assets/translation",
//       fallbackLocale: const Locale('en'),
//       child: const GroceriesApp(),
//     ),
//   );
// }
//
// class GroceriesApp extends StatelessWidget {
//   const GroceriesApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     // we wrapped the multiBlocProvider with ScreenUtilInit to handle the responsive UI,
//     return ScreenUtilInit(
//       designSize: const Size(414, 896),
//       splitScreenMode: true,
//       minTextAdapt: true,
//       builder: (_, child) {
//         // we wrapped the MaterialAPP with multiBlocProvider to handle the stateManagement,
//         return MultiBlocProvider(
//           providers: [
//             BlocProvider(
//               create: (context) => CounterCubit(),
//             ),
//             BlocProvider(
//               create: (context) => AuthCubit(),
//             )
//           ],
//           child: MaterialApp(
//             // to handle the localization
//             localizationsDelegates: context.localizationDelegates,
//             supportedLocales: context.supportedLocales,
//             locale: context.locale,
//             debugShowCheckedModeBanner: false,
//             home: const SplashScreen(),
//           ),
//         );
//       },
//     );
//   }
// }
//
// /// to generate the locale keys
// /// flutter pub run easy_localization:generate -S assets/translation -O lib/view_model/utils -o local_keys.g.dart -f keys
//
//



//  start Adding carouselSlider

// CarouselSlider(
//   items: sliderImgList
//       .map((e) => Image.asset(
//             e,
//             fit: BoxFit.contain,
//           ))
//       .toList(),
//   options: CarouselOptions(
//     autoPlayCurve: Curves.fastOutSlowIn,
//     height: 125.h,
//     viewportFraction: 0.8,
//     initialPage: 0,
//     autoPlay: true,
//     autoPlayInterval: const Duration(seconds: 2),
//     enlargeCenterPage: true,
//     // enlargeFactor: 0.6,
//     // setState to the indicator
//     onPageChanged: (value, _) {
//       setState(() {
//         _currentPage = value;
//       });
//     },
//   ),
// ),
// end of carousalSlider

