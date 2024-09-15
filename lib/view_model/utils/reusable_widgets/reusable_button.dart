import 'package:flutter/material.dart';

import '../app_colors.dart';

class ReUsableButton extends StatelessWidget {
  const ReUsableButton({
    super.key,
    // required this.size,
    // required this.theme,
    required this.text,
    required this.onPressed,
  });

  // final Size size;
  // final TextTheme theme;
  final String text;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {

    var theme = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;
    return MaterialButton(
      onPressed: onPressed,
      minWidth: size.width * 0.9,
      height: size.height * 0.07,
      color: AppColors.orange,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        text,
        style: theme.headlineMedium?.copyWith(color: AppColors.white),
      ),
    );
  }
}
