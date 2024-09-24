import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/dstate/d_logic.dart';
import '../../bloc/newstate/NewsLogic.dart';
import '../../bloc/newstate/NewsState.dart';
import '../../color_manager.dart';
import '../../components/CustomNews.dart';
import 'NewsDetails.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  Timer? debounce;

  @override
  void initState() {
    super.initState();
    searchController.addListener(onSearchTextChanged);
  }

  @override
  void dispose() {
    searchController.dispose();
    debounce?.cancel();
    super.dispose();
  }

  void onSearchTextChanged() {
    final query = searchController.text.trim();

    if (debounce?.isActive ?? false) debounce?.cancel();

    debounce = Timer(const Duration(milliseconds: 500), () {
      if (query.isNotEmpty) {
        context.read<NewsLogic>().getNewsSearch(text: query);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    DLogic DObject = BlocProvider.of<DLogic>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 10),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {
                    searchController.clear();
                    context.read<NewsLogic>().getNewsSearch(text: '');
                  },
                  icon: Icon(Icons.highlight_remove_outlined),
                ),
                fillColor: ColorManager.primaryColor,
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: ColorManager.primaryColor,
                    width: 5,
                  ),
                  borderRadius: BorderRadius.circular(6),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: ColorManager.primaryColor,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: const EdgeInsets.all(12),
                hintText: 'Search news ..',
              ),
            ),
          ),
        ),
        body: Container(
          color: Theme.of(context).colorScheme.primary,
          child: BlocConsumer<NewsLogic, NewsState>(
            listener: (context, state) {
              if (state is SearchError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message ?? 'Error loading news')),
                );
              }
            },
            builder: (context, state) {
              if (state is SearchLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is Search_news) {
                var newsModel = state.newsResponse;
                var articlesList = newsModel?.articles;

                if (articlesList != null && articlesList.isNotEmpty) {
                  return ListView.builder(
                    itemCount: articlesList.length,
                    itemBuilder: (context, index) {
                      var article = articlesList[index];
                      if (article.urlToImage != null) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: CustomNews(
                            iconSec: DObject.isFavorite(article.title.toString())
                                ? Icons.favorite
                                : Icons.favorite_border,
                            urlImage: article.urlToImage ?? '',
                            title: article.title ?? 'No title',
                            linkN: article.url != null ? Uri.parse(article.url!) : Uri(),
                            onTap: () {
                              DObject.insertHistoryElement(
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
                              await DObject.favNews(
                                article.title.toString(),
                                article.url.toString(),
                                article.urlToImage.toString(),
                              );
                            },
                          ),
                        );
                      }
                      return SizedBox.shrink();
                    },
                  );
                } else {
                  return const Center(child: Text('No news available'));
                }
              } else {
                return const Center(child: Text('Error loading news..'));
              }
            },
          ),
        ),
      ),
    );
  }
}
