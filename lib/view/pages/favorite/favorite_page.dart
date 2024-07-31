import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies/components/movie_pageview_container.dart';
import 'package:movies/data/http/http_client.dart';
import 'package:movies/data/model/movie_entity.dart';
import 'package:movies/data/repositories/movie_repository.dart';
import 'package:movies/view/pages/favorite/stores/favorite_page_store.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  final FavoritePageStore _favoritePageStore =
      FavoritePageStore(movieRepository: MovieRepository(client: HttpClient()));

  bool isGrid = false;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _favoritePageStore.getMovies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: "LEMONMILK",
                      ),
                      children: [
                        TextSpan(
                          text: 'Your\n',
                        ),
                        TextSpan(
                          text: "Movies",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            fontFamily: 'LemonMilk-bold',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => setState(() {
                          isGrid = true;
                        }),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              color: isGrid ? Colors.black : Colors.white,
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(15)),
                          child: Icon(
                            Icons.grid_view_sharp,
                            color: isGrid ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      GestureDetector(
                        onTap: () => setState(() {
                          isGrid = false;
                        }),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              color: !isGrid ? Colors.black : Colors.white,
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(15)),
                          child: Icon(
                            Icons.format_list_bulleted_outlined,
                            color: !isGrid ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 50),
          child: Divider(
            color: Color(0xFFaf4a02),
          ),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedBuilder(
              animation: Listenable.merge([
                _favoritePageStore.error,
                _favoritePageStore.isLoading,
                _favoritePageStore.state,
              ]),
              builder: (BuildContext context, Widget? child) {
                if (_favoritePageStore.isLoading.value) {
                  return const CircularProgressIndicator();
                } else if (_favoritePageStore.error.value.isNotEmpty) {
                  return Text(_favoritePageStore.error.value);
                } else if (_favoritePageStore.state.value.isEmpty) {
                  return const Center(child: Text("No favorite films yet."));
                } else {
                  return _carouselView(_favoritePageStore.state.value, context);
                }
              },
            ),
          ),
        ),
      ],
    ));
  }
}

Widget _carouselView(List<MovieEntity> movies, BuildContext context) {
  return CarouselSlider.builder(
    itemCount: movies.length,
    itemBuilder: (BuildContext context, index, realIndex) {
      return PageViewContainer(movieEntity: movies[index]);
    },
    options: CarouselOptions(
      height: MediaQuery.of(context).size.height > 800 ? 500 : 400,
      enlargeStrategy: CenterPageEnlargeStrategy.zoom,
      viewportFraction: 0.6,
      enlargeCenterPage: true,
      enableInfiniteScroll: movies.length > 2,
    ),
  );
}
