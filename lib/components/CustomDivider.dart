import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../color_manager.dart';

class CustomDivider extends StatelessWidget {
  final String labelText;
  final Color? colorr;

  CustomDivider({
    required this.labelText,
    this.colorr,
  });

  @override
  Widget build(BuildContext context) {
    // Access the theme color in the build method
    final Color dividerColor = colorr ?? Theme.of(context).colorScheme.secondary;

    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              thickness: 5,
              color: dividerColor,
              height: 50,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              labelText,
              style: GoogleFonts.abhayaLibre(
                fontWeight: FontWeight.bold,
                fontSize: 50,
                color: dividerColor,
              ),
            ),
          ),
          Expanded(
            child: Divider(
              thickness: 5,
              color: dividerColor,
              height: 50,
            ),
          ),
        ],
      ),
    );
  }
}
