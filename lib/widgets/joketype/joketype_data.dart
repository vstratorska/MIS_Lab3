
import 'package:flutter/material.dart';

class JokeTypeCardData extends StatelessWidget {
  final String type;


  const JokeTypeCardData({super.key, required this.type});

  @override
  Widget build(BuildContext context) {

    return Column(mainAxisSize: MainAxisSize.min,
      children: [
        Container( margin: const EdgeInsets.only(top: 100),
        child: Text(type, style: const TextStyle(
            color: Colors.black54, fontSize: 20, fontWeight: FontWeight.w600,
        ),),)
      ],
    );
  }
}