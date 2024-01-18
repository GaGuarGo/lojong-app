class Quote {
  int? id;
  String? text;
  String? author;
  int? order;

  Quote.fromJson(Map<String, dynamic> data) {
    id = data["id"];
    text = data["text"];
    author = data["author"];
    order = data["order"];
  }
}
