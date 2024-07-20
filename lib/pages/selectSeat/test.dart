import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final String maLichChieu;
  final List<dynamic> selectedSeats;

  DetailPage({Key? key, required this.maLichChieu, required this.selectedSeats})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Mã Lịch Chiếu: $maLichChieu"),
            Text("Danh Sách Vé:"),
            ...selectedSeats
                .map((seat) =>
                    Text("Mã Ghế: ${seat['maGhe']}, Giá Vé: ${seat['giaVe']}"))
                .toList(),
          ],
        ),
      ),
    );
  }
}
