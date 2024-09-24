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

  const CategoryNews({super.key, required this.category});

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
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Error loading news')),
            );
          }
        },
        builder: (context, state) {
          final newsLogic = BlocProvider.of<NewsLogic>(context);
          final dLogic = BlocProvider.of<DLogic>(context);

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
                                iconSec: dLogic.isFavorite(article.title.toString())
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                urlImage: article.urlToImage ?? '',
                                title: article.title ?? 'No title',
                                linkN: article.url != null ? Uri.parse(article.url!) : Uri(),
                                onTap: () {
                                  dLogic.insertHistoryElement(
                                    title: article.title.toString(),
                                    url: article.url.toString(),
                                    imageUrl: article.urlToImage.toString(),
                                  );
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => NewsDetails(
                                        url: article.url ?? '',
                                      ),
                                    ),
                                  );
                                },
                                onPressedSec: () async {
                                  await dLogic.favNews(
                                    article.title.toString(),
                                    article.url.toString(),
                                    article.urlToImage.toString(),
                                  );
                                  // This forces the UI to rebuild and reflect the new favorite status
                                  newsLogic.getNewsCategories(category: category);
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
