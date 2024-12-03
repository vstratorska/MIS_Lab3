import 'package:flutter/material.dart';
import 'package:lab2/models/joketype.dart';
import 'package:lab2/widgets/joketype/joketype_data.dart';


class JokeTypeCard extends StatelessWidget {
  final int id;
  final String type;


  const JokeTypeCard({super.key, required this.id, required this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: InkWell(
          borderRadius: BorderRadius.circular(10),
          splashColor: Colors.red[50],
          onTap: () => {
            Navigator.pushNamed(context, '/details',
                arguments: JokeType(id: id, type: type))
          },
          child: Container(
            margin: const EdgeInsets.all(5.0),
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black.withOpacity(0.8), width: 2),
                borderRadius: BorderRadius.circular(5)
            ),
            child: JokeTypeCardData(type: type),
          )
      ),
    );
  }
}