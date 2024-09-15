import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasawak/view/screens/splash/splash_screen.dart';
import 'package:tasawak/view_model/cubits/auth/auth_cubit.dart';
import 'package:tasawak/view_model/cubits/categories/category_cubit.dart';
import 'firebase_options.dart';
import 'view_model/utils/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  // await SharedHelper.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.android,
  );

  runApp(
    const Tasawak(),
  );
}

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
              create: (context) => AuthCubit(),
            ),
            // BlocProvider(
            //   create: (context) => SplashCubit()..appStarted(),
            // ),
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

/// to generate the locale keys
/// flutter pub run easy_localization:generate -S assets/translation -O assets/translation -o local_keys.g.dart -f keys

/// to get the latest version of packages
/// flutter pub upgrade --major-versions
