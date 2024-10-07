import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasawak/view/screens/splash/splash_screen.dart';
import 'package:tasawak/view_model/cubits/auth/auth_cubit.dart';
import 'package:tasawak/view_model/cubits/categories/category_cubit.dart';
import 'package:tasawak/view_model/cubits/home/home_screen_cubit.dart';
import 'package:tasawak/view_model/cubits/search/search_cubit.dart';
import 'package:tasawak/view_model/utils/app_theme.dart';

class Tasawak extends StatelessWidget {
  const Tasawak({super.key});

  @override
  Widget build(BuildContext context) {
    // we wrapped the multiBlocProvider with ScreenUtilInit to handle the responsive UI,
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      splitScreenMode: true,
      minTextAdapt: true,
      builder: (_, child) {
        // we wrapped the MaterialAPP with multiBlocProvider to handle the stateManagement,
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              // create: (context) => AuthCubit()..getUserInfoFromHive(),
              create: (context) => AuthCubit()..getUserDataFromFirestore(),
            ),
            BlocProvider(
              create: (context) => HomeScreenCubit(),
            ),
            BlocProvider(
              create: (context) => SearchCubit(),
            ),
            BlocProvider(
              create: (context) => CategoryCubit(),
            ),
          ],
          child: MaterialApp(
            // to handle the localization
            // localizationsDelegates: context.localizationDelegates,
            // supportedLocales: context.supportedLocales,
            // locale: context.locale,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.appTheme,
            home: const SplashScreen(),
          ),
        );
      },
    );
  }
}
