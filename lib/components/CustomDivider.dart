import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../color_manager.dart';

class CustomDivider extends StatelessWidget {
  late final String labelText;
  final Color colorr;

  CustomDivider({
    required this.labelText,
    this.colorr = ColorManager.colorblueblack,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              thickness: 5,
              color: colorr,
              height: 50,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              labelText,
              style: GoogleFonts.abhayaLibre(
                fontWeight: FontWeight.bold,
                fontSize: 50,
                color: colorr,
              ),
            ),
          ),
          Expanded(
            child: Divider(
              thickness: 5,
              color: colorr,
              height: 50,
            ),
          ),
        ],
      ),
    );
  }
}
