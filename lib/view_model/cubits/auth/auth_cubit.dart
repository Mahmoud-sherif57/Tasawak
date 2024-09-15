import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasawak/model/auth/user_data.dart';
import 'package:tasawak/view_model/cubits/auth/auth_state.dart';
import 'package:tasawak/view_model/helpers/firebase/firebase_keys.dart';


class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(InitialAuthState());

  static AuthCubit get(context) => BlocProvider.of<AuthCubit>(context);

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  bool hidden = true;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth fireAuth = FirebaseAuth.instance;
  // making a controllers to catch what the user write in the textFormField .,

  /// -------------------registerFireBase------------------->
  Future<void> registerFireBase() async {
    emit(RegisterLoadingState());
    await fireAuth
        .createUserWithEmailAndPassword(
            email: emailController.text.trim(), password: passwordController.text.trim())
        .then((value) async {
      await fireAuth.currentUser?.updateDisplayName(nameController.text);
      await saveUserToFirestore();
      emit(RegisterSuccessfulState());
      clearControllers();
    }).catchError((error) {
      emit(RegisterErrorState('something went wrong in register${error.toString()}'));
    });
  }

  /// -------------------signOutFirebase----------------------->
  Future<void> signOutFirebase() async {
    emit(SigningOutLoadingState());
    await fireAuth.signOut().then((value) {
      emit(SigningOutSuccessfulState());
      // AppFunctions.navigateTo(context, LogInScreen());
    }).catchError((error) {
      SigningOutErrorState('something went wrong in sign out${error.toString()}');
    });
  }

  /// ---------------------loginFireBase----------------------->

  Future<void> loginFireBase() async {
    emit(LoggingLoadingState());
    await fireAuth
        .signInWithEmailAndPassword(email: emailController.text, password: passwordController.text)
        .then((value) {
      emit(LoggingSuccessfulState());
      clearControllers();
    }).catchError((error) {
      debugPrint(' there is an error in login firebase ${error.toString()}');
      emit(LoggingErrorState('something went wrong in logging${error.toString()}'));
    });
  }

  /// -------------------reset password----------------------->

  Future<void> resetPassword() async {
    emit(ResetPasswordLoadingState());
    await fireAuth.sendPasswordResetEmail(email: emailController.text).then((value) {
      emit(ResetPasswordSuccessfulState());
      // showSnackBar(context,
      //     "We have send you the reset password link to your email id, Please check it");
    }).catchError((error) {
      emit(ResetPasswordErrorState('something went wrong in reset password${error.toString()}'));
    });
  }

  /// -----------------saveUserToFireStore-------------------->

  // This function to save the user data in the firebase store..
  Future<void> saveUserToFirestore() async {
    UserDataModel userData = UserDataModel(
      uid: fireAuth.currentUser?.uid,
      email: fireAuth.currentUser?.email,
      name: fireAuth.currentUser?.displayName,
      phoneNumber: phoneController.text,
    );
    await firestore.collection(FirebaseKeys.users).doc(fireAuth.currentUser?.email).set(
          userData.toJson(),
        );
  }

  /// --------------------clearControllers-------------------->

  void clearControllers() {
    nameController.clear();
    phoneController.clear();
    emailController.clear();
    passwordController.clear();
  }

  /// ----------------------update user information--------------------->
  Future<void> updateUserInfo() async {
    await fireAuth.currentUser?.updatePassword(passwordController.text);
    await fireAuth.currentUser?.updatePhoneNumber(phoneController as PhoneAuthCredential);
    await fireAuth.currentUser?.updatePhotoURL('get the new photo url from image picker');
    await fireAuth.currentUser?.updateDisplayName(nameController.text);
  }

  /// ----------------------delete user--------------------->
  Future<void> deleteUser() async {
    await fireAuth.currentUser?.delete();
  }

  /// ----------------------togglePassword--------------------->
  void togglePassword() {
    hidden = !hidden;
    emit(TogglePasswordState());
  }
// end of (togglePassword Function) .
//
//   Future<void> signUpFirebase(UserDataModel user) async {
//     try {
//       final userData = await FirebaseAuth.instance.createUserWithEmailAndPassword(
//           email: emailController.text.trim(), password: passwordController.text.trim());
//
//       print(userData.user?.email);
//       print(userData.user?.uid);
//   await saveUserToFirestore();
//
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'weak-password') {
//
//         print('The password provided is too weak.');
//       } else if (e.code == 'email-already-in-use') {
//         print('The account already exists for that email.');
//       }
//     } catch (e) {
//       print(e);
//     }
//   }
}
