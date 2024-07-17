import 'package:flutter/material.dart';
import 'package:movies/domain/model/movie_entity.dart';

class MovieListContainer extends StatelessWidget {
  final MovieEntity movieEntity;
  const MovieListContainer({super.key, required this.movieEntity});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        //color: Colors.grey,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              movieEntity.poster,
              height: 200,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30, left: 20),
            child: SizedBox(
              height: 150,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 150,
                    child: Text(
                      textAlign: TextAlign.left,
                      movieEntity.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontFamily: "LemonMilk",
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  Text(
                    movieEntity.year,
                    style: const TextStyle(
                        fontSize: 20,
                        fontFamily: "LemonMilk",
                        fontWeight: FontWeight.w900),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
