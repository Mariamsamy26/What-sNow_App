import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/network/remote/ApiManger.dart';

import '../../color_manager.dart';
import '../../components/CustomCategory.dart';
import '../../components/CustomDivider.dart';
import '../../model/NewsModel.dart';
import '../../model/categoryModel.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = 'Home Screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "what's now",
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
          color: ColorManager.colorOffwhite, // Set background color
          child: ListView(
            children: [
              CustomDivider(labelText: 'CATEGORIES'),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (int i = 0; i < Categorylist.length; i++)
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: MaterialButton(
                          padding: EdgeInsets.zero, // Remove default padding
                          child: SizedBox(
                            width: 170,
                            height: 90,
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: Image.asset(
                                    Categorylist[i].imgPath,
                                    fit: BoxFit
                                        .cover, // Ensure the image covers the container
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    Categorylist[i].label,
                                    style: const TextStyle(
                                      color: ColorManager.colorOffwhite,
                                      fontSize: 30,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          onPressed: () {
                            ApiManger.getNewsCategories(
                                category: Categorylist[i].label);
                          },
                        ),
                      )
                  ],
                ),
              ),
              const SizedBox(height: 5),
              CustomDivider(labelText: 'Top news'),

              Padding(padding: const EdgeInsets.all(15),
                child: FutureBuilder(
                  future: ApiManger.getNewsRandom(), // Asynchronous API call
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Center(child: Text('Error loading news'));
                    } else if (snapshot.hasData) {
                      var newsModel = snapshot.data as NewsModel; // Cast to NewsModel
                      var articlesList = newsModel.articles; // Access the articles

                      if (articlesList != null && articlesList.isNotEmpty ) {
                        return Column(
                          children: [
                              for (var article in articlesList)
                                if (article.urlToImage != null )
                              CustomCategory(
                                urlImage: article.urlToImage ?? '', // Use the actual URL for the image
                                title: article.title ?? 'No title', // Use the title or default text
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
        ));
  }

  List<CategoryModel> Categorylist = [
    CategoryModel(
        imgPath: 'assets/images/technology.webp', label: 'technology'),
    CategoryModel(imgPath: 'assets/images/sports.jpeg', label: 'sports'),
    CategoryModel(imgPath: 'assets/images/health.jpeg', label: 'health'),
    CategoryModel(imgPath: 'assets/images/business.jpg', label: 'business'),
  ];
}
