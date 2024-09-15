import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;

import '../../model/NewsModel.dart';
import 'NewsState.dart';

class NewsLogic extends Cubit<NewsState> {
  NewsLogic() : super(InitNews());

  Future<void> getNewsCategories({required String category}) async {
    try {
      Uri newUri = Uri.https("newsapi.org", "v2/top-headlines", {
        "apiKey": "ed597789cb1f40bca350919b6a61f1f7",
        "category": category,
      });

      final response = await http.get(newUri);

      if (response.statusCode == 200) {
        var news = jsonDecode(response.body);
        NewsModel newsResponse = NewsModel.fromJson(news);
        emit(Category_news(newsResponse: newsResponse));
      } else {
        emit(NewsErrorState("Failed to load news"));
      }
    } catch (e) {
      emit(NewsErrorState(e.toString()));
    }
  }

  Future<void> getNewsSearch({required String text}) async {
    try {
      Uri newUri = Uri.https("newsapi.org", "v2/top-headlines", {
        "apiKey": "ed597789cb1f40bca350919b6a61f1f7",
        "q": text,
      });

      final response = await http.get(newUri);

      if (response.statusCode == 200) {
        var news = jsonDecode(response.body);
        NewsModel newsResponse = NewsModel.fromJson(news);
        emit(Search_news(newsResponse: newsResponse, searchtext: ''));
      } else {
        emit(NewsErrorState("Failed to load news"));
      }
    } catch (e) {
      emit(NewsErrorState(e.toString()));
    }
  }

  Future<void> getNewsRandom() async {
    try {
      Uri newUri = Uri.https("newsapi.org", "v2/everything", {
        "apiKey": "ed597789cb1f40bca350919b6a61f1f7",
        "q": "random",
        "pageSize": "15",
      });
      final response = await http.get(newUri);

      if (response.statusCode == 200) {
        var news = jsonDecode(response.body);
        NewsModel newsResponse = NewsModel.fromJson(news);
        print(newsResponse.articles);
        emit(Random_news(newsResponse: newsResponse));
      } else {
        emit(NewsErrorState("Failed to load news"));
      }
    } catch (e) {
      emit(NewsErrorState(e.toString()));
    }
  }

}
