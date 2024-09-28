import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasawak/view_model/utils/app_colors.dart';
import '../../../view_model/cubits/categories/category_cubit.dart';
import '../../../view_model/cubits/categories/category_state.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryCubit = CategoryCubit.get(context);

    var theme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: AppColors.offwhite,
      appBar: AppBar(
        title: Text("Settings", style: theme.headlineLarge),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: BlocConsumer<CategoryCubit, CategoryState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FadeInUp(
                  delay: const Duration(milliseconds: 100),
                  child: SwitchListTile(
                    title: Text(' Theme Mode', style: theme.titleLarge),
                    subtitle: categoryCubit.isThemeSwitched == true
                        ? Text('Dark Mode', style: theme.labelLarge!.copyWith(color: AppColors.primaryColor2),)
                        : Text('Light Mode', style: theme.labelLarge!.copyWith(color: AppColors.primaryColor2)),
                    secondary: categoryCubit.isThemeSwitched == true
                        ? const Icon(
                            Icons.nightlight_round_rounded,
                            color: AppColors.primaryColor,
                          )
                        : const Icon(
                            Icons.sunny,
                            color: AppColors.primaryColor,
                          ),
                    value: categoryCubit.isThemeSwitched,
                    onChanged: (value) {
                      categoryCubit.switchThemeMode(value);
                    },
                    inactiveTrackColor: AppColors.white,
                    inactiveThumbColor: AppColors.green,
                    activeTrackColor: AppColors.black,
                    activeColor: AppColors.red,
                  ),
                ),
                FadeInUp(
                  delay: const Duration(milliseconds: 200),
                  child: SwitchListTile(
                    title: Text('Language', style: theme.titleLarge),
                    subtitle: categoryCubit.isLanguageSwitched == true
                        ? Text('Arabic', style: theme.labelLarge!.copyWith(color: AppColors.primaryColor2))
                        : Text('English', style: theme.labelLarge!.copyWith(color: AppColors.primaryColor2)),
                    secondary: categoryCubit.isLanguageSwitched == true
                        ? const Icon(
                            Icons.language_rounded,
                            color: AppColors.primaryColor,
                          )
                        : const Icon(
                            Icons.sunny,
                            color: AppColors.primaryColor,
                          ),
                    value: categoryCubit.isLanguageSwitched,
                    onChanged: (value) {
                      categoryCubit.switchLanguage(value);
                    },
                    inactiveTrackColor: AppColors.white,
                    inactiveThumbColor: AppColors.green,
                    activeTrackColor: AppColors.black,
                    activeColor: AppColors.red,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
