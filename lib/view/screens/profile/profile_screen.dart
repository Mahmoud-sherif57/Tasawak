import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasawak/view/screens/profile/widgets/settingMenuTile.dart';
import 'package:tasawak/view_model/cubits/auth/auth_cubit.dart';
import 'package:tasawak/view_model/cubits/auth/auth_state.dart';
import 'package:tasawak/view_model/utils/app_colors.dart';

import '../../../view_model/utils/app_functions.dart';
import '../auth/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                if(state is SigningOutSuccessfulState){
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
                                'User Account',
                                style: theme.headlineSmall,
                              ),
                              ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: AppColors.primaryColor2,
                                  radius: 25,
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.person,
                                      size: 25,
                                    ),
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                                title: Text(FirebaseAuth.instance.currentUser?.displayName ?? "user name"),
                                textColor: AppColors.offwhite,
                                subtitle: Text(
                                  FirebaseAuth.instance.currentUser?.email ?? "user email",
                                  overflow: TextOverflow.ellipsis,
                                ),
                                trailing: IconButton(
                                  color: AppColors.primaryColor2,
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.edit,
                                  ),
                                ),
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
                              const SettingMenuTileWidget(
                                title: 'My addresses',
                                subtitle: 'set shopping delivery address',
                                leadingIcon: Icons.home,
                              ),
                               const SettingMenuTileWidget(
                                title: 'My Cart',
                                subtitle: 'Add, remove from cart',
                                leadingIcon: Icons.shopping_cart,
                                // onTap: AppFunctions.navigateTo(context,const CartScreen()),
                                // this line causes crash try to figure out why this happen,
                              ),
                              const SettingMenuTileWidget(
                                // here is the history of the user orders
                                title: 'My Orders',
                                subtitle: 'In Progress & Completed Orders',
                                leadingIcon: Icons.shopping_bag,
                              ),
                              const SettingMenuTileWidget(
                                title: 'Notifications',
                                subtitle: 'set any notifications message',
                                leadingIcon: Icons.notifications,
                              ),
                              SettingMenuTileWidget(
                                title: 'Sign Out',
                                subtitle: 'remove your account and sign out',
                                leadingIcon: Icons.logout_outlined,
                                onTap: AuthCubit.get(context).signOutFirebase,
                              ),
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
