class NewsModel {
  String? name;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  DateTime publishedAt;
  String? content;

  NewsModel(
      {required this.name,
        required this.author,
        required this.title,
        required this.description,
        required this.url,
        required this.urlToImage,
        required this.publishedAt,
        required this.content});

  factory NewsModel.fromJson(Map<String,dynamic> json){
    return NewsModel(
        name: json['source']['name'] ?? "",
        author: json['author'] ?? "",
        title: json['title'] ?? "",
        description: json['description'] ?? "",
        url: json['url'] ?? "",
        urlToImage: json['urlToImage'],
        publishedAt: DateTime.parse(json['publishedAt']),
        content: json['content'] ?? ""
    );
  }
}