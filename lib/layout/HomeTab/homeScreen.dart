import 'package:flutter/material.dart';

import '../../color_manager.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = 'Home Screen';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: const Center(child: Text("HOME" ,style: TextStyle(fontSize: 50 ,color: Colors.cyan),)),
      color: ColorManager.colorGrayblack,
    );
  }
}
