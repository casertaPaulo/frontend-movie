import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/view/pages/home_page.dart';

class IntroductionPage extends StatefulWidget {
  const IntroductionPage({super.key});

  @override
  State<IntroductionPage> createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/popcorn-crop.jpg"),
          const Padding(
            padding: EdgeInsets.only(top: 30),
            child: Text(
              "Welcome",
              style: TextStyle(
                color: Colors.white,
                fontFamily: "LemonMilk-bold",
                fontSize: 30,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
            child: Text(
              "This is a frontend interface that consumes a movie Rest API made with Spring Boot and Java.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade400,
                fontFamily: "LEMONMILK",
                fontSize: 13,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFaf4a02),
                      foregroundColor: Colors.amber,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Try it",
                          style: TextStyle(fontFamily: 'LemonMilk-bold'),
                        ),
                        Icon(
                          Icons.arrow_forward_rounded,
                        ),
                      ],
                    ),
                    onPressed: () => {
                      Get.to(() => const HomePage(),
                          transition: Transition.downToUp)
                    },
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
