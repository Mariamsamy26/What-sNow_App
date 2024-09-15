import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class homepage extends StatelessWidget{
  homepage({super.key});
  
  final user = FirebaseAuth.instance.currentUser!;

  void signUserout(){
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        actions: [IconButton(onPressed: signUserout, icon: Icon(Icons.logout))],
      ),
      body: Center(
        child: Text("Logged In As "+ user.email!,
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold
        ),),
      ) ,
    );
  }


}