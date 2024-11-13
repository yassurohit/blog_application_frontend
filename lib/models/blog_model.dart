import 'dart:convert';

class BlogPost {
  String title;
  String content;
  String author;
  int postId;
  String image; // Added image field

  BlogPost(
      {required this.title,
      required this.content,
      required this.author,
      required this.postId,
      required this.image}); // Include image in the constructor

  factory BlogPost.fromRawJson(String str) =>
      BlogPost.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BlogPost.fromJson(Map<String, dynamic> json) => BlogPost(
        title: json["title"],
        content: json["content"],
        author: json["author"],
        postId: json["postId"],
        image: json["image"] ??
            "", // Handle image (if it's null, use empty string)
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "content": content,
        "author": author,
        "postId": postId,
        "image": image, // Include image in JSON output
      };
}
