import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/color_manager.dart';

class CustomCategory extends StatelessWidget {
  final String urlImage;
  final String title;
  final VoidCallback onPressedShare;
  final VoidCallback onPressedFav;
  final IconData iconFav;

  CustomCategory({
    required this.urlImage,
    required this.title,
    required this.onPressedShare,
    required this.onPressedFav,
    required this.iconFav,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorManager.colorGray,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              alignment: AlignmentDirectional.centerEnd,
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.network(
                    urlImage,
                    fit: BoxFit.cover, // Ensure the image covers the container
                    width: double.infinity, // Image takes the full width
                  ),
                ),
                // Share and Favorite icons
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: onPressedShare,
                        icon: const Icon(
                          Icons.share,
                          color: ColorManager.colorOffwhite,
                          size: 40,
                        ),
                      ),
                      IconButton(
                        onPressed: onPressedFav,
                        icon: Icon(
                          iconFav,
                          color: ColorManager.colorOffwhite,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: GoogleFonts.abyssinicaSil(
                fontSize: 20,
                color: ColorManager.colorGrayblack,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
