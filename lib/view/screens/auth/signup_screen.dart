import 'dart:io';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasawak/view/screens/auth/login_screen.dart';
import 'package:tasawak/view_model/cubits/auth/auth_cubit.dart';
import 'package:tasawak/view_model/cubits/auth/auth_state.dart';
import 'package:tasawak/view_model/utils/app_colors.dart';
import 'package:tasawak/view_model/utils/app_functions.dart';
import 'package:tasawak/view_model/utils/reusable_widgets/reusabel_auth_button.dart';
import 'package:tasawak/view_model/utils/reusable_widgets/reusable_text_form_field.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final authCubit = AuthCubit.get(context);

    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.offwhite,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          surfaceTintColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              AppFunctions.navigatePop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is RegisterSuccessfulState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const
                    SnackBar(
                      backgroundColor: Colors.green,
                      duration: Duration(seconds: 3),
                      content: Text(" Successfully signed up"),
                    ),
                  );
                  AppFunctions.navigateTo(context, LogInScreen());
                } else if (state is RegisterErrorState) {
                  showDialog(
                    context: context,
                    builder: (context) => FadeInUp(
                      delay: const Duration(milliseconds: 50),
                      child: AlertDialog(
                        title: const Text('Failed'),
                        contentPadding: const EdgeInsets.all(20),
                        content:  Text("Failed to sign up ${state.message}"),
                        actions: [
                          TextButton(
                              onPressed: () {
                                AppFunctions.navigatePop(context);
                              },
                              child: const Text('OK')),

                        ],
                      ),
                    ),
                  );
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   SnackBar(
                  //     backgroundColor: Colors.red,
                  //     duration: const Duration(seconds: 3),
                  //     content: Text("Failed to sign up${state.message}"),
                  //   ),
                  // );
                }
              },
              builder: (context, state) {
                return SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FadeInUp(
                          delay: const Duration(milliseconds: 100),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Sign up',
                              style: theme.headlineLarge
                                  ?.copyWith(fontWeight: FontWeight.bold, color: AppColors.primaryColor),
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.03),
                        Stack(
                          children: [
                            authCubit.myImage == null
                                ? CircleAvatar(
                                    backgroundColor: AppColors.primaryColor2,
                                    radius: 50,
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
                                    radius: 50,
                                  ),
                            Positioned(
                              left: size.height * 0.07,
                              top: size.height * 0.075,
                              child: IconButton(
                                color: AppColors.primaryColor,
                                onPressed: () {
                                  authCubit.pickImageFromGallery();
                                },
                                icon: Icon(
                                  Icons.add_a_photo_rounded,
                                  size: size.height * 0.04,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: size.height * 0.05),
                        // start making the first name field...
                        ReusableTextFormField(
                          prefixIcon: const Icon(
                            Icons.person,
                            color: AppColors.primaryColor,
                          ),
                          keyboardType: TextInputType.name,
                          controller: authCubit.nameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "please enter the name";
                            }
                            return null;
                          },
                          hintText: 'Enter Your name',
                          labelText: 'first name',
                          animationDuration: 200,
                        ),
                        // end of making the first name field ...

                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        // start making the lastName field...
                        ReusableTextFormField(
                          prefixIcon: const Icon(
                            Icons.phone,
                            color: AppColors.primaryColor,
                          ),
                          keyboardType: TextInputType.number,
                          controller: AuthCubit.get(context).phoneController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "please enter the phone Number";
                            }
                            return null;
                          },
                          hintText: 'Enter Your phone Number',
                          labelText: 'phone Number',
                          animationDuration: 300,
                        ),
                        // end of making the lastName field ..
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        // start making the lastName field...
                        ReusableTextFormField(
                          prefixIcon: const Icon(
                            Icons.home,
                            color: AppColors.primaryColor,
                          ),
                          keyboardType: TextInputType.streetAddress,
                          controller: authCubit.addressController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "please enter the address";
                            }
                            return null;
                          },
                          hintText: 'Enter Your Address',
                          labelText: 'address',
                          animationDuration: 400,
                        ),
                        // end of making the lastName field ..
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        //start making the email field...
                        ReusableTextFormField(
                          prefixIcon: const Icon(
                            Icons.email,
                            color: AppColors.primaryColor,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          controller: authCubit.emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "please enter the email";
                            }
                            return null;
                          },
                          hintText: 'Enter Your E-mail',
                          labelText: 'E-mail',
                          animationDuration: 500,
                        ),
                        // end of making the email field ...
                        SizedBox(
                          height: size.height * 0.02,
                        ),

                        // start making the password field...
                        FadeInUp(
                          delay: const Duration(milliseconds: 600),
                          child: TextFormField(
                            controller: authCubit.passwordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "please enter the password";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.next,
                            obscureText: authCubit.hidden,
                            decoration: InputDecoration(
                              fillColor: AppColors.white,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: AppColors.primaryColor, width: 3),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.lightGreen, width: 2),
                                  borderRadius: BorderRadius.circular(30)),
                              prefixIcon: const Icon(
                                Icons.password,
                                color: AppColors.primaryColor,
                              ),
                              suffixIcon: IconButton(
                                color: AppColors.primaryColor,
                                onPressed: () {
                                  authCubit.togglePassword();
                                  // setState(() {
                                  //   hidden = !hidden;
                                  // });
                                },
                                icon: authCubit.hidden ? hiddenicon : unhiddenicon,
                              ),
                              hintText: 'Enter Your Password',
                              hintStyle: theme.titleMedium?.copyWith(color: AppColors.gray),
                              labelText: 'password',
                              labelStyle: theme.titleMedium?.copyWith(color: AppColors.gray),
                            ),
                          ),
                        ),
                        // end of making the password field ..
                        SizedBox(
                          height: size.height * 0.05,
                        ),

                        Visibility(
                          visible: state is RegisterLoadingState,
                          replacement: FadeInUp(
                            delay: const Duration(milliseconds: 700),
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: ReUsableAuthButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    authCubit.registerFireBase();
                                  }
                                  // AppFunctions.navigateTo(context, const LogInScreen());
                                },
                                text: "Sign up",
                              ),
                            ),
                            // the child of replacement is the shape will be visible instead of the button,
                          ),
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

var unhiddenicon = const Icon(Icons.visibility);
var hiddenicon = const Icon(Icons.visibility_off);
