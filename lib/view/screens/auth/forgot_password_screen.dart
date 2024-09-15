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

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.offwhite,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_sharp),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    return Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FadeInUp(
                            delay: const Duration(milliseconds: 100),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Reset password',
                                style: theme.headlineLarge
                                    ?.copyWith(fontWeight: FontWeight.bold, color: AppColors.primaryColor),
                              ),
                            ),
                          ),
                          const SizedBox(height: 25),

                          //making the email field...
                          FadeInUp(
                            delay: const Duration(milliseconds: 200),
                            child: ReusableTextFormField(
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
                          ),
                          SizedBox(
                            height: size.height * 0.1,
                          ),
                          FadeInUp(
                            delay: const Duration(milliseconds: 300),
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: ReUsableAuthButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    AuthCubit.get(context).resetPassword();
                                    // AppFunctions.navigateTo(context, LogInScreen());
                                  }
                                },
                                text: "Confirm",
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
//
// var unhiddenicon = const Icon(Icons.visibility);
// var hiddenicon = const Icon(Icons.visibility_off);
