import 'package:flutter/material.dart';

import '../../color_manager.dart';

class SettingScreen extends StatelessWidget {
  static const String routeName = 'setting Screen';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(child: Text("SETTING" ,style: TextStyle(fontSize: 50 ,color: Colors.cyan),)),
      color: ColorManager.colorblueblack,
    );
  }
}
