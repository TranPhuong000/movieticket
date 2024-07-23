import 'package:flutter/material.dart';
import 'package:movie/api_service.dart';
import 'package:movie/pages/detailPage/detailPage.dart';

class SearchMoviePage extends StatefulWidget {
  const SearchMoviePage({super.key});

  @override
  State<SearchMoviePage> createState() => _SearchMoviePageState();
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

class _SearchMoviePageState extends State<SearchMoviePage> {
  dynamic apiResultDanhSachPhim;
  dynamic apiResultDanhSachPhim1;
  final ApiService apiService =
      ApiService(baseUrl: 'https://movienew.cybersoft.edu.vn');
  List<Movie> movies = [];
  List<String> movieTitles = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchDanhSachphim();
    fetchDanhSachphim1();
  }

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

        movieTitles = movies.map((movie) => movie.title).toList();
        isLoading = false;
      });
    } catch (e) {
      print('Error: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  String removeDiacritics(String str) {
    final diacriticsMap = {
      'a': 'áàảãạăắằẳẵặâấầẩẫậ',
      'e': 'éèẻẽẹêếềểễệ',
      'i': 'íìỉĩị',
      'o': 'óòỏõọôốồổỗộơớờởỡợ',
      'u': 'úùủũụưứừửữự',
      'y': 'ýỳỷỹỵ',
      'd': 'đ',
      'A': 'ÁÀẢÃẠĂẮẰẲẴẶÂẤẦẨẪẬ',
      'E': 'ÉÈẺẼẸÊẾỀỂỄỆ',
      'I': 'ÍÌỈĨỊ',
      'O': 'ÓÒỎÕỌÔỐỒỔỖỘƠỚỜỞỠỢ',
      'U': 'ÚÙỦŨỤƯỨỪỬỮỰ',
      'Y': 'ÝỲỶỸỴ',
      'D': 'Đ',
    };
    diacriticsMap.forEach((key, value) {
      for (int i = 0; i < value.length; i++) {
        str = str.replaceAll(value[i], key);
      }
    });
    return str;
  }

  Future<void> fetchDanhSachphim1() async {
    try {
      final result = await apiService.getRequest(
        '/api/QuanLyPhim/LayDanhSachPhim?maNhom=GP01',
        {
          'Content-Type': 'application/json',
          'TokenCybersoft':
              'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0ZW5Mb3AiOiJCb290Y2FtcCA2NCIsIkhldEhhblN0cmluZyI6IjA4LzA5LzIwMjQiLCJIZXRIYW5UaW1UaW1lIjoiMTcyNTc1MzYwMDAwMCIsIm5iZiI6MTY5NTkyMDQwMCwiZXhwIjoxNzI1OTAxMjAwfQ.fWIHiHRVx9B7UlCgFCwvvXAlcVc-I-RB603rEDsM_wI',
        },
      );

      setState(() {
        apiResultDanhSachPhim1 = result;
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

        movieTitles = movies.map((movie) => movie.title).toList();
        isLoading = false;
      });
    } catch (e) {
      print('Error: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
        ),
      ),
      home: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Tìm kiếm phim',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
          ),
          backgroundColor: Colors.black,
          body: isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 14),
                      Autocomplete<String>(
                        optionsBuilder: (TextEditingValue textEditingValue) {
                          if (textEditingValue.text == '') {
                            return const Iterable<String>.empty();
                          }
                          String query = removeDiacritics(
                              textEditingValue.text.toLowerCase());
                          List<String> matches =
                              movieTitles.where((String option) {
                            String normalizedOption =
                                removeDiacritics(option.toLowerCase());
                            return normalizedOption.contains(query);
                          }).toList();
                          if (matches.isEmpty) {
                            return ['Không có kết quả tìm kiếm'];
                          }
                          return matches;
                        },
                        onSelected: (String selection) {
                          if (selection != 'Không có kết quả tìm kiếm') {
                            final selectedMovie = movies.firstWhere(
                                (movie) => movie.title == selection);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MovieDetailPage(
                                  id: selectedMovie.maPhim,
                                ),
                              ),
                            );
                          }
                        },
                        fieldViewBuilder: (BuildContext context,
                            TextEditingController fieldTextEditingController,
                            FocusNode fieldFocusNode,
                            VoidCallback onFieldSubmitted) {
                          return TextField(
                            controller: fieldTextEditingController,
                            focusNode: fieldFocusNode,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.search,
                                color: Colors.white,
                              ),
                              hintText: 'Nhập tên phim...',
                              hintStyle: const TextStyle(color: Colors.white70),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0)),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0)),
                              ),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.1),
                            ),
                          );
                        },
                        optionsViewBuilder: (BuildContext context,
                            AutocompleteOnSelected<String> onSelected,
                            Iterable<String> options) {
                          return Align(
                            alignment: Alignment.topLeft,
                            child: Material(
                              elevation: 4.0,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                color: Colors.black,
                                child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: options.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final String option =
                                        options.elementAt(index);
                                    return InkWell(
                                      onTap: () {
                                        onSelected(option);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Text(
                                          option,
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
