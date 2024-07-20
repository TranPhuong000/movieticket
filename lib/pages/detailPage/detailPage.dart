import 'package:flutter/material.dart';
import 'package:movie/api_service.dart';
import 'package:movie/pages/detailPage/arrowBack.dart';
import 'package:movie/pages/detailPage/background.dart';
import 'package:movie/pages/detailPage/trailler.dart';
import 'package:movie/pages/selectCinema/selectCinamaPage.dart';

class MovieDetailPage extends StatefulWidget {
  final String id;

  const MovieDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class MovieDetail {
  final int maPhim;
  final String tenPhim;
  final String biDanh;
  final String trailer;
  final String hinhAnh;
  final String moTa;
  final String maNhom;
  final bool hot;
  final bool dangChieu;
  final bool sapChieu;
  final DateTime ngayKhoiChieu;
  final double danhGia;

  MovieDetail({
    required this.maPhim,
    required this.tenPhim,
    required this.biDanh,
    required this.trailer,
    required this.hinhAnh,
    required this.moTa,
    required this.maNhom,
    required this.hot,
    required this.dangChieu,
    required this.sapChieu,
    required this.ngayKhoiChieu,
    required this.danhGia,
  });

  factory MovieDetail.fromJson(Map<String, dynamic> json) {
    return MovieDetail(
      maPhim: json['maPhim'],
      tenPhim: json['tenPhim'],
      biDanh: json['biDanh'],
      trailer: json['trailer'],
      hinhAnh: json['hinhAnh'],
      moTa: json['moTa'],
      maNhom: json['maNhom'],
      hot: json['hot'],
      dangChieu: json['dangChieu'],
      sapChieu: json['sapChieu'],
      ngayKhoiChieu: DateTime.parse(json['ngayKhoiChieu']),
      danhGia: json['danhGia'].toDouble(),
    );
  }
}

class _MovieDetailPageState extends State<MovieDetailPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Future<MovieDetail>? _futureMovieDetail;
  final ApiService _apiService =
      ApiService(baseUrl: 'https://movienew.cybersoft.edu.vn');

  @override
  void initState() {
    super.initState();
    _futureMovieDetail = fetchMovieDetail(widget.id);
    _tabController = TabController(length: 2, vsync: this);
  }

  Future<MovieDetail> fetchMovieDetail(String id) async {
    final result = await _apiService.getRequest(
      '/api/QuanLyPhim/LayThongTinPhim?MaPhim=$id',
      {
        'Content-Type': 'application/json',
        'TokenCybersoft':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0ZW5Mb3AiOiJCb290Y2FtcCA2NCIsIkhldEhhblN0cmluZyI6IjA4LzA5LzIwMjQiLCJIZXRIYW5UaW1UaW1lIjoiMTcyNTc1MzYwMDAwMCIsIm5iZiI6MTY5NTkyMDQwMCwiZXhwIjoxNzI1OTAxMjAwfQ.fWIHiHRVx9B7UlCgFCwvvXAlcVc-I-RB603rEDsM_wI',
      },
    );

    return MovieDetail.fromJson(result['content']);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder<MovieDetail>(
        future: _futureMovieDetail,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final MovieDetail movieDetail = snapshot.data!;

            return SingleChildScrollView(
              child: Stack(
                children: [
                  BackgroundWidget(imageUrl: movieDetail.hinhAnh),
                  const ArrowBack(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: 24,
                          top: size.height / 6.5,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: size.width / 2.5,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.network(
                                  movieDetail.hinhAnh,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 90,
                                    ),
                                    Text(
                                      movieDetail.tenPhim,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: List.generate(5, (index) {
                                        return const Icon(
                                          Icons.star,
                                          color: Colors.yellow,
                                          size: 20,
                                        );
                                      }),
                                    ),
                                    const SizedBox(height: 8),
                                    const Text(
                                      '5.0',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    const Text(
                                      'Hành động',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      '1h 41min',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[400],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ElevatedButton.icon(
                          onPressed: () {
                            if (widget.id != null) {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return SelectCinemaPage(
                                  movieId: widget.id,
                                  tenPhim: movieDetail.tenPhim,
                                );
                              }));
                            } else {
                              print('Error: Movie ID is null');
                            }
                          },
                          icon: const Icon(Icons.local_activity,
                              color: Colors.white),
                          label: const Text('Đặt Vé'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            padding: const EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 24.0),
                            textStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height - 120,
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 16),
                              alignment: Alignment.center,
                              width: size.width,
                              child: TabBar(
                                tabs: const [
                                  Tab(
                                    text: 'About Movie',
                                  ),
                                  Tab(
                                    text: 'Trailers',
                                  ),
                                ],
                                controller: _tabController,
                                indicatorSize: TabBarIndicatorSize.label,
                                indicatorColor: Colors.white,
                                labelColor: Colors.white,
                                unselectedLabelColor: Colors.white,
                                labelPadding: EdgeInsets.zero,
                                dividerColor: Colors.black,
                              ),
                            ),
                            Expanded(
                              child: TabBarView(
                                controller: _tabController,
                                children: [
                                  SingleChildScrollView(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          buildTitle('Mô Tả'),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8),
                                            child: Text(
                                              movieDetail.moTa,
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          buildTitle('Diễn Viên'),
                                          // Caster(size: size),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SingleChildScrollView(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Trailer(
                                        trailerUrl: movieDetail.trailer,
                                        imageUrl: movieDetail.hinhAnh,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget buildTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
        color: Colors.white,
      ),
    );
  }
}
