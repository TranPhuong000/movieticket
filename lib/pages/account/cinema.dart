import 'package:flutter/material.dart';
import 'package:movie/api_service.dart';

class CinemaPage extends StatefulWidget {
  const CinemaPage({super.key});

  @override
  State<CinemaPage> createState() => _CinemaPageState();
}

class _CinemaPageState extends State<CinemaPage> {
  dynamic apiResultDanhSachRap;
  final ApiService apiService =
      ApiService(baseUrl: 'https://movienew.cybersoft.edu.vn');

  Future<void> fetchDanhSachRap() async {
    try {
      final result = await apiService.getRequest(
        '/api/QuanLyRap/LayThongTinHeThongRap',
        {
          'Content-Type': 'application/json',
          'TokenCybersoft':
              'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0ZW5Mb3AiOiJCb290Y2FtcCA2NCIsIkhldEhhblN0cmluZyI6IjA4LzA5LzIwMjQiLCJIZXRIYW5UaW1UaW1lIjoiMTcyNTc1MzYwMDAwMCIsIm5iZiI6MTY5NTkyMDQwMCwiZXhwIjoxNzI1OTAxMjAwfQ.fWIHiHRVx9B7UlCgFCwvvXAlcVc-I-RB603rEDsM_wI',
        },
      );

      setState(() {
        apiResultDanhSachRap = result;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    fetchDanhSachRap();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey[900], // Màu nền của trang
        appBar: AppBar(
          backgroundColor: Colors.grey[800], // AppBar màu đỏ đậm

          title: const Text('Danh Sách Rạp Chiếu Phim'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          elevation: 0, // Bỏ đổ bóng của AppBar
        ),
        body: apiResultDanhSachRap == null
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: apiResultDanhSachRap['content'].length,
                itemBuilder: (context, index) {
                  var rap = apiResultDanhSachRap['content'][index];
                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    color: Colors.grey[800], // Màu nền của Card
                    child: ListTile(
                      leading: Image.network(
                        rap['logo'],
                        width: 50,
                        height: 50,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset('assets/images/null.png',
                              width: 50, height: 50);
                        },
                      ),
                      title: Text(
                        'Tên Rạp : ${rap['tenHeThongRap']}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white, // Màu chữ của title
                        ),
                      ),
                      subtitle: Text(
                        'Kí Hiệu: ${rap['biDanh']}',
                        style: const TextStyle(
                          color: Colors.white70, // Màu chữ của subtitle
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
