// ignore_for_file: non_constant_identifier_names

class Article {
  Article({
    this.id,
    this.text,
    this.full_text,
    this.title,
    this.image_url,
    this.author_name,
    this.url,
    this.premium,
    this.order,
    this.image,
    this.author_image,
    this.author_description,
  });

  int? id;
  String? text;
  String? full_text;
  String? title;
  String? image_url;
  String? author_name;
  String? url;
  int? premium;
  int? order;
  String? image;
  String? author_image;
  String? author_description;

  Article.fromJson(Map<String, dynamic> data) {
    id = data["id"];
    text = data["text"];
    title = data["title"];
    image_url = data["image_url"];
    author_name = data["author_name"];
    author_image = data["author_image"];
    author_description = data["author_description"];
    full_text = data["full_text"];
    url = data["url"];
    premium = data["premium"];
    order = data["order"];
    image = data["image"];
  }
}
