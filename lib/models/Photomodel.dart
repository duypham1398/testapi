class Photomodel {
  int? albumId;
  int? id;
  String? title;
  String? url;
  String? thumbnailUrl;

  Photomodel({
    required this.albumId,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  Photomodel.fromJson(dynamic json) {
    albumId = json['albumId'];
    id = json['id'];
    title = json['title'];
    url = json['url'];
    thumbnailUrl = json['thumbnailUrl'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['albumId'] = albumId;
    map['id'] = id;
    map['title'] = title;
    map['url'] = url;
    map['thumbnailUrl'] = thumbnailUrl;
    return map;
  }
}
