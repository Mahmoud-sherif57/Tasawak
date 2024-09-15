import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:tasawak/view_model/utils/app_colors.dart';

class ReusableTextFormField extends StatelessWidget {
  const ReusableTextFormField({
    required this.hintText,
    required this.labelText,
    super.key,
    required this.animationDuration,
    this.controller,
    this.keyboardType,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
  });

  final String hintText;
  final String labelText;
  final int animationDuration;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final  String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return FadeInUp(
      delay: Duration(milliseconds: animationDuration),
      child: TextFormField(
        controller: controller,
        validator: validator,
        keyboardType: keyboardType,
        textInputAction: TextInputAction.next,
        // obscureText: AuthCubit.get(context).hidden,
        decoration: InputDecoration(
          fillColor: AppColors.white,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: AppColors.primaryColor, width: 3),
            borderRadius: BorderRadius.circular(30),
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.lightGreen, width: 2),
              borderRadius: BorderRadius.circular(30)),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          // it just works in the password field ..
          // suffixIcon: IconButton(
          //   color: AppColors.primaryColor,
          //   onPressed: () {
          //     AuthCubit.get(context).togglePassword();
          //     // setState(() {
          //     //   hidden = !hidden;
          //     // });
          //   },
          //   icon: AuthCubit.get(context).hidden
          //       ? hiddenicon
          //       : unhiddenicon,
          // ),
          hintText: hintText,
          hintStyle: theme.titleMedium?.copyWith(color: AppColors.gray),
          labelText: labelText,
          labelStyle: theme.titleMedium?.copyWith(color: AppColors.gray),
        ),
      ),
    );
  }
}
