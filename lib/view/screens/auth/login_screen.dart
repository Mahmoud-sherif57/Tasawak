import 'package:animate_do/animate_do.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasawak/view/screens/auth/signup_screen.dart';
import 'package:tasawak/view_model/cubits/auth/auth_cubit.dart';
import 'package:tasawak/view_model/cubits/auth/auth_state.dart';
import 'package:tasawak/view_model/utils/app_colors.dart';
import 'package:tasawak/view_model/utils/app_functions.dart';
import 'package:tasawak/view_model/utils/reusable_widgets/reusabel_auth_button.dart';
import 'package:tasawak/view_model/utils/reusable_widgets/reusable_text_form_field.dart';
import '../wrapper_home_screen/wrapper_screen2.dart';
import 'forgot_password_screen.dart';

class LogInScreen extends StatelessWidget {
  LogInScreen({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.offwhite,
        body: Container(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is LoggingSuccessfulState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.green,
                      duration: Duration(seconds: 1),
                      content: Text(" Successfully Logged in"),
                    ),
                  );

                  AppFunctions.navigateTo(context, const WrapperHomeScreen2());
                } else if (state is LoggingErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red,
                      content: Text("Failed to Log in${state.message}"),
                    ),
                  );
                }
              },
              builder: (context, state) {
                return SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FadeInUp(
                          delay: const Duration(milliseconds: 100),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text('Log in',
                                style: theme.headlineLarge
                                    ?.copyWith(fontWeight: FontWeight.bold, color: AppColors.primaryColor)),
                          ),
                        ),
                        SizedBox(height: size.height * 0.05),
                        // start making the email field...
                        ReusableTextFormField(
                          hintText: 'Enter Your E-mail',
                          labelText: 'E-mail',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "please enter your email";
                            }
                            return null;
                          },
                          controller: AuthCubit.get(context).emailController,
                          keyboardType: TextInputType.emailAddress,
                          prefixIcon: const Icon(
                            Icons.email,
                            color: AppColors.primaryColor,
                          ),
                          animationDuration: 200,
                        ),
                        // end of making the email field...
                        SizedBox(
                          height: size.height * 0.03,
                        ),

                        //making the password field...
                        FadeInUp(
                          delay: const Duration(milliseconds: 300),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "please enter your password";
                              }
                              return null;
                            },
                            controller: AuthCubit.get(context).passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.next,
                            obscureText: AuthCubit.get(context).hidden,
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
                                  AuthCubit.get(context).togglePassword();
                                  // setState(() {
                                  //   hidden = !hidden;
                                  // });
                                },
                                icon: AuthCubit.get(context).hidden ? hiddenicon : unhiddenicon,
                              ),
                              hintText: 'Enter Your Password',
                              hintStyle: theme.titleMedium?.copyWith(color: AppColors.gray),
                              labelText: 'password',
                              labelStyle: theme.titleMedium?.copyWith(color: AppColors.gray),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),

                        FadeInUp(
                          delay: const Duration(milliseconds: 400),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  const TextSpan(
                                    text: 'Forgot Password ?',
                                    style: TextStyle(color: AppColors.darkGray),
                                  ),
                                  WidgetSpan(
                                    child: SizedBox(
                                      width: size.width * 0.05,
                                    ),
                                  ),
                                  TextSpan(
                                      text: 'Reset',
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          AppFunctions.navigateTo(context, ForgotPasswordScreen());
                                        },
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold, color: AppColors.primaryColor)),
                                ],
                              ),
                            ),
                          ),
                        ),

                        // FadeInUp(
                        //   delay: const Duration(milliseconds: 400),
                        //   child: Text(
                        //     "Did you forgot your password ?",
                        //     style: theme.bodyMedium
                        //         ?.copyWith(color: AppColors.darkGray),
                        //   ),
                        // ),

                        SizedBox(
                          height: size.height * 0.1,
                        ),

                        Visibility(
                          visible: state is LoggingLoadingState,
                          replacement: FadeInUp(
                            delay: const Duration(milliseconds: 500),
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: ReUsableAuthButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    AuthCubit.get(context).loginFireBase();
                                  }
                                },
                                text: "Log In",
                              ),
                            ),
                          ),
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FadeInUp(
                          delay: const Duration(milliseconds: 600),
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  const TextSpan(
                                    text: 'Don\'t have an account ?',
                                    style: TextStyle(color: AppColors.darkGray),
                                  ),
                                  WidgetSpan(
                                    child: SizedBox(
                                      width: size.width * 0.05,
                                    ),
                                  ),
                                  TextSpan(
                                      text: 'Create one',
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          AppFunctions.navigateTo(context, SignupScreen());
                                        },
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold, color: AppColors.primaryColor)),
                                ],
                              ),
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
