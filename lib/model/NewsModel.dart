class NewsModel {
  NewsModel({
      this.status, 
      this.totalResults, 
      this.articles,});

  NewsModel.fromJson(dynamic json) {
    status = json['status'];
    totalResults = json['totalResults'];
    if (json['articles'] != null) {
      articles = [];
      json['articles'].forEach((v) {
        articles?.add(Articles.fromJson(v));
      });
    }
  }
  String? status;
  int? totalResults;
  List<Articles>? articles;


}

class Articles {
  Articles({
      this.source, 
      this.author, 
      this.title, 
      this.description, 
      this.url, 
      this.urlToImage, 
      this.publishedAt, 
      this.content,});

  Articles.fromJson(dynamic json) {
    source = json['source'] != null ? Source.fromJson(json['source']) : null;
    author = json['author'];
    title = json['title'];
    description = json['description'];
    url = json['url'];
    urlToImage = json['urlToImage'];
    publishedAt = json['publishedAt'];
    content = json['content'];
  }
  Source? source;
  dynamic author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? publishedAt;
  String? content;


}

class Source {
  Source({
      this.id,
      this.name,});

  Source.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }
  dynamic id;
  String? name;


}