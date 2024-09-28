import 'dart:io';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasawak/view_model/cubits/auth/auth_cubit.dart';
import 'package:tasawak/view_model/utils/app_colors.dart';
import '../../../view_model/cubits/auth/auth_state.dart';

class UserDetails extends StatelessWidget {
  const UserDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = AuthCubit.get(context);

    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: AppColors.offwhite,
      appBar: AppBar(
        title: Text("Details", style: theme.headlineLarge),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Column(
              children: [
                FadeInUp(
                  delay: const Duration(milliseconds: 100),
                  child: Stack(
                    children: [
                      authCubit.myImage == null
                          ? CircleAvatar(
                              backgroundColor: AppColors.primaryColor2,
                              radius: 80,
                              child: Icon(
                                Icons.person,
                                size: size.height * 0.1,
                                color: AppColors.primaryColor,
                              ),
                            )
                          : CircleAvatar(
                              backgroundImage:
                                  authCubit.myImage != null ? FileImage(File(authCubit.myImage!.path)) : null,
                              backgroundColor: AppColors.primaryColor2,
                              radius: 80,
                            ),
                      Positioned(
                        left: size.height * 0.14,
                        bottom: size.height * 0.001,
                        child: CircleAvatar(
                          radius: 22,
                          backgroundColor: AppColors.primaryColor,
                          child: IconButton(
                            color: AppColors.primaryColor2,
                            onPressed: () {
                              authCubit.pickImageFromGallery();
                            },
                            icon: Icon(
                              Icons.add_a_photo_rounded,
                              size: size.height * 0.03,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.05),
                FadeInUp(
                  delay: const Duration(milliseconds: 150),
                  child: ListTile(
                    leading: const Icon(
                      Icons.person,
                      color: AppColors.primaryColor2,
                    ),
                    title: const Text(" Name : "),
                    textColor: AppColors.primaryColor2,
                    subtitle: Text(
                      authCubit.userDataList.isNotEmpty
                          ? authCubit.userDataList.last['name']
                          : "xxxxxxxx xxxxxxxxx",
                      // FirebaseAuth.instance.currentUser?.displayName ?? "xxxxxxxx xxxxxx",
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: IconButton(
                      color: AppColors.primaryColor2,
                      onPressed: () {},
                      icon: const Icon(
                        Icons.edit,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ),
                FadeInUp(
                  delay: const Duration(milliseconds: 200),
                  child: ListTile(
                    leading: const Icon(
                      Icons.email,
                      color: AppColors.primaryColor2,
                    ),
                    title: const Text(" Email :"),
                    textColor: AppColors.primaryColor2,
                    subtitle: Text(
                      authCubit.userDataList.isNotEmpty
                          ? authCubit.userDataList.last['email']
                          : "xxxxxxxx xxxxxxxxx",
                      // FirebaseAuth.instance.currentUser?.email ?? "xxxxxxxxxxxxx@xxxx.com",
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: IconButton(
                      color: AppColors.primaryColor2,
                      onPressed: () {},
                      icon: const Icon(
                        Icons.edit,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ),
                FadeInUp(
                  delay: const Duration(milliseconds: 250),
                  child: ListTile(
                    leading: const Icon(
                      Icons.phone,
                      color: AppColors.primaryColor2,
                    ),
                    title: const Text(" Phone :"),
                    textColor: AppColors.primaryColor2,
                    subtitle: Text(
                      authCubit.userDataList.isNotEmpty
                          ? authCubit.userDataList.last['phoneNumber']
                          : "xxxxxxxx xxxxxxxxx",
                      // AuthCubit.get(context).phoneController.text,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: IconButton(
                      color: AppColors.primaryColor2,
                      onPressed: () {},
                      icon: const Icon(
                        Icons.edit,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ),
                FadeInUp(
                  delay: const Duration(milliseconds: 300),
                  child: ListTile(
                    leading: const Icon(
                      Icons.home,
                      color: AppColors.primaryColor2,
                    ),
                    title: const Text(" Address :"),
                    textColor: AppColors.primaryColor2,
                    subtitle: Text(
                      authCubit.userDataList.isNotEmpty
                          ? authCubit.userDataList.last['address']
                          : "xxxxxxxx xxxxxxxxx",
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: IconButton(
                      color: AppColors.primaryColor2,
                      onPressed: () {},
                      icon: const Icon(
                        Icons.edit,
                        color: AppColors.primaryColor,
                      ),
                    ),
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
