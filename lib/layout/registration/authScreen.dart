import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../home.dart';
import 'login_or_register_screen.dart';

class authpage extends StatelessWidget{
  authpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            return home();
          }
          else{
            return LoginOrRegisterPage();
          }
        },
      ),
    );
  }
}