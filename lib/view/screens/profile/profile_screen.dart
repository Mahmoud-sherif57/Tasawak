import 'dart:io';
import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasawak/view/screens/setting/setting_screen.dart';
import 'package:tasawak/view/screens/user_details/user_details_screen.dart';
import 'package:tasawak/view/screens/profile/widgets/setting_menu_tile.dart';
import 'package:tasawak/view_model/cubits/auth/auth_cubit.dart';
import 'package:tasawak/view_model/cubits/auth/auth_state.dart';
import 'package:tasawak/view_model/utils/app_colors.dart';
import '../../../view_model/cubits/categories/category_cubit.dart';
import '../../../view_model/utils/app_functions.dart';
import '../auth/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CategoryCubit.get(context);
    final authCubit = AuthCubit.get(context);

    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: AppColors.offwhite,
      body: Center(
        child: FadeInUp(
          delay: const Duration(milliseconds: 100),
          child: SizedBox(
            width: size.width * 0.95,
            height: size.height * 0.8,
            child: BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is SigningOutSuccessfulState) {
                  AppFunctions.navigateTo(context, LogInScreen());
                }
              },
              builder: (context, state) {
                return Stack(
                  children: [
                    SizedBox(
                      width: size.width * 0.95,
                      height: size.height * 0.3,
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            bottomLeft: Radius.circular(25),
                            topRight: Radius.circular(25),
                            bottomRight: Radius.circular(25),
                          ),
                          color: AppColors.primaryColor,
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(top: size.height * 0.03),
                          child: Column(
                            children: [
                              Text(
                                'Settings',
                                style: theme.headlineSmall,
                              ),
                              ListTile(
                                leading: authCubit.myImage == null
                                    ? CircleAvatar(
                                        backgroundColor: AppColors.primaryColor2,
                                        radius: 25,
                                        child: Icon(
                                          Icons.person,
                                          size: size.height * 0.06,
                                          color: AppColors.primaryColor,
                                        ),
                                      )
                                    : CircleAvatar(
                                        backgroundImage: authCubit.myImage != null
                                            ? FileImage(File(authCubit.myImage!.path))
                                            : null,
                                        backgroundColor: AppColors.primaryColor2,
                                        radius: 25,
                                      ),
                                title: Text(FirebaseAuth.instance.currentUser?.displayName ?? "user name"),
                                textColor: AppColors.offwhite,
                                subtitle: Text(
                                  FirebaseAuth.instance.currentUser?.email ?? "user email",
                                  overflow: TextOverflow.ellipsis,
                                ),
                                // trailing: IconButton(
                                //   color: AppColors.primaryColor2,
                                //   onPressed: () {},
                                //   icon: const Icon(
                                //     Icons.edit,
                                //   ),
                                // ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: SizedBox(
                        width: size.width * 0.95,
                        height: size.height * 0.63,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: AppColors.primaryColor2,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              bottomLeft: Radius.circular(25),
                              topRight: Radius.circular(30),
                              bottomRight: Radius.circular(25),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text(
                                  'Account Setting',
                                  style: theme.bodyLarge?.copyWith(color: AppColors.offwhite),
                                ),
                              ),
                              SettingMenuTileWidget(
                                title: 'User details',
                                onTap: () {
                                  AppFunctions.navigateTo(context, const UserDetails());
                                },
                                subtitle: 'The details of the account',
                                leadingIcon: Icons.account_box_rounded,
                              ),
                              SettingMenuTileWidget(
                                title: 'chat',
                                subtitle: 'chat with the sales',
                                leadingIcon: Icons.chat_bubble,
                                onTap: () {},
                              ),
                              const SettingMenuTileWidget(
                                // here is the history of the user orders
                                title: 'My Orders',
                                subtitle: 'In Progress & Completed Orders',
                                leadingIcon: Icons.shopping_bag,
                              ),
                              SettingMenuTileWidget(
                                title: 'Settings',
                                subtitle: 'set the settings of the app',
                                leadingIcon: Icons.settings,
                                onTap: () {
                                  AppFunctions.navigateTo(context, const SettingScreen());
                                },
                              ),
                              SettingMenuTileWidget(
                                  title: 'Sign Out',
                                  subtitle: 'remove your account and sign out',
                                  leadingIcon: Icons.logout_outlined,
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => FadeInUp(
                                        delay: const Duration(milliseconds: 50),
                                        child: AlertDialog(
                                          title: const Text('Sign Out '),
                                          contentPadding: const EdgeInsets.all(20),
                                          content: const Text('Are you Sure you want to sign out ?'),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  AppFunctions.navigatePop(context);
                                                },
                                                child: const Text('No')),
                                            TextButton(
                                                onPressed: () {
                                                  AuthCubit.get(context).signOutFirebase(context);
                                                },
                                                child: const Text('Yes')),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
