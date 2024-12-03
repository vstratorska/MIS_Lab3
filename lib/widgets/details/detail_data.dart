import 'package:flutter/material.dart';
import 'package:lab2/models/types_model.dart';

class DetailData extends StatelessWidget {
  final int id;
  final JType type;
  const DetailData({super.key, required this.id, required this.type});


  @override
  Widget build(BuildContext context) {
    final jokes = type.jokes;
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.white,),
      child: Column(
      children: List.generate(jokes.length, (index){
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Card(
          color: Colors.greenAccent,
          child: ListTile(
          title: Text(jokes[index].setup,
              style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500)),
          subtitle: Text(jokes[index].punchline,
              style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500)),
        ),
            ), );
      }),
    ));
  }
}
