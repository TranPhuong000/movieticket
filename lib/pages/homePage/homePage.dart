import 'package:flutter/material.dart';
import 'package:movie/api_service.dart';
import 'package:movie/components/order_button.dart';
import 'package:movie/pages/account/detailAccount.dart';
import 'package:movie/pages/detailPage/detailPage.dart';
import 'package:movie/pages/homePage/comingsoon.dart';
import 'package:movie/pages/homePage/promo.dart';
import 'package:movie/pages/homePage/slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class Movie {
  late String maPhim;
  late String title;
  late String image;
  late String description;
  late String duration;

  Movie({
    required this.maPhim,
    required this.title,
    required this.image,
    required this.description,
    required this.duration,
  });
}

class _HomepageState extends State<Homepage> {
  int current = 0;
  final CarouselController carouselController = CarouselController();

  dynamic apiResultDanhSachPhim;
  dynamic apiResultDanhSachBanner;
  final ApiService apiService =
      ApiService(baseUrl: 'https://movienew.cybersoft.edu.vn');
  List<Movie> movies = [];

  Future<void> fetchDanhSachphim() async {
    try {
      final result = await apiService.getRequest(
        '/api/QuanLyPhim/LayDanhSachPhim?maNhom=GP03',
        {
          'Content-Type': 'application/json',
          'TokenCybersoft':
              'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0ZW5Mb3AiOiJCb290Y2FtcCA2NCIsIkhldEhhblN0cmluZyI6IjA4LzA5LzIwMjQiLCJIZXRIYW5UaW1UaW1lIjoiMTcyNTc1MzYwMDAwMCIsIm5iZiI6MTY5NTkyMDQwMCwiZXhwIjoxNzI1OTAxMjAwfQ.fWIHiHRVx9B7UlCgFCwvvXAlcVc-I-RB603rEDsM_wI',
        },
      );

      setState(() {
        apiResultDanhSachPhim = result;
        movies = (result['content'] as List)
            .map((movie) => Movie(
                  maPhim: movie['maPhim'].toString(),
                  title: movie['tenPhim'] ?? 'No Title',
                  image: movie['hinhAnh'] ?? '',
                  description: movie['moTa'] ?? 'No Description',
                  duration:
                      movie['thoiLuong']?.toString() ?? 'Unknown Duration',
                ))
            .toList();
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> fetchDanhSachBanner() async {
    try {
      final result = await apiService.getRequest(
        '/api/QuanLyPhim/LayDanhSachBanner',
        {
          'Content-Type': 'application/json',
          'TokenCybersoft':
              'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0ZW5Mb3AiOiJCb290Y2FtcCA2NCIsIkhldEhhblN0cmluZyI6IjA4LzA5LzIwMjQiLCJIZXRIYW5UaW1UaW1lIjoiMTcyNTc1MzYwMDAwMCIsIm5iZiI6MTY5NTkyMDQwMCwiZXhwIjoxNzI1OTAxMjAwfQ.fWIHiHRVx9B7UlCgFCwvvXAlcVc-I-RB603rEDsM_wI',
        },
      );

      setState(() {
        apiResultDanhSachBanner = result;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    fetchDanhSachphim();
    fetchDanhSachBanner();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
        ),
      ),
      home: Scaffold(
        backgroundColor: Colors.black,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text(
            'Ticket Trove',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),
          ),
          centerTitle: true,
          actions: <Widget>[
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const AccountDetailPage();
                    }));
                  },
                  child: const CircleAvatar(
                    radius: 20.0,
                    backgroundImage: AssetImage('assets/images/ava.png'),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                SizedBox(
                  height: size.height * 0.7,
                  child: movies.isNotEmpty
                      ? Stack(
                          fit: StackFit.expand,
                          children: [
                            Positioned.fill(
                              child: Image.network(
                                movies[current].image,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset(
                                    'assets/images/null.png',
                                    fit: BoxFit.cover,
                                  );
                                },
                              ),
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
                            Positioned(
                              top: 60,
                              child: SizedBox(
                                width: size.width,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CarouselSlider(
                                      carouselController: carouselController,
                                      options: CarouselOptions(
                                        height: 700.0,
                                        aspectRatio: 16 / 7,
                                        viewportFraction: 0.7,
                                        autoPlay: true,
                                        enlargeCenterPage: true,
                                        onPageChanged: (index, reason) {
                                          setState(() {
                                            current = index;
                                          });
                                        },
                                      ),
                                      items: movies.map((movie) {
                                        return Builder(
                                          builder: (BuildContext context) {
                                            return Container(
                                              width: size.width * 0.5,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5.0),
                                              decoration: BoxDecoration(
                                                color: Colors.transparent,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    movie.title,
                                                    style: TextStyle(
                                                        fontSize: 25,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                        fontFamily: GoogleFonts
                                                                .shojumaru()
                                                            .fontFamily),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: List.generate(5,
                                                        (index) {
                                                      return const Icon(
                                                        Icons.star,
                                                        color: Colors.yellow,
                                                        size: 15,
                                                      );
                                                    }),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  OrderButton(
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              MovieDetailPage(
                                                            id: movies[current]
                                                                .maPhim,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    text: 'Đặt Ngay',
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Container(
                                                    height: 300,
                                                    clipBehavior: Clip.hardEdge,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Image.network(
                                                      movie.image,
                                                      fit: BoxFit.cover,
                                                      errorBuilder: (context,
                                                          error, stackTrace) {
                                                        return Image.asset(
                                                          'assets/images/null.png',
                                                          fit: BoxFit.cover,
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      }).toList(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      : const Center(child: CircularProgressIndicator()),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  child: Text(
                    'Phim Đang Chiếu',
                    style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                SizedBox(
                  child: apiResultDanhSachPhim != null
                      ? SliderCarousel(
                          banners: apiResultDanhSachPhim['content'], size: size)
                      : const Center(child: CircularProgressIndicator()),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                  child: Text(
                    'Phim Sắp Chiếu',
                    style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                ComingSoon(),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                  child: Text(
                    'Giảm giá',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                Promo(size: size),
                Promo(size: size),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
