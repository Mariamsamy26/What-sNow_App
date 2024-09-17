import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../bloc/dstate/d_logic.dart';
import '../../bloc/newstate/NewsLogic.dart';
import '../../bloc/newstate/NewsState.dart';
import '../../color_manager.dart';
import '../../components/CustomNews.dart';
import 'NewsDetails.dart';

class CategoryNews extends StatelessWidget {
  final String category;

  CategoryNews({required this.category});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NewsLogic()..getNewsCategories(category: category),
        ),
        BlocProvider(
          create: (context) => DLogic()..createDatabaseAndTable(),
        ),
      ],
      child: BlocConsumer<NewsLogic, NewsState>(
        listener: (context, state) {
          if (state is Get_newsD) {
            // Handle error if needed
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error loading news')),
            );
          }
        },
        builder: (context, state) {
          NewsLogic obj = BlocProvider.of(context);
          DLogic DObject = BlocProvider.of(context);

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
              backgroundColor: Theme.of(context).colorScheme.primary,
              centerTitle: true,
            ),
            body: Container(
              color: Theme.of(context).colorScheme.primary,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: BlocBuilder<NewsLogic, NewsState>(
                  builder: (context, state) {
                    if (state is InitNews) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is Category_news) {
                      var newsModel = state.newsResponse;
                      var articlesList = newsModel?.articles;

                      if (articlesList != null && articlesList.isNotEmpty) {
                        return ListView.builder(
                          itemCount: articlesList.length,
                          itemBuilder: (context, index) {
                            var article = articlesList[index];

                            if (article.urlToImage != null) {
                              return CustomNews(
                                linkN: article.url != null
                                    ? Uri.parse(article.url!)
                                    : Uri(),
                                urlImage: article.urlToImage ?? '',
                                title: article.title ?? 'No title',
                                onPressedFav: () {
                                  // Implement favorite functionality
                                },
                                iconFavFuture: DObject.searchByTitle(
                                  title: article.title ?? '',
                                ),
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => NewsDetails(
                                        url: article.url ?? '',
                                      ),
                                    ),
                                  );
                                },
                              );
                            } else {
                              return const SizedBox.shrink(); // Skip if no image
                            }
                          },
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
            ),
          );
        },
      ),
    );
  }
}
