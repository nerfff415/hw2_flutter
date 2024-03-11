class Article {
  final String title;
  final String description;
  final String urlToImage;
  final String url;
  final String content;
  bool isFavorite; // Добавлено новое поле

  Article({
    required this.title,
    required this.description,
    required this.urlToImage,
    required this.url,
    required this.content,
    this.isFavorite = false, // Инициализация по умолчанию
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      urlToImage: json['urlToImage'] ?? '',
      url: json['url'] ?? '',
      content: json['content'] ?? '',
      isFavorite: json['isFavorite'] ?? false, // Инициализация из JSON
    );
  }
}
