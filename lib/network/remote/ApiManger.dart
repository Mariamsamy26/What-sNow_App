import 'dart:convert';

import 'package:http/http.dart' as https;
import 'package:newsapp/model/NewsModel.dart';

class ApiManger {
  Uri newuri = Uri.https("newsapi.org", "v2/top-headlines",
      {"apiKey": "ed597789cb1f40bca350919b6a61f1f7"});

  static Future<NewsModel> getNewsCategories({required String category}) async {
    Uri newuri = Uri.https("newsapi.org", "v2/top-headlines",
        {"apiKey": "ed597789cb1f40bca350919b6a61f1f7", "category": category});

    https.Response data=  await https.get(newuri) ;
     var news = jsonDecode(data.body);
    NewsModel NewsResponse=NewsModel.fromJson(news);
    print("done");
    return NewsResponse;
  }
  static Future<NewsModel> getNewsRandom() async {
    Uri newuri = Uri.https("newsapi.org", "v2/everything", {
      "apiKey": "ed597789cb1f40bca350919b6a61f1f7",
      "q": "random",
      "pageSize": "15"
    });
    https.Response data=  await https.get(newuri) ;
     var news = jsonDecode(data.body);
    NewsModel NewsResponse=NewsModel.fromJson(news);
    print(NewsResponse.articles);
    return NewsResponse;
  }

}
