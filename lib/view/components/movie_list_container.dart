import 'package:flutter/material.dart';
import 'package:movies/data/model/movie_entity.dart';

class MovieListContainer extends StatelessWidget {
  final MovieEntity movieEntity;
  const MovieListContainer({super.key, required this.movieEntity});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
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
                        textAlign: TextAlign.start,
                        movieEntity.title,
                        style: TextStyle(
                          fontSize: movieEntity.title.length > 30 ? 18 : 23,
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
      ),
    );
  }
}
