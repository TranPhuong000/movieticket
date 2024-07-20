import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie/api_service.dart';
import 'package:movie/pages/selectCinema/customHeader.dart';
import 'package:movie/pages/selectSeat/selectSeatPage.dart';

class SelectCinemaPage extends StatefulWidget {
  final String movieId;
  final String tenPhim;

  const SelectCinemaPage(
      {super.key, required this.movieId, required this.tenPhim});

  @override
  _SelectCinemaPageState createState() => _SelectCinemaPageState();
}

class _SelectCinemaPageState extends State<SelectCinemaPage> {
  dynamic apiResultDanhSachRapChieu;
  bool isLoading = true; // Sử dụng biến này để kiểm tra trạng thái loading
  final ApiService apiService =
      ApiService(baseUrl: 'https://movienew.cybersoft.edu.vn');

  @override
  void initState() {
    super.initState();
    fetchDanhSachBanner(widget.movieId);
  }

  Future<void> fetchDanhSachBanner(String id) async {
    try {
      final result = await apiService.getRequest(
        '/api/QuanLyRap/LayThongTinLichChieuPhim?MaPhim=$id',
        {
          'Content-Type': 'application/json',
          'MaPhim': '',
          'TokenCybersoft':
              'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0ZW5Mb3AiOiJCb290Y2FtcCA2NCIsIkhldEhhblN0cmluZyI6IjA4LzA5LzIwMjQiLCJIZXRIYW5UaW1UaW1lIjoiMTcyNTc1MzYwMDAwMCIsIm5iZiI6MTY5NTkyMDQwMCwiZXhwIjoxNzI1OTAxMjAwfQ.fWIHiHRVx9B7UlCgFCwvvXAlcVc-I-RB603rEDsM_wI',
        },
      );

      if (result != null && result['statusCode'] == 200) {
        setState(() {
          apiResultDanhSachRapChieu = result['content']['heThongRapChieu'];
          isLoading =
              false; // Khi có dữ liệu thành công, set isLoading về false
        });
      } else {
        setState(() {
          isLoading =
              false; // Khi lỗi hoặc dữ liệu không hợp lệ, cũng set isLoading về false
        });
        print('API response format incorrect or data not found.');
      }
    } catch (e) {
      setState(() {
        isLoading = false; // Xử lý lỗi khi gọi API
      });
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    print('Movie ID: ${widget.movieId}');
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomHeader(
              size: size,
              content: widget.tenPhim,
            ),
            const SizedBox(
              height: 40,
            ),
            isLoading
                ? const Center(
                    child:
                        CircularProgressIndicator(), // Hiển thị loading khi đang fetch dữ liệu
                  )
                : apiResultDanhSachRapChieu == null ||
                        apiResultDanhSachRapChieu.isEmpty
                    ? const Center(
                        child: Text(
                          'Không có lịch chiếu',
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    : Expanded(
                        child: DefaultTabController(
                          length: apiResultDanhSachRapChieu.length,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              TabBar(
                                tabs: apiResultDanhSachRapChieu
                                    .map<Widget>((heThongRap) {
                                  return Tab(
                                    text: heThongRap['tenHeThongRap'],
                                  );
                                }).toList(),
                                isScrollable: true,
                              ),
                              Expanded(
                                child: TabBarView(
                                  children: apiResultDanhSachRapChieu
                                      .map<Widget>((heThongRap) {
                                    return ListView.builder(
                                      itemCount:
                                          heThongRap['cumRapChieu'].length,
                                      itemBuilder: (context, index) {
                                        final cumRap =
                                            heThongRap['cumRapChieu'][index];
                                        return GestureDetector(
                                          onTap: () {
                                            final maLichChieu =
                                                cumRap['lichChieuPhim'][0]
                                                    ['maLichChieu'];
                                            print('Tapped on: $maLichChieu');
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return SelectSeatPage(
                                                maLichChieu: maLichChieu,
                                              );
                                            }));
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 8.0,
                                                horizontal: 16.0),
                                            padding: const EdgeInsets.all(12.0),
                                            decoration: BoxDecoration(
                                              color: Colors
                                                  .white70, // Màu nền của ListTile
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  cumRap['tenCumRap'],
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18.0,
                                                  ),
                                                ),
                                                const SizedBox(height: 8.0),
                                                Text(
                                                  'Ngày chiếu: ${DateFormat('dd/MM/yyyy HH:mm').format(DateTime.parse(cumRap['lichChieuPhim'][0]['ngayChieuGioChieu']))}',
                                                  style: const TextStyle(
                                                      fontSize: 14.0),
                                                ),
                                                const SizedBox(height: 4.0),
                                                Text(
                                                  'Tên rạp: ${cumRap['lichChieuPhim'][0]['tenRap']}',
                                                  style: const TextStyle(
                                                      fontSize: 14.0),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}
