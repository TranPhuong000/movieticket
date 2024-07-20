import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:movie/pages/detailPage/detailPage.dart';

class SliderCarousel extends StatelessWidget {
  const SliderCarousel({
    Key? key,
    required this.banners,
    required this.size,
  }) : super(key: key);

  final List<dynamic> banners;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: banners
          .map((banner) => Builder(
                builder: (context) {
                  return GestureDetector(
                    onTap: () {
                      String maPhimm = banner['maPhim'].toString();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MovieDetailPage(id: maPhimm)),
                      );
                    },
                    child: Stack(
                      children: [
                        Container(
                          width: size.width,
                          padding: const EdgeInsets.only(left: 10, bottom: 24),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(banner['hinhAnh']))),
                        ),
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.black.withOpacity(1),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  banner['tenPhim'],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                const Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                      size: 18,
                                    ),
                                    Icon(Icons.star,
                                        color: Colors.yellow, size: 18),
                                    Icon(Icons.star,
                                        color: Colors.yellow, size: 18),
                                    Icon(Icons.star,
                                        color: Colors.yellow, size: 18),
                                    Icon(Icons.star,
                                        color: Colors.yellow, size: 18),
                                    Text(
                                      '(5.0)',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ))
          .toList(),
      options: CarouselOptions(autoPlay: true, enlargeCenterPage: true),
    );
  }
}
