import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../color_manager.dart';
import '../../components/CustomCategory.dart';
import '../../model/NewsModel.dart';
import '../../network/remote/ApiManger.dart';

class CategoryNews extends StatelessWidget {
  String category;

  CategoryNews({required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: Text(
          category,
          style: GoogleFonts.sevillana(
            fontWeight: FontWeight.bold,
            fontSize: 50,
            color: ColorManager.primaryColor,
          ),
        ),
        backgroundColor: ColorManager.colorOffwhite,
        centerTitle: true,
      ),
      body: Container(
        color: ColorManager.colorOffwhite,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: FutureBuilder(
                future: ApiManger.getNewsCategories(category: category), // Asynchronous API call
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('Error loading news'));
                  } else if (snapshot.hasData) {
                    var newsModel =
                    snapshot.data as NewsModel; // Cast to NewsModel
                    var articlesList =
                        newsModel.articles; // Access the articles

                    if (articlesList != null && articlesList.isNotEmpty) {
                      return Column(
                        children: [
                          for (var article in articlesList)
                            if (article.urlToImage != null)
                              CustomCategory(
                                urlImage: article.urlToImage ?? '',
                                title: article.title ?? 'No title',
                                onPressedShare: () {},
                                onPressedFav: () {},
                                iconFav: Icons.favorite_border,
                              ),
                        ],
                      );
                    } else {
                      return const Center(child: Text('No news available'));
                    }
                  } else {
                    return const Center(child: Text('No news available'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
