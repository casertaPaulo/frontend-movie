import 'package:flutter/material.dart';
import 'package:movies/components/movie_grid_container.dart';
import 'package:movies/components/movie_list_container.dart';
import 'package:movies/domain/model/movie_entity.dart';
import 'package:movies/domain/repository/movie_repository.dart';
import 'package:movies/domain/service/movie_service.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isGrid = true;
  late MovieService movieService;
  late TextEditingController _controller;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    movieService =
        MovieService(movieRepository: context.read<MovieRepository>());
    _controller = TextEditingController();
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
        body: Padding(
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
                          errorStyle:
                              const TextStyle(fontFamily: "RobotoCondensed"),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFaf4a02)),
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
                          movieService.searchMovies(_controller.text);
                        }
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(50),
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
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(15)),
                          child: const Icon(Icons.grid_view_sharp),
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
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(15)),
                          child:
                              const Icon(Icons.format_list_bulleted_outlined),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 20),
              Consumer<MovieRepository>(
                builder: (BuildContext context, value, Widget? child) {
                  if (value.searchResult.isNotEmpty) {
                    return Expanded(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        transitionBuilder: (child, animation) {
                          return FadeTransition(
                              opacity: animation, child: child);
                        },
                        child: isGrid ? _gridView(value) : _listView(value),
                      ),
                    );
                  } else if (value.isLoading) {
                    return const Center(
                      child: Column(
                        children: [
                          SizedBox(height: 200),
                          CircularProgressIndicator(),
                        ],
                      ),
                    );
                  } else if (value.notFoundResponse) {
                    return Column(
                      children: [
                        Center(
                          child: Image.asset(
                            'assets/images/404.png',
                          ),
                        ),
                        const Text(
                          "Result not found. Try other title.",
                          style: TextStyle(
                            fontFamily: "RobotoCondensed",
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    );
                  } else {
                    return Column(
                      children: [
                        Center(
                          child: Image.asset(
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
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _gridView(MovieRepository movieRepository) {
  return GridView.count(
    crossAxisSpacing: 10,
    childAspectRatio: 0.4,
    crossAxisCount: 2,
    children: List.generate(movieRepository.searchResult.length, (index) {
      return MovieGridContainer(
        movieEntity: movieRepository.searchResult[index],
      );
    }),
  );
}

Widget _listView(MovieRepository movieRepository) {
  return ListView.separated(
    key: const ValueKey<int>(2),
    separatorBuilder: (context, index) => const Divider(),
    itemBuilder: (context, index) {
      return MovieListContainer(
          movieEntity: movieRepository.searchResult[index]);
    },
    itemCount: movieRepository.searchResult.length,
  );
}
