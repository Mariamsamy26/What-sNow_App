import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/bloc/newstate/countLogic.dart';

import '../../bloc/newstate/countSetup.dart';
import '../../color_manager.dart';
import '../../components/CustomNews.dart';
import '../../components/CustomDivider.dart';
import '../../model/categoryModel.dart';
import 'CategoryNews.dart';
import 'NewsDetails.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = 'Home Screen';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsLogic()..getNewsRandom(),
      child: BlocConsumer<NewsLogic, NewsState>(
          listener: (context, state) {},
          builder: (context, state) {
            NewsLogic obj = BlocProvider.of(context);
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
                              Card(
                                child: MaterialButton(
                                  padding: EdgeInsets.zero,
                                  child: SizedBox(
                                    width: 170,
                                    height: 100,
                                    child: Stack(
                                      children: [
                                        Positioned.fill(
                                          child: Image.asset(
                                            Categorylist[i].imgPath,
                                            fit: BoxFit.fill, // Ensure the image covers the container
                                          ),
                                        ),
                                        Center(
                                          child: Text(
                                            Categorylist[i].label,
                                            style: const TextStyle(
                                              color:
                                                  ColorManager.colorOffwhite,
                                              fontSize: 30,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (C) => CategoryNews(
                                                  category:
                                                      Categorylist[i].label,
                                                )));
                                  },
                                ),
                              )
                          ],
                        ),
                      ),

                      CustomDivider(labelText: 'Top news'),

                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: BlocBuilder<NewsLogic, NewsState>(
                          builder: (context, state) {
                            if (state is InitNews) {
                              return const Center(child: CircularProgressIndicator());
                            } else if (state is Random_news) {
                              var newsModel = state.newsResponse;
                              var articlesList = newsModel?.articles;

                              if (articlesList != null && articlesList.isNotEmpty) {
                                return Column(
                                  children: [
                                    for (var article in articlesList)
                                      if (article.urlToImage != null)
                                        CustomNews(
                                          linkN:article.url != null ? Uri.parse(article.url!) : Uri(),
                                          urlImage: article.urlToImage ?? '',
                                          title: article.title ?? 'No title',
                                          onPressedFav: () {
                                            // Implement favorite functionality
                                          },
                                          iconFav: Icons.favorite_border,
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) => NewsDetails(
                                                  url: article.url ?? '',
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                  ],
                                );
                              } else {
                                return const Center(child: Text('No news available'));
                              }
                            } else if (state is Get_newsD) {
                              return const Center(child: Text('Error loading news'));
                            } else {
                              return const Center(child: Text('No news available'));
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ));
          }),
    );
  }

  List<CategoryModel> Categorylist = [
    CategoryModel(imgPath: 'assets/images/Business.webp', label: 'Business'),
    CategoryModel(imgPath: 'assets/images/politics.webp', label: 'politics'),
    CategoryModel(imgPath: 'assets/images/Technology.jpeg', label: 'Technology'),
    CategoryModel(imgPath: 'assets/images/Science.jpeg', label: 'Science'),
    CategoryModel(imgPath: 'assets/images/sports.jpeg', label: 'sports'),
    CategoryModel(imgPath: 'assets/images/Health.jpeg', label: 'Health'),
  ];
}
