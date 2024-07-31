import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies/components/movie_pageview_container.dart';
import 'package:movies/components/movie_list_container.dart';
import 'package:movies/data/http/http_client.dart';
import 'package:movies/data/model/movie_entity.dart';
import 'package:movies/data/repositories/movie_repository.dart';
import 'package:movies/view/pages/home/stores/home_page_store.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomePageStore _homePageState =
      HomePageStore(movieRepository: MovieRepository(client: HttpClient()));
  bool isGrid = true;

  final TextEditingController _controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Text(
                      "Search Movies",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "LemonMilk-bold",
                        fontSize: 25,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Form(
                    key: _formKey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width / 1.5,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Input some text";
                              }
                              return null;
                            },
                            controller: _controller,
                            onTapOutside: (_) {
                              FocusScope.of(context).unfocus();
                            },
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.search),
                              hintText: "Search a title",
                              errorStyle: const TextStyle(
                                  fontFamily: "RobotoCondensed"),
                              focusedBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFFaf4a02)),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              // TO-DO:
                              // Implement the new method

                              _homePageState.searchMovies(
                                  title: _controller.text);
                            }
                          },
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.search),
                          ),
                        )
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 50),
                    child: Divider(
                      color: Color(0xFFaf4a02),
                    ),
                  ),
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
                              text: 'Search\n',
                            ),
                            TextSpan(
                              text: "Result",
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
                  const SizedBox(height: 20)
                ],
              ),
            ),
            // IMPLEMENT
            Expanded(
              child: AnimatedBuilder(
                animation: Listenable.merge([
                  _homePageState.isLoading,
                  _homePageState.state,
                  _homePageState.error
                ]),
                builder: (context, child) {
                  if (_homePageState.isLoading.value) {
                    return _loadingResponseWidget();
                  } else if (_homePageState.error.value.isNotEmpty) {
                    return _errorResponseWidget(_homePageState.error.value);
                  } else if (_homePageState.state.value.isEmpty) {
                    return _defaultWidget();
                  } else {
                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      transitionBuilder: (child, animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: child,
                        );
                      },
                      child: isGrid
                          ? _carouselView(_homePageState,
                              _homePageState.state.value, context)
                          : _listView(_homePageState.state.value),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _defaultWidget() {
  return Column(
    children: [
      Center(
        child: Image.asset(
          height: 400,
          'assets/images/search.png',
        ),
      ),
      const Text(
        "You need to search for a movie",
        style: TextStyle(
          fontFamily: "RobotoCondensed",
          fontWeight: FontWeight.bold,
        ),
      )
    ],
  );
}

Widget _loadingResponseWidget() {
  return const Column(
    children: [
      SizedBox(height: 200),
      CircularProgressIndicator(),
    ],
  );
}

Widget _errorResponseWidget(String error) {
  return Column(
    children: [
      Center(
        child: Image.asset(
          'assets/images/404.png',
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(
          textAlign: TextAlign.center,
          error,
          style: const TextStyle(
            fontFamily: "RobotoCondensed",
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ],
  );
}

Widget _carouselView(
    HomePageStore state, List<MovieEntity> movies, BuildContext context) {
  return CarouselSlider.builder(
    itemCount: movies.length,
    itemBuilder: (BuildContext context, index, realIndex) {
      return GestureDetector(
        onTap: () {
          state.saveMovie(title: movies[index].title);
        },
        child: PageViewContainer(movieEntity: movies[index]),
      );
    },
    options: CarouselOptions(
      height: MediaQuery.of(context).size.height > 800 ? 500 : 400,
      enlargeStrategy: CenterPageEnlargeStrategy.zoom,
      viewportFraction: 0.6,
      enlargeCenterPage: true,
    ),
  );
}

Widget _listView(List<MovieEntity> movies) {
  return Padding(
    padding: const EdgeInsets.only(left: 30),
    child: ListView.separated(
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        return MovieListContainer(
          movieEntity: movies[index],
        );
      },
      itemCount: movies.length,
    ),
  );
}
