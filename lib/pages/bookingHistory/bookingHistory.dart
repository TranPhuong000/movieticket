import 'package:flutter/material.dart';
import 'package:movie/api_service.dart';
import 'package:movie/pages/bookingHistory/detailBookingHistory.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class BookHistoryPage extends StatefulWidget {
  const BookHistoryPage({super.key});

  @override
  State<BookHistoryPage> createState() => _BookHistoryPageState();
}

class _BookHistoryPageState extends State<BookHistoryPage> {
  Map<String, dynamic>? userData;
  List<dynamic>? danhSachDatVe; // Danh sách thông tin đặt vé từ API
  final ApiService apiService =
      ApiService(baseUrl: 'https://movienew.cybersoft.edu.vn');

  @override
  void initState() {
    super.initState();
    fetchUserDataAndLichSuDatVe();
  }

  Future<void> fetchUserDataAndLichSuDatVe() async {
    try {
      final data = await getUserData();
      if (data != null) {
        setState(() {
          userData = data;
        });

        final result = await apiService.postRequest(
          '/api/QuanLyNguoiDung/ThongTinTaiKhoan',
          {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${data['accessToken']}',
            'TokenCybersoft':
                'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0ZW5Mb3AiOiJCb290Y2FtcCA2NCIsIkhldEhhblN0cmluZyI6IjA4LzA5LzIwMjQiLCJIZXRIYW5UaW1lIjoiMTcyNTc1MzYwMDAwMCIsIm5iZiI6MTY5NTkyMDQwMCwiZXhwIjoxNzI1OTAxMjAwfQ.fWIHiHRVx9B7UlCgFCwvvXAlcVc-I-RB603rEDsM_wI',
          },
          {},
        );

        setState(() {
          danhSachDatVe = result['content']
              ['thongTinDatVe']; // Lấy danh sách đặt vé từ kết quả API
        });

        print('data api from booking history $result');
      } else {
        print('No user data found');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          const SizedBox(height: 30),
          SizedBox(
            height: size.height / 10,
            child: const Center(
              child: Text(
                "Lịch Sử Đặt Vé",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: danhSachDatVe != null && danhSachDatVe!.isNotEmpty
                ? ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    itemCount: danhSachDatVe!.length,
                    itemBuilder: (context, index) {
                      return Center(
                        child: CardHistoryOrder(context, danhSachDatVe![index]),
                      );
                    },
                  )
                : Center(
                    child: Text(
                      'Không có lịch sử đặt vé',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget CardHistoryOrder(BuildContext context, dynamic ve) {
    // Định dạng lại chuỗi ngày tháng
    DateTime dateTime = DateTime.parse(ve['ngayDat']);
    String formattedDate = DateFormat('dd/MM/yyyy HH:mm').format(dateTime);

    return Container(
      height: 150, // Đặt chiều cao cố định cho Card
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        elevation: 4,
        child: InkWell(
          onTap: () {
            // Implement navigation to detail page with 've' data
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailBookingHistory(ve: ve),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: NetworkImage(ve['hinhAnh']),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        ve['tenPhim'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        formattedDate, // Sử dụng chuỗi đã được định dạng lại
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward_ios, color: Colors.grey),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<Map<String, dynamic>?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userDataString = prefs.getString('userData');
    if (userDataString != null) {
      return jsonDecode(userDataString);
    }
    return null;
  }
}
