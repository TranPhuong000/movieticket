import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie/api_service.dart';
import 'package:movie/pages/checkoutPage/checkoutPage.dart';
import 'package:movie/pages/selectSeat/arrowBack.dart';
import 'package:movie/pages/selectSeat/info.dart';

class SelectSeatPage extends StatefulWidget {
  final String maLichChieu;
  const SelectSeatPage({super.key, required this.maLichChieu});

  @override
  State<SelectSeatPage> createState() => _SelectSeatPageState();
}

class _SelectSeatPageState extends State<SelectSeatPage> {
  dynamic thongTinPhim;
  List<dynamic> danhSachGhe = [];
  final ApiService apiService =
      ApiService(baseUrl: 'https://movienew.cybersoft.edu.vn');
  bool isLoading = true;
  List<int> selectedSeats = [];
  List<String> selectedSeatNames = [];

  Future<void> fetchDanhSachRapChieu() async {
    try {
      final int maLichChieuInt = int.tryParse(widget.maLichChieu) ?? 0;
      final result = await apiService.getRequest(
        '/api/QuanLyDatVe/LayDanhSachPhongVe?MaLichChieu=$maLichChieuInt',
        {
          'Content-Type': 'application/json',
          'MaLichChieu': maLichChieuInt.toString(),
          'TokenCybersoft':
              'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0ZW5Mb3AiOiJCb290Y2FtcCA2NCIsIkhldEhhblN0cmluZyI6IjA4LzA5LzIwMjQiLCJIZXRIYW5UaW1UaW1lIjoiMTcyNTc1MzYwMDAwMCIsIm5iZiI6MTY5NTkyMDQwMCwiZXhwIjoxNzI1OTAxMjAwfQ.fWIHiHRVx9B7UlCgFCwvvXAlcVc-I-RB603rEDsM_wI',
        },
      );

      setState(() {
        thongTinPhim = result['content']['thongTinPhim'];
        danhSachGhe = (result['content']['danhSachGhe'] as List<dynamic>)
            .take(80)
            .toList(); // Lấy 80 ghế đầu tiên
        isLoading = false;
      });
    } catch (e) {
      print('Error: $e');
      setState(() {
        isLoading = false;
      });
      // Show error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching data: $e')),
      );
    }
  }

  @override
  void initState() {
    fetchDanhSachRapChieu();
    super.initState();
  }

  int calculateTotalPrice() {
    int total = 0;
    for (var maGhe in selectedSeats) {
      var ghe = danhSachGhe.firstWhere((ghe) => ghe['maGhe'] == maGhe);
      total += (ghe['giaVe'] as num).toInt(); // Ép kiểu giá trị giaVe thành int
    }
    return total;
  }

  List<String> getSelectedSeatNames() {
    return selectedSeats.map((maGhe) {
      var ghe = danhSachGhe.firstWhere((ghe) => ghe['maGhe'] == maGhe);
      return ghe['tenGhe'] as String;
    }).toList();
  }

  Widget buildSeatList(List<dynamic> danhSachGhe) {
    return Wrap(
      spacing: 5,
      runSpacing: 5,
      children: danhSachGhe.map((ghe) {
        final isSelected = selectedSeats.contains(ghe['maGhe']);
        return GestureDetector(
          onTap: ghe['daDat']
              ? null
              : () {
                  setState(() {
                    if (isSelected) {
                      selectedSeats.remove(ghe['maGhe']);
                      selectedSeatNames.remove(ghe['tenGhe']);
                    } else {
                      selectedSeats.add(ghe['maGhe']);
                      selectedSeatNames.add(ghe['tenGhe']);
                    }
                  });
                },
          child: Container(
            width: 40, // Adjust the width to fit your design
            height: 40, // Adjust the height to fit your design
            decoration: BoxDecoration(
              color: ghe['daDat']
                  ? Colors.grey
                  : isSelected
                      ? Colors.blue
                      : Colors.white, // Màu mặc định của ghế
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black),
            ),
            child: Center(
              child: Text(
                ghe['tenGhe'],
                style: TextStyle(
                  color: ghe['daDat'] ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedSeatsCount = selectedSeats.length;
    final ticketPrice = calculateTotalPrice();
    final seatNames = getSelectedSeatNames();
    final formattedTicketPrice =
        NumberFormat.currency(locale: 'vi_VN', symbol: 'VND')
            .format(ticketPrice);

    return Scaffold(
      backgroundColor: Colors.black, // Màu nền mặc định của trang
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const ArrowBack(),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    thongTinPhim != null
                        ? thongTinPhim['tenPhim']
                        : 'Loading...',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    thongTinPhim != null ? thongTinPhim['tenCumRap'] : '',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildLegend(Colors.white, ' Chưa đặt'),
                      const SizedBox(width: 10),
                      buildLegend(Colors.grey, ' Đã đặt'),
                      const SizedBox(width: 10),
                      buildLegend(Colors.blue, ' Đang Chọn'),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Expanded(
                  child: buildSeatList(danhSachGhe),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 30, right: 30),
                  height: 20,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: Colors.lightBlue,
                  ),
                  child: const Center(
                    child: Text(
                      'Screen',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.black,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Giá vé ($selectedSeatsCount vé)',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      Text(
                        formattedTicketPrice,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      ElevatedButton(
                        onPressed: selectedSeats.isEmpty
                            ? null
                            : () {
                                final ticketInfo = TicketInfo(
                                  maLichChieu:
                                      int.tryParse(widget.maLichChieu) ?? 0,
                                  danhSachVe: selectedSeats.map((maGhe) {
                                    var ghe = danhSachGhe.firstWhere(
                                        (ghe) => ghe['maGhe'] == maGhe);
                                    return SeatInfo(
                                      maGhe: (ghe['maGhe'] as num).toInt(),
                                      giaVe: (ghe['giaVe'] as num).toInt(),
                                    );
                                  }).toList(),
                                );

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CheckOutPage(
                                      ticketInfo: ticketInfo,
                                      thongTinPhim: thongTinPhim,
                                      selectedSeatsCount: selectedSeatsCount,
                                      ticketPrice: ticketPrice,
                                      selectedSeatNames: seatNames,
                                    ),
                                  ),
                                );
                              },
                        child: const Text('Đặt vé'),
                      )
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Widget buildLegend(Color color, String text) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          color: color,
        ),
        const SizedBox(width: 5),
        Text(
          text,
          style: const TextStyle(
              color: Colors.white), // Màu chữ mặc định của chú thích
        ),
      ],
    );
  }
}
