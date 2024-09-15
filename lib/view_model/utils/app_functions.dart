
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AppFunctions {
  //1
  static Future navigateTo(BuildContext context,Widget screen) {
    return Navigator.push(context, MaterialPageRoute(builder: (context) {
      return screen;
    }));
  }

  //2
  static navigateAndReplacement(BuildContext context, Widget screen) {
    return Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) {
      return screen;
    }));
  }

  //3
  static navigateAndRemove(BuildContext context, Widget screen) {
    return Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) {
        return screen;
      }),
      (route) => false,
    );
  }

  //4
  static navigatePop(BuildContext context) {
    return Navigator.pop(context);
  }

  //5
  static translationFunction(BuildContext context) {
    return IconButton(
      onPressed: () {
        if (context.locale.toString() == 'ar') {
          context.setLocale(const Locale('en'));
        } else {
          context.setLocale(const Locale('ar'));
        }
      },
      icon: const Icon(Icons.translate),
    );
  }

  //6
  static backButton( BuildContext context){
    return IconButton(onPressed: (){
     Navigator.canPop(context);
    }, icon:const Icon (Icons.arrow_back));
  }
}

//NOTES:
// we can call this page (app_function or utils)
// this page has the whole functions i create to use it easily just by calling the class
// we used static before the function to allow me access it by the class
// ex: AppFunction.navigateTo  OR  AppFunction.navigateAndReplacement
