import 'package:flutter/material.dart';
import 'package:movie/api_service.dart';
import 'package:movie/pages/OrderSuccess/orderSuccess.dart';
import 'package:movie/pages/selectSeat/info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import './header.dart';

class CheckOutPage extends StatefulWidget {
  final TicketInfo ticketInfo;
  final Map<String, dynamic> thongTinPhim;
  final int selectedSeatsCount;
  final int ticketPrice;
  final List<String> selectedSeatNames;

  CheckOutPage({
    Key? key,
    required this.ticketInfo,
    required this.thongTinPhim,
    required this.selectedSeatsCount,
    required this.ticketPrice,
    required this.selectedSeatNames,
  }) : super(key: key);

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  Map<String, dynamic>? userData;
  final ApiService apiService =
      ApiService(baseUrl: 'https://movienew.cybersoft.edu.vn');
  bool isLoading = false;

  Future<void> datve() async {
    setState(() {
      isLoading = true;
    });
    try {
      final result = await apiService.postRequest(
        '/api/QuanLyDatVe/DatVe',
        {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${userData!['accessToken']}',
          'TokenCybersoft':
              'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0ZW5Mb3AiOiJCb290Y2FtcCA2NCIsIkhldEhhblN0cmluZyI6IjA4LzA5LzIwMjQiLCJIZXRIYW5UaW1lIjoiMTcyNTc1MzYwMDAwMCIsIm5iZiI6MTY5NTkyMDQwMCwiZXhwIjoxNzI1OTAxMjAwfQ.fWIHiHRVx9B7UlCgFCwvvXAlcVc-I-RB603rEDsM_wI',
        },
        widget.ticketInfo.toJson(),
      );

      print('Kết quả đặt vé: $result');

      if (result != null && result['statusCode'] == 200) {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const OrderSuccess();
        }));
      } else {
        print("failed to load OrderSuccess Page");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _loadUserData() async {
    final data = await getUserData();
    print(data!['accessToken']);
    setState(() {
      userData = data;
    });
  }

  Future<Map<String, dynamic>?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userDataString = prefs.getString('userData');
    if (userDataString != null) {
      return jsonDecode(userDataString);
    }
    return null;
  }

  @override
  void initState() {
    _loadUserData();
    super.initState();
  }

  String formatSeatNumbers(List<String> seatNames) {
    return seatNames
        .map((name) => name.padLeft(2, '0')) // Thêm số 0 ở đầu nếu cần
        .join(', '); // Nối các tên ghế với dấu phẩy
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    print('from checkoutPage ${widget.ticketInfo.toJson()}');
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            CustomHeader(size: size, content: "Thông Tin Vé"),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              padding: const EdgeInsets.symmetric(vertical: 24),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: size.width / 2.5,
                    alignment: Alignment.centerLeft,
                    child: Image.network(
                      widget.thongTinPhim['hinhAnh'],
                      fit: BoxFit.cover,
                      scale: 1.2,
                    ),
                  ),
                  MovieInfo(size: size, thongTinPhim: widget.thongTinPhim),
                ],
              ),
            ),
            BuildPriceTag(
                'ID Lịch Chiếu', ' ${widget.thongTinPhim['maLichChieu']}'),
            BuildPriceTag('Tên Rạp', widget.thongTinPhim['tenCumRap']),
            BuildPriceTag('Thời Gian',
                '${widget.thongTinPhim['ngayChieu']} ${widget.thongTinPhim['gioChieu']}'),
            BuildPriceTag('Số Ghế',
                formatSeatNumbers(widget.selectedSeatNames)), // Đã sửa ở đây
            BuildPriceTag('Giá', '${widget.ticketPrice} VND'),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            Expanded(
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    datve();
                  },
                  child: Container(
                    height: size.height / 16,
                    width: size.width / 3,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'Thanh Toán',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container BuildPriceTag(String content, String price) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            content,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            price,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class MovieInfo extends StatelessWidget {
  final Size size;
  final Map<String, dynamic> thongTinPhim;

  const MovieInfo({
    super.key,
    required this.size,
    required this.thongTinPhim,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 8, bottom: 8),
            width: size.width,
            child: Text(
              thongTinPhim['tenPhim'] ?? 'Tên phim',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 8, bottom: 8),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 3),
                  child: Icon(Icons.star, color: Colors.yellow, size: 18),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 3),
                  child: Icon(Icons.star, color: Colors.yellow, size: 18),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 3),
                  child: Icon(Icons.star, color: Colors.yellow, size: 18),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 3),
                  child: Icon(Icons.star, color: Colors.yellow, size: 18),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 3),
                  child: Icon(Icons.star, color: Colors.yellow, size: 18),
                ),
                Text(
                  '(5.0)',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 8, bottom: 8),
            width: size.width,
            child: Text(
              thongTinPhim['tenRap'] ?? 'Tên rạp',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 8, bottom: 8),
            width: size.width,
            child: Text(
              '1h41min',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
