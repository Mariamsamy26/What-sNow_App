import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../bloc/newstate/countLogic.dart';
import '../../bloc/newstate/countSetup.dart';
import '../../color_manager.dart';
import '../../components/CustomNews.dart';
import '../../model/NewsModel.dart';
import 'NewsDetails.dart';

class CategoryNews extends StatelessWidget {
  String category;

  CategoryNews({required this.category});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsLogic()..getNewsCategories(category: category),
      child: BlocConsumer<NewsLogic, NewsState>(
          listener: (context, state) {},
          builder: (context, state) {
            NewsLogic obj = BlocProvider.of(context);

            return Scaffold(
              appBar: AppBar(
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
                      child: BlocBuilder<NewsLogic, NewsState>(
                        builder: (context, state) {
                          if (state is InitNews) {
                            return const Center(child: CircularProgressIndicator());
                          } else if (state is Category_news) {
                            var newsModel = state.newsResponse;
                            var articlesList = newsModel?.articles;

                            if (articlesList != null && articlesList.isNotEmpty) {
                              return Column(
                                children: [
                                  for (var article in articlesList)
                                    if (article.urlToImage != null)
                                      CustomNews(
                                        urlImage: article.urlToImage ?? '',
                                        title: article.title ?? 'No title',
                                        onPressedShare: () {
                                          // Implement share functionality
                                        },
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
              ),
            );
          }),
    );
  }
}
