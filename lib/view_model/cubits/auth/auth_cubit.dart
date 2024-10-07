import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasawak/model/auth/user_data.dart';
import 'package:tasawak/view_model/cubits/auth/auth_state.dart';
import 'package:tasawak/view_model/data/local/hive.dart';
import 'package:tasawak/view_model/helpers/firebase/firebase_keys.dart';
import '../../../view/screens/auth/login_screen.dart';
import '../../utils/app_functions.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(InitialAuthState());

  static AuthCubit get(context) => BlocProvider.of<AuthCubit>(context);

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  bool hidden = true;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth fireAuth = FirebaseAuth.instance;
  // making a controllers to catch what the user write in the textFormField .,

  List userDataList = []; // with the single document

  /// -------------------registerFireBase------------------->
  Future<void> registerFireBase() async {
    emit(RegisterLoadingState());
    await fireAuth
        .createUserWithEmailAndPassword(
            email: emailController.text.trim(), password: passwordController.text.trim())
        .then((value) async {
      await fireAuth.currentUser?.updateDisplayName(nameController.text);
      await saveUserToFirestore();
      // await saveUserInfoInHive();
      emit(RegisterSuccessfulState());
      clearControllers();
    }).catchError((error) {
      emit(RegisterErrorState('something went wrong in register${error.toString()}'));
    });
  }

  /// -------------------signOutFirebase----------------------->
  Future<void> signOutFirebase(BuildContext context) async {
    emit(SigningOutLoadingState());
    await fireAuth.signOut().then((value) {
      emit(SigningOutSuccessfulState());
      AppFunctions.navigateTo(context, LogInScreen());
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
      address: addressController.text,
      myImage: AuthCubit().myImage?.path,
    );
    await firestore.collection(FirebaseKeys.users).doc(fireAuth.currentUser?.email).set(
          userData.toJson(),
        );
  }

  /// ----------------get user data from firestore-------------->

  // void getUserDataFromFirestore() async{
  //   QuerySnapshot querySnapshot = await firestore.collection("users").doc(emailController.text).get();
  //   userDataList.addAll(querySnapshot.docs);
  //   // print(userDataList[5]);
  //   // print(userDataList.length);
  // }

  void getUserDataFromFirestore() async {
    // this function is used in splash screen & tasawak.dart
    DocumentSnapshot documentSnapshot = await firestore
        .collection("users")
        .doc(
      fireAuth.currentUser?.email,
    ) // we increased .doc(the user email) to get single
        .get();

    if (documentSnapshot.exists) {
      userDataList.add(documentSnapshot.data());
      // print(userDataList.length);
    } else {
      // print("No user data found for this email.");
    }
  }


  /// ----------------------update user information--------------------->

  Future<void> updateUserInfo() async {
    await fireAuth.currentUser?.updatePassword(passwordController.text);
    await fireAuth.currentUser?.updatePhoneNumber(phoneController as PhoneAuthCredential);
    await fireAuth.currentUser?.updatePhotoURL(AuthCubit().myImage?.path);
    await fireAuth.currentUser?.updateDisplayName(nameController.text);
  }

  /// ----------------------delete user from firestore --------------------->

  Future<void> deleteUser() async {
    await fireAuth.currentUser?.delete();
  }

  /// --------------------clearControllers-------------------->

  void clearControllers() {
    nameController.clear();
    phoneController.clear();
    emailController.clear();
    passwordController.clear();
    addressController.clear();
  }


  /// ----------------------togglePassword--------------------->

  void togglePassword() {
    hidden = !hidden;
    emit(TogglePasswordState());
  }

  ///--------------imagePicker--------->
  XFile? myImage;
  late final Uint8List imageBytes;
  final ImagePicker picker = ImagePicker();
  Future<XFile?> pickImageFromGallery() async {
    myImage = await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (myImage != null) {
      emit(PickImageState());
      //convert the image to bytes to save it in hive ,
      return myImage;
    }
    imageBytes = (await myImage!.readAsBytes());
    return null;
  }



  ///-------------------saveUserInHive------------->
  Future<void> saveUserInfoInHive()async{
    myBox?.put("uid", fireAuth.currentUser?.uid);
    myBox?.put("email", fireAuth.currentUser?.email);
    myBox?.put("name", fireAuth.currentUser?.displayName);
    myBox?.put("phoneNumber", phoneController.text);
    myBox?.put("address", addressController.text);
    myBox?.put("myImage",imageBytes );
    // myBox?.put("myImage", AuthCubit().myImage?.path);
  }

  ///------------getUserInfoFromHive-------------->
Future<void> getUserInfoFromHive()async{
    myBox?.get("uid");
    myBox?.get("email");
    myBox?.get("name");
    myBox?.get("phoneNumber");
    myBox?.get("address");
    // myBox?.get("myImage");
    // getUserImage();
  }
  ///---------------getUserImageFromHive----->
  Future<Widget> getUserImage() async {
     imageBytes = myBox?.get('myImage');
    return Image.memory(imageBytes);
    }
///--------deleteUserInfoFromHive------------>
Future<void> deleteUserInfoFromHive()async{
    myBox?.deleteAll(["uid","email","name","phoneNumber","address","myImage"]); // to delete the list of mentioned keys ,
    // myBox?.clear();  // to delete the whole keys in the named box ,
}


}
