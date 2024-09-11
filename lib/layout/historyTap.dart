import 'package:flutter/material.dart';
import 'package:newsapp/color_manager.dart';

class HistoryTab extends StatelessWidget {
  static const String routeName = 'History screen';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(child: Text("HISTORY" ,style: TextStyle(fontSize: 50 ,color: Colors.black),)),
      color: ColorManager.primaryColor,
    );
  }
}
