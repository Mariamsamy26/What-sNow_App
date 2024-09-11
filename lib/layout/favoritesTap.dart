import 'package:flutter/material.dart';

import '../color_manager.dart';

class FavororitesTab extends StatelessWidget {
  static const String routeName = 'Favororites Screen';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(child: Text("FAV" ,style: TextStyle(fontSize: 50 ,color: Colors.cyan),)),
      color: ColorManager.colorOffwhite,
    );
  }
}
