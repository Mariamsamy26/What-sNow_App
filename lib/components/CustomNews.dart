import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/color_manager.dart';
import 'ShareSheetTap.dart';


class CustomNews extends ShareSheetTap {
  final String urlImage;
  final String title;
  final VoidCallback onPressedFav;
  final VoidCallback onTap;
  final bool is_history;
  Future<bool> iconFavFuture;

  CustomNews( {
    required this.urlImage,
    required this.title,
    required this.onPressedFav,
    required this.onTap,
    required super.linkN,
    this.is_history=false,
    required this.iconFavFuture,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        color: ColorManager.colorGray,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                alignment: AlignmentDirectional.centerEnd,
                children: [
                  CachedNetworkImage(
                    imageUrl: urlImage,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const SizedBox(
                      height: 50,
                      width: 50,
                      child: CircularProgressIndicator(
                        strokeWidth: 1.0,
                        color: ColorManager.primaryColor,
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),

                  // Share and Favorite icons
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        ShareSheetTap(linkN: linkN,),

                        IconButton(
                          onPressed: onPressedFav,
                          icon: FutureBuilder(
                            future: iconFavFuture,
                            builder: (context, snapshot) {
                              if(is_history){
                                return const Icon(
                                    Icons.delete,
                                    color: ColorManager.colorOffwhite,
                                    size: 40
                                );
                              }
                              else{
                                if (snapshot.hasData) {
                                  return Icon(
                                    snapshot.data ?? false ? Icons.favorite : Icons.favorite_border,
                                    color: ColorManager.colorOffwhite,
                                    size: 40,
                                  );
                                } else {
                                  return Icon(
                                    snapshot.data ?? false ? Icons.favorite_border : Icons.favorite_border,
                                    color: ColorManager.colorOffwhite,
                                    size: 40,
                                  ); // Default icon
                                }
                              }
                            },
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
      ),
    );
  }
}
