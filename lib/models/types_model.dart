import 'dart:convert';

JType typeFromJson(String str) => JType.fromJson(json.decode(str));


class JType {
  final List<Joke> jokes;
   final String type;

  JType({
    this.jokes = const [],
     this.type = ''
  });

  factory JType.fromJson(Map<String, dynamic> json) => JType(
     jokes: List<Joke>.from(json["jokes"].map((j) => Joke.fromJson(j))) ?? [],
     type: json["type"] ?? '',
  );
}



 class Joke {
  final String type;
  final String setup;
  final String punchline;
  final int id;
  bool isFavorite = false;


  Joke({
    this.type = '',
    this.setup = '',
    this.punchline = '',
    this.id = 0
  });

  factory Joke.fromJson(Map<String, dynamic> json) => Joke(
    type: json["type"] ?? '',
    setup: json["setup"] ?? '',
    punchline: json["punchline"] ?? '',
    id: json["id"] ?? 1,
  );

}


