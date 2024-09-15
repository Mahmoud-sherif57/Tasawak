import 'package:flutter/material.dart';
import 'package:tasawak/view_model/utils/app_colors.dart';

class ReUsableAuthButton extends StatelessWidget {
   const ReUsableAuthButton({
    super.key,
     required this.onPressed,
     required this.text,
  });
final void Function()? onPressed;
final String text;

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context).textTheme;
    return MaterialButton(
      onPressed:onPressed,
      minWidth: size.width * 0.9,
      height: size.height * 0.07,
      color: AppColors.primaryColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)),
      child: Text(text,
          style: theme.headlineMedium
              ?.copyWith(color: AppColors.white)),
    );
  }
}