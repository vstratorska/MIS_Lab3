import 'package:flutter/material.dart';
import 'package:lab2/models/joketype.dart';
import 'package:lab2/widgets/joketype/joketype_card.dart';


class JokeTypeGrid extends StatefulWidget {
  final List<JokeType> joketypes;
  const JokeTypeGrid({super.key, required this.joketypes});

  @override
  State<JokeTypeGrid> createState() => _JokeTypeGridState();
}

class _JokeTypeGridState extends State<JokeTypeGrid> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(padding: const EdgeInsets.all(4),
        crossAxisCount: 2,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
        semanticChildCount: 250,
        childAspectRatio: 200/ 250,
        shrinkWrap: true,
        children: widget.joketypes.map((joketype) => JokeTypeCard(
          id: joketype.id, type: joketype.type,
        )).toList()
    );
  }
}