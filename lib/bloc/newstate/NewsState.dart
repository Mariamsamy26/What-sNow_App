import '../../model/NewsModel.dart';

abstract class NewsState{}

class InitNews extends NewsState{}
class Category_news extends NewsState{
  final NewsModel? newsResponse;
  Category_news({required this.newsResponse});
}
class Search_news extends NewsState{
  String searchtext;
  final NewsModel? newsResponse;
  Search_news({required this.newsResponse , required this.searchtext});
}
class NewsErrorState extends NewsState{
  NewsErrorState(String error);
}
class Random_news extends NewsState{
  NewsModel newsResponse;
  Random_news({required this.newsResponse});
}
class Get_newsD extends NewsState{}
class FavState extends NewsState{}