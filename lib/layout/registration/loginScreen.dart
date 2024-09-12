import 'package:flutter/material.dart';

import '../../color_manager.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = 'Login Screen';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: const Center(child: Text("LOGIN" ,style: TextStyle(fontSize: 50 ,color: Colors.cyan),)),
      color: ColorManager.colorGrayblack,
    );
  }
}
