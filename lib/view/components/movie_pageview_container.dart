import 'package:flutter/material.dart';
import 'package:movies/data/model/movie_entity.dart';

class PageViewContainer extends StatelessWidget {
  final MovieEntity movieEntity;
  const PageViewContainer({super.key, required this.movieEntity});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        //color: Colors.grey,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [Icon(Icons.check_circle_outline)],
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              fit: BoxFit.cover,
              movieEntity.poster,
              height: MediaQuery.of(context).size.height > 800 ? 350 : 280,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 00),
            child: Text(
              textAlign: TextAlign.center,
              movieEntity.title,
              style: const TextStyle(
                fontSize: 20,
                fontFamily: "LemonMilk",
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              movieEntity.year,
              style: const TextStyle(
                  fontFamily: "LemonMilk",
                  fontSize: 18,
                  fontWeight: FontWeight.w900),
            ),
          )
        ],
      ),
    );
  }
}
