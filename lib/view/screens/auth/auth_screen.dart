
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tasawak/view/screens/auth/login_screen.dart';
import 'package:tasawak/view/screens/wrapper_home_screen/wrapper_screen2.dart';
import 'package:tasawak/view/screens/wrapper_home_screen/wrapper_home_screen.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context,snapshot){
            if(snapshot.hasData){
              return const WrapperHomeScreen2();
            }else{
              return LogInScreen();
            }
          }),
    );
  }
}
