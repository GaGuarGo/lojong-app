// ignore_for_file: non_constant_identifier_names

class Video {
  int? id;
  String? name;
  String? description;
  String? file;
  String? url;
  String? url2;
  String? aws_url;
  String? image;
  String? image_url;
  int? premium;
  int? order;

  Video.fromJson(Map<String, dynamic> data) {
    id = data["id"];
    name = data["name"];
    description = data["description"];
    file = data["file"];
    url = data["url"];
    url2 = data["url2"];
    aws_url = data["aws_url"];
    image = data["image"];
    image_url = data["image_url"];
    premium = data["premium"];
    order = data["order"];
  }
}
