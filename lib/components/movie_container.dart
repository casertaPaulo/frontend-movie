import 'package:flutter/material.dart';
import 'package:movies/domain/model/movie_entity.dart';

class MovieContainer extends StatelessWidget {
  final MovieEntity movieEntity;
  const MovieContainer({super.key, required this.movieEntity});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        //color: Colors.grey,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              movieEntity.poster,
              height: 250,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 30),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                movieEntity.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontFamily: "LemonMilk",
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
