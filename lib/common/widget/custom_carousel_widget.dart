import 'package:flutter/cupertino.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:safetyapp/common/widget/customweb.dart';
import 'package:safetyapp/utiles/quotes.dart';

class CustomCarousel extends StatelessWidget {
  const CustomCarousel({super.key});
  void navigateToRoute(BuildContext context, Widget route) {
    Navigator.push(context, CupertinoPageRoute(builder: (context) => route));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CarouselSlider(
        items: List.generate(
          imageSliders.length,
          (index) => InkWell(
            onTap: () {
              if (index == 0) {
                navigateToRoute(
                    context,
                    const CustomWebView(
                        url:
                            "https://gulfnews.com/world/asia/pakistan/womens-day-10-pakistani-women-inspiring-the-country-1.77696239"));
              } else if (index == 1) {
                navigateToRoute(
                    context,
                    const CustomWebView(
                        url:
                            "https://plan-international.org/ending-violence/16-ways-end-violence-girls"));
              } else if (index == 2) {
                navigateToRoute(
                    context,
                    const CustomWebView(
                        url:
                            "https://www.healthline.com/health/womens-health/self-defense-tips-escape"));
              } else {
                navigateToRoute(
                    context,
                    const CustomWebView(
                        url:
                            "https://www.healthline.com/health/womens-health/self-defense-tips-escape"));
              }
            },
            child: Card(
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image: NetworkImage(
                        imageSliders[index],
                      ),
                      fit: BoxFit.cover),
                ),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(colors: [
                        Colors.black.withOpacity(0.6),
                        Colors.transparent,
                      ])),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        articleTitle[index],
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        options: CarouselOptions(
          autoPlay: true,
          aspectRatio: 16 / 9,
          enlargeCenterPage: true,
          pauseAutoPlayOnTouch: true,
          autoPlayCurve: Curves.easeIn,
        ),
      ),
    );
  }
}
