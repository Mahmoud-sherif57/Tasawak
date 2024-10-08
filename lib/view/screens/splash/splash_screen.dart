import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:tasawak/view/screens/auth/auth_screen.dart';
import 'package:tasawak/view_model/cubits/auth/auth_cubit.dart';
import 'package:tasawak/view_model/utils/app_colors.dart';
import 'package:tasawak/view_model/utils/app_functions.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 4),
      () async {
        AppFunctions.navigateTo(context, const AuthScreen());
          // AuthCubit.get(context).getUserInfoFromHive();
          AuthCubit.get(context).getUserDataFromFirestore();
          // to get the user data everyTime the user open the app



        //   const storage = FlutterSecureStorage();
        //   // we called the flutterSecureStorage to see if we have the (token) skip loginScreen and go to HomeScreen..
        //   String? value = await storage.read(key: SharedKeys.token);
        //   if (value != null) { // if storage could find (token) => (we have the token) ..
        //     AppFunctions.navigateTo(context, const WrapperHomeScreen( ));
        //   } else {
        //     AppFunctions.navigateTo(context,  LogInScreen());
        //   }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: AppColors.offwhite,
      body: Center(
        child: SizedBox(
          child: FadeInUp(
            delay: const Duration(milliseconds: 50),
            child: Text(
              "tasawak",
              style: theme.headlineLarge?.copyWith(
                  color: AppColors.primaryColor, fontSize: 60, letterSpacing: 5, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
